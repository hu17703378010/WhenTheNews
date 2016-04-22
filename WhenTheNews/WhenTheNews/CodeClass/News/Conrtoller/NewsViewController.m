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

#import "NewsDetailViewController.h"
#import "CyclePhotoViewController.h"
#define BUTTONTAG 10000

@interface NewsViewController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *listArray;
@property(nonatomic,strong)NSArray *headerArray;
@property(nonatomic,strong)NSArray *newsArray;
@property(nonatomic,strong)UIScrollView *newsScrollView;
@property(nonatomic,strong)UIScrollView *headerScrollView;

@property(nonatomic,strong)UITableView *tabble;


@property(nonatomic,strong)NSString *urlTemp;
//当前 btn
@property(nonatomic,assign)NSInteger index;


@end

@implementation NewsViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.listArray = [NSMutableArray array];
    self.title = @"新闻";
    self.headerArray = @[@"独家",@"轻松一刻",@"娱乐",@"科技",@"财经",@"时尚",@"军事",@"历史",@"家具",@"体育"];
    self.newsArray = @[EXCLUSIVE_URL,EASYMOMENT_URL,ENTERTAINMENT_URL,SCIENCE_URL,FINANCE_URL,FASHION_URL,MILITARY_URL,HISTORY_URL,FURNITURE_URL,SPORTS_URL];
    
    [self loadHeaderView];
    [self loadScrollView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"___________%ld",self.newsScrollView.subviews.firstObject.tag);
        if (self.newsScrollView.subviews.firstObject.tag==2000) {
            self.tabble = (UITableView *)[self.view viewWithTag:2000];
            [self requestSessionData:self.newsArray[0]];
        }
    });
    
    
    //self.tabble = [self.newsScrollView viewWithTag:];
    
    //self.headerScrollView.backgroundColor = [UIColor redColor];
    
    //[self requestSessionData:EASYMOMENT_URL];
}


#pragma mark - 标签视图
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
        btn.tag = BUTTONTAG+i;
        [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.headerScrollView addSubview:btn];
        if (i == 0) {
            
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, heiht, ScreenWidth/4 - 20, 3)];
    lineView.tag = 555;
    lineView.backgroundColor = [UIColor redColor];
    [self.headerScrollView addSubview:lineView];
    [self.view addSubview:self.headerScrollView];
    
}

#pragma mark - button点击
- (void)btnAction:(UIButton *)sender{
    NSInteger index = sender.tag - BUTTONTAG;
    CGPoint offset = self.newsScrollView.contentOffset;
    offset.x = index * self.newsScrollView.frame.size.width;
    [self.newsScrollView setContentOffset:offset animated:YES];
    //_newsScrollView.contentOffset = offset;
    
    for (int i = 0; i < self.headerArray.count; i++) {
        UIButton *btn1 = (UIButton *)[self.view viewWithTag:BUTTONTAG + i];
        btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    sender.titleLabel.font = [UIFont systemFontOfSize:14];
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
    self.tabble = (UITableView *)[self.view viewWithTag:2000 + index];
    [self requestSessionData:self.newsArray[index]];
    self.urlTemp = self.newsArray[index];
        
}

#pragma mark - 线的移动
-(void)moreLinde:(NSInteger)index{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            UIView *lineview = [self.view viewWithTag:555];
            lineview.frame = CGRectMake(index * ScreenWidth / 4 + 10, self.headerScrollView.frame.size.height - 3, (ScreenWidth / 4 - 20), 3);
        }];
    });
    
}

