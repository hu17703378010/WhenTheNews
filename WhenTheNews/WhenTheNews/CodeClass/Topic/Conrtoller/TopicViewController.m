//
//  TopicViewController.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

/*
 http://c.3g.163.com/newstopic/list/expert/0-10.html
 http://c.m.163.com/newstopic/list/expert/0-10.html
 EX6025502453593172562
 */


#import "TopicViewController.h"
#import "TopicTableViewCell.h"
#import "TopicModel.h"
#import "TopicDetailViewController.h"

#import "AFNetWorking.h"
#import "MJRefresh.h"

#define CELL @"topic"
#define TOPICURL @"http://c.m.163.com/newstopic/list/expert/0-10.html"

@interface TopicViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL isRefresh;
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) AFHTTPSessionManager *session;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger page;

@end

@implementation TopicViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.page = 0;
    
    self.navigationItem.title = @"问吧";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 65) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self createData];
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicTableViewCell" bundle:nil] forCellReuseIdentifier:CELL];
    
    //下拉刷新 上拉加载
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headFresh)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footFresh)];
}

- (void)headFresh {
    self.page = 0;
    isRefresh = YES;
    [self createData];
}

- (void)footFresh {
    self.page += 10;
    [self createData];
    [self.tableView.mj_footer endRefreshing];
}

- (void)createData {
    //下拉刷新
    if (isRefresh == YES) {
        isRefresh = NO;
        [self.dataArray removeAllObjects];
    }
        self.session = [AFHTTPSessionManager manager];
        self.session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    NSString *string = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/expert/%ld-10.html", self.page];
            [self.session GET:string parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                NSDictionary *dict = responseObject[@"data"];
                for (NSDictionary *dic1 in dict[@"expertList"]) {
                    TopicModel *model = [[TopicModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic1];
                    [self.dataArray addObject:model];
            }
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
          }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL forIndexPath:indexPath];
    TopicModel *model = self.dataArray[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicModel *model = self.dataArray[indexPath.row];
    TopicDetailViewController *topicVC = [[TopicDetailViewController alloc] init];
    topicVC.expertId = model.expertId;
    [self.navigationController pushViewController:topicVC animated:YES];
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
