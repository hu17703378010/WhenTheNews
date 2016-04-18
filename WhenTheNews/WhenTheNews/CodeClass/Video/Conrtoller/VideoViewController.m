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
#import <AVFoundation/AVFoundation.h>

#import <MediaPlayer/MediaPlayer.h>

@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,VideoViewCellDelegate>

@property(nonatomic,strong) NSArray *dataArray;

@property(nonatomic,strong) NSArray *falseArray;

@property(nonatomic,strong) NSMutableArray *listArray;

@property(nonatomic,strong) UITableView *videoTableView;

@property(nonatomic,strong) UIScrollView *videoScrollView;

@property(nonatomic,strong) NSString *str;


@end

@implementation VideoViewController


- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.navigationItem.title = @"视频";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataArray = [NSArray arrayWithObjects:@"推荐",@"搞笑",@"美女",@"新闻现场",@"萌物",@"体育",@"黑科技",@"八卦", nil];
    
    _falseArray = [NSArray arrayWithObjects:RECOMMENDED_URL,FUNNY_URL,BEAUTY_URL,SCENE_URL,CONTENT_URL,SPORTS_VIDEO_URL,BLACKSCIENCEANDTECHNOLOGY_URL,GOSSIP_URL, nil];
    
    
    
    [self loadScrollView];
    [self loadHeaderView];
    [self requestData];
    
}

- (void)loadScrollView{
    _videoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 94, SCREEN_WIDTH, ScreenHeight- 94-46)];
    _videoScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.falseArray.count, _videoScrollView.frame.size.height);
    _videoScrollView.pagingEnabled = YES;
    _videoScrollView.bounces = NO;
    _videoScrollView.showsHorizontalScrollIndicator = NO;
    _videoScrollView.directionalLockEnabled = NO;
    _videoScrollView.delegate = self;
    [self.view addSubview:_videoScrollView];
    for (int i = 0; i < self.falseArray.count; i++) {
        _videoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, _videoScrollView.frame.size.height) style:(UITableViewStylePlain)];
        _str = self.falseArray[i];
        _videoTableView.delegate = self;
        _videoTableView.dataSource = self;
     
        
        [self.videoScrollView addSubview:_videoTableView];
        [_videoTableView registerClass:[VideoViewCell class] forCellReuseIdentifier:@"cell"];
    }
    
    
}
- (void)loadHeaderView{
    NSInteger typeNum = self.falseArray.count;//按钮的个数
    UIScrollView *typeScrollView = [[UIScrollView alloc]init];
    typeScrollView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 30);
    typeScrollView.tag = 8080;
    typeScrollView.showsHorizontalScrollIndicator = NO;
    typeScrollView.showsVerticalScrollIndicator = NO;
    typeScrollView.contentSize = CGSizeMake((SCREEN_WIDTH/4)*typeNum, 30);
    [self.view addSubview:typeScrollView];
    for (int i = 0; i < typeNum; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * (ScreenWidth/ 4), 2,SCREEN_WIDTH/4, 26);
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
        [typeScrollView addSubview:btn];
    }
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(5, 28, SCREEN_WIDTH/4 - 10, 4)];
    lineView.backgroundColor = [UIColor redColor];
    lineView.tag = 300;
    [typeScrollView addSubview:lineView];
}
/**
 *  typeScrollView 上的按钮点击方法
 */
- (void)selectTableView:(UIButton *)btn{
    UIView *view = [self.view viewWithTag:300];
    _videoScrollView.contentOffset = CGPointMake(ScreenWidth * (btn.tag - 800), 0);
    view.frame = CGRectMake(2 + (ScreenWidth - 4) / 4 *(_videoScrollView.contentOffset.x / ScreenWidth), 28, ScreenWidth/4, 2);
    for (int i = 0; i < self.falseArray.count; i++) {
        UIButton *btn1 = (UIButton *)[self.view viewWithTag:800 + i];
        btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
}
/**
 *  scrollView的代理方法
 *
 */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIView *view = [self.view viewWithTag:300];
    view.frame = CGRectMake(2 + ScreenWidth / 4 *(_videoScrollView.contentOffset.x /ScreenWidth), 28, ScreenWidth / 4, 2);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    UIButton *btn = (UIButton *)[self.view viewWithTag:800 + (int)_videoScrollView.contentOffset.x / ScreenWidth];
    [self selectTableView:btn];
    
    CGFloat f = _videoScrollView.contentOffset.x;
    
    UIScrollView *sc = (UIScrollView *)[self.view viewWithTag:8080];
    if (f > 3*ScreenWidth) {
        sc.contentOffset = CGPointMake(ScreenWidth, 0);
    }else if (f < 4*ScreenWidth){
        sc.contentOffset = CGPointMake(0, 0);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ([UIScreen mainScreen].bounds.size.height-108)/2.5;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (self.listArray.count > 0) {
        cell.model = self.listArray[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    return nil;
    
}

#pragma mark ----- 跳转到视频播放界面

-(void)getVideoURL:(NSString *)url title:(NSString *)title{
    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:url]];
    [player.moviePlayer setControlStyle:(MPMovieControlStyleFullscreen)];
    [player.moviePlayer setScalingMode:(MPMovieScalingModeAspectFit)];
    [self.view addSubview:player.view];
    [self presentMoviePlayerViewControllerAnimated:player];
    [player.moviePlayer play];
    
}
- (void)requestData{
    
    NSString *string = [NSString stringWithFormat:@"http://c.3g.163.com/nc/video/Tlist/%@/0-10.html",_str];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    __block typeof(self) wSelf = self;
    [manager GET:string parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *array = [dic valueForKey:_str];
        for (NSDictionary *dic2 in array) {
            
            //KVC
            VideoModel *model = [[VideoModel alloc]init];
            [model setValuesForKeysWithDictionary:dic2];
            [wSelf.listArray addObject:model];
            
        }
        [_videoTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
