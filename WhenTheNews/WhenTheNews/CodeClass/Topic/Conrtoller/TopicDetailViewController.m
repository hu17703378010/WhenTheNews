//
//  TopicDetailViewController.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 HCC. All rights reserved.
//

/*
 http://c.m.163.com/newstopic/qa/EX6025502453593172562.html
 http://c.m.163.com/newstopic/list/latestqa/EX6025502453593172562/0-10.html
 */

#import "TopicDetailViewController.h"
#import "TopicDetailModel.h"
#import "DetailTopicTableViewCell.h"
#import "DetailAAndQTableViewCell.h"
#import "TopicAnswerModel.h"
#import "TopicQuestionModel.h"

#import <UIImageView+WebCache.h>
#import "AFNetWorking.h"
#import "MJRefresh.h"

#define TOP @"http://c.m.163.com/newstopic/qa/"
#define TAIL @".html"
#define FIRST @"first"
#define SECOND @"second"
#define latest @"latest"
#define hot @"hot"
@interface TopicDetailViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    int flag; //0 最新  1 最热
}

@property (nonatomic,strong) AFHTTPSessionManager *session;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *answerArray;
@property (nonatomic,strong) NSMutableArray *questionArray;
@property (nonatomic,strong) NSMutableArray *hotAnswerArray;
@property (nonatomic,strong) NSMutableArray *hotQuestionArray;
@property (nonatomic,strong) UISegmentedControl *segment;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *aliasLabel;
@property (nonatomic,strong) UILabel *concernCountLabel;

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) NSString *string;
@property (nonatomic,assign) NSInteger hotPage;

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,assign) float alpha;
@property (nonatomic,strong) UILabel *naLabel;

@end

@implementation TopicDetailViewController




- (NSMutableArray *)hotAnswerArray {
    if (!_hotAnswerArray) {
        _hotAnswerArray = [NSMutableArray array];
    }
    return _hotAnswerArray;
}

- (NSMutableArray *)hotQuestionArray {
    if (!_hotQuestionArray) {
        _hotQuestionArray = [NSMutableArray array];
    }
    return _hotQuestionArray;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)answerArray {
    if (!_answerArray) {
        _answerArray = [NSMutableArray array];
    }
    return _answerArray;
}

- (NSMutableArray *)questionArray {
    if (!_questionArray) {
        _questionArray = [NSMutableArray array];
    }
    return _questionArray;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.backView.alpha = self.alpha;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.backView.alpha = 1.0;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.backView.alpha = 1.0;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.alpha = 0;
    UIView *backgroundView = [[self.navigationController valueForKey:@"_navigationBar"] valueForKey:@"_backgroundView"];
    backgroundView.backgroundColor = [UIColor colorWithRed:67 green:67 blue:67 alpha:0];
    backgroundView.alpha = self.alpha;
    self.backView = backgroundView;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:67 green:67 blue:67 alpha:1];
    UILabel *naLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, CGRectGetWidth([UIScreen mainScreen].bounds) - 100, 20)];
    naLabel.font = [UIFont systemFontOfSize:13];
    self.naLabel = naLabel;
    [self.navigationController.navigationBar addSubview:self.naLabel];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<-" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];

    flag = 0;
    self.page = 0;
    self.hotPage = 0;
    
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"最新", @"最热"]];
    self.segment.selectedSegmentIndex = 0;
    self.segment.frame = CGRectMake(270, 5, 100, 30);
    [self.segment addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventValueChanged];

    [self createView];
    [self createData];
    [self createAnswerAndQuestionData:[NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/latestqa/%@/0-10.html", self.expertId]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[DetailTopicTableViewCell class] forCellReuseIdentifier:FIRST];
    [self.tableView registerClass:[DetailAAndQTableViewCell class] forCellReuseIdentifier:SECOND];
    
    //下拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footFresh)];
}



- (void)footFresh {
    if (flag == 0) {
        self.page += 10;
        self.string = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/%@qa/%@/%ld-10.html", latest, self.expertId, self.page];
    }else {
        self.hotPage += 10;
        self.string = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/%@qa/%@/%ld-10.html", hot, self.expertId, self.hotPage];
    }
    [self createAnswerAndQuestionData:self.string];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)createView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 - 64, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    self.imageView = imageView;
    self.imageView.backgroundColor = [UIColor greenColor];
    [self.imageView addSubview:view];
    self.imageView.userInteractionEnabled = YES;
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    [self.headView addSubview:self.imageView];
    self.headView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = self.headView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, ScreenWidth - 40, 60)];
    self.aliasLabel = label;
    self.aliasLabel.numberOfLines = 0;
    self.aliasLabel.textColor = [UIColor whiteColor];
    self.aliasLabel.font = [UIFont systemFontOfSize:14];
    self.aliasLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    self.concernCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 130, ScreenWidth - 100, 20)];
    self.concernCountLabel.font = [UIFont systemFontOfSize:12];
    self.concernCountLabel.textAlignment = NSTextAlignmentCenter;
    self.concernCountLabel.textColor = [UIColor whiteColor];
    [view addSubview:self.concernCountLabel];
}

