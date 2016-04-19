//
//  TopicDetailViewController.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 HCC. All rights reserved.
//

/*
 http://c.m.163.com/newstopic/qa/EX6025502453593172562.html
 */

#import "TopicDetailViewController.h"
#import "TopicDetailModel.h"
#import "DetailTopicTableViewCell.h"
#import "DetailAAndQTableViewCell.h"
#import "TopicAnswerModel.h"
#import "TopicQuestionModel.h"

#import <UIImageView+WebCache.h>
#import "AFNetWorking.h"

#define TOP @"http://c.m.163.com/newstopic/qa/"
#define TAIL @".html"
#define CELL @"cell"
#define FIRST @"first"
#define SECOND @"second"
@interface TopicDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) AFHTTPSessionManager *session;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *hotLiatArray;//
@property (nonatomic,strong) NSMutableArray *latestArray;//
@property (nonatomic,strong) NSMutableArray *answerArray;
@property (nonatomic,strong) NSMutableArray *questionArray;
@property (nonatomic,strong) UISegmentedControl *segment;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *aliasLabel;
@property (nonatomic,strong) UILabel *concernCountLabel;


@end

@implementation TopicDetailViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)hotLiatArray {
    if (!_hotLiatArray) {
        _hotLiatArray = [NSMutableArray array];
    }
    return _hotLiatArray;
}

- (NSMutableArray *)latestArray {
    if (!_latestArray) {
        _latestArray = [NSMutableArray array];
    }
    return _latestArray;
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
    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//     self.navigationController.navigationBar.alpha = 0;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<--" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
//    [self.navigationItem.leftBarButtonItem setBackgroundIma  ge:[UIImage imageNamed:@"b.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"最新", @"最热"]];
    self.segment.frame = CGRectMake(270, 5, 100, 30);
    [self.segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];

    [self createView];
    [self createData];
    
   
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 - 64, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    self.imageView = imageView;
    self.imageView.backgroundColor = [UIColor greenColor];
    [self.headView addSubview:self.imageView];
    self.imageView.userInteractionEnabled = YES;
    self.headView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[DetailTopicTableViewCell class] forCellReuseIdentifier:FIRST];
    [self.tableView registerClass:[DetailAAndQTableViewCell class] forCellReuseIdentifier:SECOND];
}

- (void)createView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, ScreenWidth - 40, 40)];
    label.backgroundColor = [UIColor grayColor];
    self.aliasLabel.numberOfLines = 0;
    [self.imageView addSubview:label];
    
    self.concernCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, ScreenWidth - 100, 20)];
    self.concernCountLabel.backgroundColor = [UIColor yellowColor];
    self.concernCountLabel.font = [UIFont systemFontOfSize:12];
    [self.imageView addSubview:self.concernCountLabel];
}

- (void)setDataWithModel:(TopicDetailModel *)model {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.picurl]];
//    self.aliasLabel.text = model.alias;
//    self.concernCountLabel.text = model.concernCount;
}

- (void)segmentAction:(UISegmentedControl *)sender {
              
}

- (void)leftAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createData {
    self.session = [AFHTTPSessionManager manager];
    self.session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    NSString *url = [NSString stringWithFormat:@"%@%@%@", TOP, self.expertId, TAIL];
    [self.session GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        NSDictionary *dic = responseObject[@"data"];
        NSDictionary *dic1 = dic[@"expert"];
        TopicDetailModel *model = [[TopicDetailModel alloc] init];
        
        [model setValuesForKeysWithDictionary:dic1];
        [self.dataArray addObject:model];
        for (NSDictionary *dict in dic[@"hotList"]) {
//            TopicAnswerModel *answerModel = [[TopicAnswerModel alloc] init];
////            NSLog(@"dict = %@", dict);
//            NSDictionary *dicAnswer = dict[@"answer"];
////            NSLog(@"dicAnswer = %@", dicAnswer);
//            [answerModel setValuesForKeysWithDictionary:dicAnswer];
//            NSLog(@"model ======= %@", answerModel);
//            [self.answerArray addObject:answerModel];
            TopicQuestionModel *model = [[TopicQuestionModel alloc] init];
            NSDictionary *dicQuestion = dict[@"question"];
            [model setValuesForKeysWithDictionary:dicQuestion];
            [self.questionArray addObject:model];
        }
        NSLog(@"answerArray = %@", self.answerArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@", error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TopicDetailModel *model = self.dataArray[indexPath.row];
        return 78 + [self stringHeight:model.Description];
    }else {
        TopicQuestionModel *model = self.questionArray[indexPath.row];
        return 70 + [self stringHeight:model.content];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArray.count;
    }else {
        return self.questionArray.count;
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
    }else {
        TopicQuestionModel *moddel1 = self.questionArray[indexPath.row];
        DetailAAndQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SECOND forIndexPath:indexPath];
        cell.userContentLabel.frame = CGRectMake(55, 30, 285, [self stringHeight:moddel1.content]);
        [cell setDataWithModel:moddel1];
        return cell;
    }
}

//自适应高度
- (CGFloat)stringHeight:(NSString *)string {
    CGRect temp = [string boundingRectWithSize:CGSizeMake(285, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return temp.size.height;
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

- (void)createAnswerView {
    
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
