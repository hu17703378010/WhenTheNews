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
#import "AFNetworkActivityIndicatorManager.h"

#define CELL @"topic"
#define TOPICURL @"http://c.m.163.com/newstopic/list/expert/0-10.html"

@interface TopicViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) AFHTTPSessionManager *session;
@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"问吧" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 65) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self createData];
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicTableViewCell" bundle:nil] forCellReuseIdentifier:CELL];
    
}

- (void)createData {
    self.dataArray = [NSMutableArray array];
        self.session = [AFHTTPSessionManager manager];
        self.session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
            [self.session GET:TOPICURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                NSDictionary *dict = responseObject[@"data"];
                for (NSDictionary *dic1 in dict[@"expertList"]) {
                    TopicModel *model = [[TopicModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic1];
                    [self.dataArray addObject:model];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
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
