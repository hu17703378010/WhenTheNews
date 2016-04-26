//
//  ReadingViewController.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "ReadingViewController.h"
#import "readFristCell.h"
#import "ReadScendCell.h"
#import "AFNetworking.h"
#import "MJRefresh.h"

#import "ReaddetailController.h"


@interface ReadingViewController ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL isRefresh;
}

@property (nonatomic,strong) UITableView *readTableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end



@implementation ReadingViewController


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"阅读";
    
    _readTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 44) style:UITableViewStylePlain];
    _readTableView.delegate = self;
    _readTableView.dataSource = self;
    _readTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headrefesh)];
    _readTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefesh)];
    [self.view addSubview:self.readTableView];
    
    
    [_readTableView registerClass:[readFristCell class] forCellReuseIdentifier:@"cell1"];
    [_readTableView registerClass:[ReadScendCell class] forCellReuseIdentifier:@"cell2"];
    
    [self request];
}

#pragma mark ------ 下拉
-(void)headrefesh{
    isRefresh = YES;
    
    [self request];
    
}
#pragma mark ------ 上拉
-(void)footRefesh{
    
    
    [self request];
    
    
}

- (void)request{
    
    NSString *string = [NSString stringWithFormat:@"http://c.3g.163.com/recommend/getSubDocPic?passport=&devId=863654024602484&size=20&from=yuedu"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:string parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
    NSArray *data = [dic valueForKey:@"推荐"];
    
    if (isRefresh == YES) {
        [self.dataArray removeAllObjects];
    }
    for (NSDictionary *dic1 in data) {
        ReadingModel *model = [[ReadingModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [self.dataArray addObject:model];
    }
    [_readTableView reloadData];
    [_readTableView.mj_header endRefreshing];
    [_readTableView.mj_footer endRefreshing];

    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_readTableView.mj_header endRefreshing];
        [_readTableView.mj_footer endRefreshing];
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReadingModel *model = self.dataArray[indexPath.row];
    NSArray *boardid = [NSArray arrayWithArray:model.imgnewextra];
    if (boardid.count < 1) {
        readFristCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }else{
        ReadScendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // [tableView deselectRowAtIndexPath:indexPath animated:YES];

  
    
    ReadingModel *model = self.dataArray[indexPath.row];
    
    ReaddetailController *detail = [[ReaddetailController alloc]init];
    detail.titleString = model.title;
    detail.URLStr = model.Id;
    
    [self.navigationController pushViewController:detail animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