- (void)setDataWithModel:(TopicDetailModel *)model {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.picurl]];
    self.aliasLabel.text = model.alias;
    NSString *str = model.concernCount;
    NSInteger con = [str integerValue];
    if (con >= 10000) {
        self.concernCountLabel.text = [NSString stringWithFormat:@"-- %0.1f万关注 --", (float)con / 10000];
    }else {
        self.concernCountLabel.text = [NSString stringWithFormat:@"-- %@关注 --", model.concernCount];
    }
}

- (void)changeAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        flag = 0;
        self.string = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/%@qa/%@/%ld-10.html", latest, self.expertId, self.page];
        [self createAnswerAndQuestionData:self.string];
        
    }else {
        flag = 1;
        self.string = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/%@qa/%@/%ld-10.html", hot, self.expertId, self.hotPage];
        [self createAnswerAndQuestionData:self.string];
    }
}

- (void)leftAction {
    [self.naLabel removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

//个人信息
- (void)createData {
    self.session = [AFHTTPSessionManager manager];
    self.session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    NSString *url = [NSString stringWithFormat:@"%@%@%@", TOP, self.expertId, TAIL];
    [self.session GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        [self.dataArray removeAllObjects];
        NSDictionary *dic = responseObject[@"data"];
        NSDictionary *dic1 = dic[@"expert"];
        TopicDetailModel *model = [[TopicDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:dic1];
        [self.dataArray addObject:model];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@", error);
    }];
}

//question 和 answer
- (void)createAnswerAndQuestionData:(NSString *)url {
    self.session = [AFHTTPSessionManager manager];
    self.session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    [self.session GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        NSArray *array = responseObject[@"data"];
            if (1 == flag) {
                for (NSDictionary *dic in array) {
                    NSDictionary *dict = dic[@"question"];
                    TopicQuestionModel *model = [[TopicQuestionModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.hotQuestionArray addObject:model];
                    for (NSDictionary *dic in array) {
                        NSDictionary *dict = dic[@"answer"];
                        TopicAnswerModel *model = [[TopicAnswerModel alloc] init];
                        [model setValuesForKeysWithDictionary:dict];
                        [self.hotAnswerArray addObject:model];
                    }
                }
            }else {
                for (NSDictionary *dic in array) {
                    NSDictionary *dict = dic[@"question"];
                    TopicQuestionModel *model = [[TopicQuestionModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.questionArray addObject:model];
                    for (NSDictionary *dic in array) {
                        NSDictionary *dict = dic[@"answer"];
                        TopicAnswerModel *model = [[TopicAnswerModel alloc] init];
                        [model setValuesForKeysWithDictionary:dict];
                        [self.answerArray addObject:model];
                    }
                }
            }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@", error);
    }];
}

#pragma mark -------------- tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TopicDetailModel *model = self.dataArray[indexPath.row];
        return 50 + [self stringHeight:model.Description];
    }else {
        if (flag == 0) {
            TopicQuestionModel *model = self.questionArray[indexPath.row];
            TopicAnswerModel *modelA = self.answerArray[indexPath.row];
            return 70 + [self stringHeight:model.content] + 30 + [self stringHeight:modelA.content];
        }else {
            TopicQuestionModel *model = self.hotQuestionArray[indexPath.row];
            TopicAnswerModel *modelA = self.hotAnswerArray[indexPath.row];
            return 70 + [self stringHeight:model.content] + 100 + [self stringHeight:modelA.content];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArray.count;
    }else {
        if (flag == 0) {
            return self.questionArray.count;
        }else {
            return self.hotQuestionArray.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TopicDetailModel *model = [self.dataArray objectAtIndex:indexPath.row];
        DetailTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FIRST forIndexPath:indexPath];
        cell.headImageView.layer.masksToBounds = YES;
        cell.headImageView.layer.cornerRadius = 20;
        NSLog(@"width = %f, height = %f", cell.descriptionLabel.frame.size.width, cell.descriptionLabel.frame.size.height);
        CGRect frame = cell.descriptionLabel.frame;
        NSString *str = NSStringFromCGRect(frame);
        NSLog(@"frame = %@", str);
        cell.descriptionLabel.numberOfLines = 0;
        cell.descriptionLabel.frame = CGRectMake(78, 31, 288, [self stringHeight:model.Description]);
        cell.descriptionLabel.text = model.Description;
        cell.descriptionLabel.font = [UIFont systemFontOfSize:14];
        [self setDataWithModel:model];
        [cell setDataWithModel:model];
        return cell;
    }else{
        DetailAAndQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SECOND forIndexPath:indexPath];
        if (flag == 0) {
            TopicQuestionModel *moddel1 = self.questionArray[indexPath.row];
            TopicAnswerModel *modelA = self.answerArray[indexPath.row];
            [self createWithCell:cell Model:moddel1 endModel:modelA];
        }else {
            TopicQuestionModel *moddel1 = self.hotQuestionArray[indexPath.row];
            TopicAnswerModel *modelA = self.hotAnswerArray[indexPath.row];
            [self createWithCell:cell Model:moddel1 endModel:modelA];
        }
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    headerLabel.textColor = [UIColor grayColor];
    headerLabel.font = [UIFont systemFontOfSize:12];
    if (section == 1) {
        for (TopicDetailModel *model in self.dataArray) {
            headerLabel.text = [NSString stringWithFormat:@"%@提问 . %@回复", model.questionCount, model.answerCount];
        }
    }
    [view addSubview:headerLabel];
    [view addSubview:self.segment];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        return 44;
    }
    return 0;
}

//自适应高度
- (CGFloat)stringHeight:(NSString *)string {
    CGRect temp = [string boundingRectWithSize:CGSizeMake(285, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return temp.size.height;
}

- (void)createWithCell:(DetailAAndQTableViewCell *)cell Model:(TopicQuestionModel *)model endModel:(TopicAnswerModel *)aModel{
    cell.specialistHeadImageView.frame = CGRectMake(5, [self stringHeight:model.content] + 60, 30, 30);
    cell.specialistNameLabel.frame = CGRectMake(55, [self stringHeight:model.content] + 60, 200, 30);
    cell.answerContentLabel.frame = CGRectMake(55, [self stringHeight:model.content] + 10 + 80, 285, [self stringHeight:aModel.content]);
    cell.userContentLabel.frame = CGRectMake(55, 30, 285, [self stringHeight:model.content]);
    [cell setDataWithModel:model];
    [cell setDataWithAnswerModel:aModel];
}


#pragma mark ---------------- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y - 44;
    CGFloat alpha = 0;
    if (scrollView.contentOffset.y > 50) {
        for (TopicDetailModel *model in self.dataArray) {
            self.naLabel.text = model.alias;
        }
    }else {
        self.naLabel.text = nil;
    }
    if (offset < 0) {
        self.alpha = alpha = 0;
    }else {
        self.alpha = alpha = 1 - ((self.imageView.frame.size.height - 100 - offset) / (self.imageView.frame.size.height - 100));
    }
    self.backView.alpha = alpha;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