#pragma mark - 内容视图
- (void)loadScrollView{
    
    float height = ScreenHeight - CGRectGetHeight(self.headerScrollView.frame);
    self.newsScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerScrollView.frame), ScreenWidth, ScreenHeight - CGRectGetHeight(self.headerScrollView.frame))];
    
    self.newsScrollView.contentSize = CGSizeMake(ScreenWidth * self.headerArray.count, 1);
    self.newsScrollView.backgroundColor = [UIColor grayColor];
    self.newsScrollView.contentOffset = CGPointMake(0, 0);
    self.newsScrollView.showsVerticalScrollIndicator = NO;
    self.newsScrollView.pagingEnabled = YES;
    self.newsScrollView.delegate = self;
    for (int i = 0 ; i < self.headerArray.count; i++) {
        UITableView *tabbleView = [[UITableView alloc]initWithFrame:CGRectMake(i * ScreenWidth, 0, ScreenWidth, height - 64)];
        tabbleView.tag = 2000 + i;
        tabbleView.delegate = self;
        tabbleView.dataSource = self;
        tabbleView.showsVerticalScrollIndicator = NO;
        [self.newsScrollView addSubview:tabbleView];
        [tabbleView registerNib:[UINib nibWithNibName:@"ImgAndContextTableViewCell" bundle:nil] forCellReuseIdentifier:@"ImgAndContextTableViewCell"];
        [tabbleView registerNib:[UINib nibWithNibName:@"ImgAndTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"ImgAndTitleTableViewCell"];
        [tabbleView registerNib:[UINib nibWithNibName:@"MoreImgTableViewCell" bundle:nil] forCellReuseIdentifier:@"MoreImgTableViewCell"];

//        self.tabble = tabbleView;
    }
    
    [self.view addSubview:self.newsScrollView];
}

//AFNet
/*
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
*/

#pragma mark -  数据解析
-(void)requestSessionData:(NSString *)typeStr{
    
    if (self.urlTemp != typeStr) {
        self.urlTemp = typeStr;
        [self.listArray removeAllObjects];
    }
    
    //NSMutableArray *mutarray = [NSMutableArray array];
    NSString *str = [NSString stringWithFormat:NEWS_URL,self.urlTemp,0];
    __block NewsViewController *newsVC = self;
    [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:str] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil]);
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = dic[newsVC.urlTemp];
        for (NSDictionary *temp in array) {
            NewsModel *model = [[NewsModel alloc]init];
            [model setValuesForKeysWithDictionary:temp];
            [_listArray addObject:model];
        }
        //newsVC.listArray = [NSMutableArray arrayWithArray:mutarray];
        
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

#pragma mark - 行高
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

#pragma mark - cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model = self.listArray[indexPath.row];
    
    NewsDetailViewController *newsDVC = [[NewsDetailViewController alloc]init];
    newsDVC.titleName = model.title;
    
    CyclePhotoViewController *cyclePhotoVC = [[CyclePhotoViewController alloc]init];
    cyclePhotoVC.title_name = model.title;
    
    //postid BL43V21N000153N3  http://3g.163.com/news/16/0420/17/BL43V21N000153N3.html
    if (model.url||model.imgType) {
        newsDVC.docid = model.docid;
        [self.navigationController pushViewController:newsDVC animated:YES];
    }
    
    if (model.photosetID) {
        cyclePhotoVC.photo_skipID = model.skipID;
        [self.navigationController pushViewController:cyclePhotoVC animated:YES];
    }
}




#pragma mark - srollViewDelegate
//scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = self.newsScrollView.contentOffset;
    NSInteger index = offset.x / self.newsScrollView.frame.size.width;
    [self moreLinde:index];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset = self.newsScrollView.contentOffset;
    NSInteger index = offset.x / self.newsScrollView.frame.size.width;
    UIButton *btn = (UIButton *)[self.view viewWithTag:BUTTONTAG + index];
    CGPoint headerOffset = self.headerScrollView.contentOffset;
    headerOffset.x = index * btn.bounds.size.width;
    if (index > 3) {
        headerOffset.x = (index - 2) * btn.bounds.size.width;
        [self.headerScrollView setContentOffset:headerOffset animated:YES];
    }
    if (index < 3) {
        [self.headerScrollView setContentOffset:headerOffset animated:YES];
    }
    [self btnAction:btn];
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
