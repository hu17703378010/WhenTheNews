//
//  VideoViewController.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoModel.h"
#import "VideoViewCell.h"
#import "AFNetworking.h"

@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong) NSArray *dataArray;

@property(nonatomic,strong) NSArray *falseArray;

@property(nonatomic,strong) NSMutableArray *listArray;

@property(nonatomic,strong) UITableView *videoTableView;

@property(nonatomic,strong) UIScrollView *videoScrollView;

@end


@implementation VideoViewController


- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}

- (void)requestData{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"视频";
    
    _dataArray = [NSArray arrayWithObjects:@"推荐",@"搞笑",@"美女",@"新闻现场",@"萌物",@"体育",@"黑科技",@"八卦", nil];
    
    _falseArray = [NSArray arrayWithObjects:RECOMMENDED_URL,FUNNY_URL,BEAUTY_URL,SCENE_URL,CONTENT_URL,SPORTS_VIDEO_URL,BLACKSCIENCEANDTECHNOLOGY_URL,GOSSIP_URL, nil];
    
    
    [self loadScrollView];
    [self loadHeaderView];

}

- (void)loadScrollView{
    _videoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 94, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 94)];
    _videoScrollView.backgroundColor = [UIColor whiteColor];
    _videoScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.falseArray.count, CGRectGetHeight(self.view.bounds) - 143);
    _videoScrollView.pagingEnabled = YES;
    _videoScrollView.bounces = NO;
    _videoScrollView.showsHorizontalScrollIndicator = NO;
    _videoScrollView.directionalLockEnabled = NO;
    _videoScrollView.delegate = self;
    [self.view addSubview:_videoScrollView];
    for (int i = 0; i < self.falseArray.count; i++) {
        _videoTableView = [[UITableView alloc]initWithFrame:CGRectMake( 0 + ScreenWidth * i, 0, ScreenWidth, ScreenHeight - 143) style:UITableViewStylePlain];
        _videoTableView.delegate = self;
        _videoTableView.dataSource = self;
        // self.videoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.videoTableView.rowHeight = 160;
        [self.videoScrollView addSubview:_videoTableView];
        [_videoTableView registerClass:[VideoViewCell class] forCellReuseIdentifier:@"cell"];
        [_videoScrollView addSubview:_videoTableView];
    }
 
}

- (void)loadHeaderView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 30)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    for (int i = 0; i < self.falseArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * (ScreenWidth/ self.falseArray.count), 2, ScreenWidth / self.falseArray.count, 26);
        btn.tag = 800 + i;
        [btn setTitle:self.dataArray[i] forState:UIControlStateNormal];
        
        if (i == 0) {
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(selectTableView:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(2, 28, (ScreenWidth - 4) / self.falseArray.count, 2)];
    lineView.backgroundColor = [UIColor redColor];
    lineView.tag = 300;
    [view addSubview:lineView];
   }
- (void)selectTableView:(UIButton *)btn{
    UIView *view = [self.view viewWithTag:300];
    _videoScrollView.contentOffset = CGPointMake(ScreenWidth * (btn.tag - 800), 0);
    view.frame = CGRectMake(2 + (ScreenWidth - 4) / self.falseArray.count *(_videoScrollView.contentOffset.x / ScreenWidth), 28, (ScreenWidth - 4) / self.falseArray.count, 2);
    for (int i = 0; i < self.falseArray.count; i++) {
        UIButton *btn1 = (UIButton *)[self.view viewWithTag:800 + i];
        btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIView *view = [self.view viewWithTag:300];
    view.frame = CGRectMake(2 + ScreenWidth / self.falseArray.count *(_videoScrollView.contentOffset.x /ScreenWidth), 28, ScreenWidth / self.falseArray.count, 2);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    UIButton *btn = (UIButton *)[self.view viewWithTag:800 + (int)_videoScrollView.contentOffset.x / ScreenWidth];
    [self selectTableView:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
