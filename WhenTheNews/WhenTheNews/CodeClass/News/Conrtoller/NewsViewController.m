//
//  NewsViewController.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "NewsViewController.h"


#import "NewsModel.h"
#import "ImgAndContextTableViewCell.h"
#import "ImgAndTitleTableViewCell.h"
#import "MoreImgTableViewCell.h"
#import "NewsView.h"

#import <AFHTTPSessionManager.h>


@interface NewsViewController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *listArray;
@property(nonatomic,strong)NSArray *headerArray;
@property(nonatomic,strong)NSArray *newsArray;
@property(nonatomic,strong)UIScrollView *newsScrollView;
@property(nonatomic,strong)UIScrollView *headerScrollView;

@property(nonatomic,strong)UITableView *tabble;


@end

@implementation NewsViewController

-(NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"新闻";
    self.headerArray = @[@"轻松一刻",@"娱乐",@"科技",@"财经",@"时尚",@"军事",@"历史",@"独家",@"家具",@"体育"];
    self.newsArray = @[EASYMOMENT_URL,ENTERTAINMENT_URL,SCIENCE_URL,FINANCE_URL,FASHION_URL,MILITARY_URL,HISTORY_URL,EXCLUSIVE_URL,FURNITURE_URL,SPORTS_URL];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadHeaderView];
        [self loadScrollView];
        
    });
    
    
    
    
    //self.headerScrollView.backgroundColor = [UIColor redColor];
    
    //[self requestSessionData:EASYMOMENT_URL];
}
- (void)loadHeaderView{
    self.headerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 30)];
    self.headerScrollView.contentSize = CGSizeMake(self.headerArray.count * ScreenWidth/4, 0);
    self.headerScrollView.showsHorizontalScrollIndicator = NO;
    self.headerScrollView.contentOffset = CGPointMake(0, 0);
    
    float heiht = self.headerScrollView.bounds.size.height - 3;
    
    for (int i = 0; i < self.headerArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.headerArray[i] forState:(UIControlStateNormal)];
        btn.frame = CGRectMake(i * ScreenWidth/4, 0, ScreenWidth/4, heiht);
        btn.tag = 10000+i;
        [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.headerScrollView addSubview:btn];
        if (i == 0) {
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, heiht, ScreenWidth/4 - 20, 3)];
    lineView.tag = 555;
    lineView.backgroundColor = [UIColor redColor];
    [self.headerScrollView addSubview:lineView];
    [self.view addSubview:self.headerScrollView];

}

- (void)btnAction:(UIButton *)sender{
    NSInteger index = sender.tag;
    CGPoint offset = self.newsScrollView.contentOffset;
    offset.x = index * self.newsScrollView.frame.size.width;
    [self.newsScrollView setContentOffset:offset animated:YES];
}

- (void)loadScrollView{
    
    float height = ScreenHeight - CGRectGetHeight(self.headerScrollView.frame);
    self.newsScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerScrollView.frame), ScreenWidth, ScreenHeight - CGRectGetHeight(self.headerScrollView.frame))];
    
    self.newsScrollView.contentSize = CGSizeMake(ScreenWidth * self.headerArray.count, 0);
    self.newsScrollView.contentOffset = CGPointMake(0, 0);
    self.newsScrollView.showsVerticalScrollIndicator = NO;
    self.newsScrollView.pagingEnabled = YES;
    for (int i = 0 ; i < self.headerArray.count; i++) {
        self.tabble = [[UITableView alloc]initWithFrame:CGRectMake(i * ScreenWidth, 0, ScreenWidth, height)];
        self.tabble.tag = 2000 + i;
        self.tabble.delegate = self;
        self.tabble.dataSource = self;
        [self.newsScrollView addSubview:self.tabble];
        //[self requestData:@"T1348648517839"];
        
        [self.tabble registerNib:[UINib nibWithNibName:@"ImgAndContextTableViewCell" bundle:nil] forCellReuseIdentifier:@"ImgAndContextTableViewCell"];
        [self.tabble registerNib:[UINib nibWithNibName:@"ImgAndTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"ImgAndTitleTableViewCell"];
        [self.tabble registerNib:[UINib nibWithNibName:@"MoreImgTableViewCell" bundle:nil] forCellReuseIdentifier:@"MoreImgTableViewCell"];
#warning !!!!!!!
        //应该拖动的时候调用
        [self requestSessionData:self.newsArray[i]];
    }
    
    [self.view addSubview:self.newsScrollView];
}

//AFNet
-(void)requestAFNData:(NSString *)typeStr{
    
    NSString *string = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/T1348648517839/0-20.html"];
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:string parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *array = dic[typeStr];
        
        for (NSDictionary *temp in array) {
            NewsModel *model = [[NewsModel alloc]init];
            [model setValuesForKeysWithDictionary:temp];
            [_listArray addObject:model];
        }
        
        [self.tabble reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求error");
    }];
    
    
    
}

-(void)requestSessionData:(NSString *)typeStr{
    
    NSMutableArray *mutarray = [NSMutableArray array];
    NSString *str = [NSString stringWithFormat:NEWS_URL,typeStr,0];
    
    __weak NewsViewController *newsVC = self;
    [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:str] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil]);
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = dic[typeStr];
        for (NSDictionary *temp in array) {
            NewsModel *model = [[NewsModel alloc]init];
            [model setValuesForKeysWithDictionary:temp];
            [mutarray addObject:model];
        }
        newsVC.listArray = [NSMutableArray arrayWithArray:mutarray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tabble reloadData];
        });
        
        
        
    }]resume];
    
    
    
}

#pragma mark - tabble delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *model = [[NewsModel alloc]init];
    if (self.listArray.count > 0) {
        model = self.listArray[indexPath.row];
    }
    if (model.photosetID!=nil) {
        MoreImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreImgTableViewCell"];
        [cell setModelContentToCell:model];
        return cell;
    }else if (model.imgType !=nil){
        ImgAndTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImgAndTitleTableViewCell"];
        [cell setModelContentToCell:model];
        return cell;
    }else{
        ImgAndContextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImgAndContextTableViewCell"];
        [cell setModelContentToCell:model];
        return cell;
    }
    return nil;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *model = [[NewsModel alloc]init];
    if (self.listArray.count > 0) {
        model = self.listArray[indexPath.row];
    }
    if (model.photosetID!=nil) {
        return 150;
    }else if (model.imgType !=nil){
        
        return 200;
    }else{
        
        return 130;
    }
    return 0;
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
