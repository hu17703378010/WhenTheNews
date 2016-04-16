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

@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate>

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
    [self loadTableView];

}

- (void)loadScrollView{
    _videoScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _videoScrollView.contentOffset = CGPointMake(SCREEN_WIDTH * 8, SCREEN_HEIGHT);
    _videoScrollView.bounces = NO;
    _videoScrollView.showsHorizontalScrollIndicator = NO;
    _videoScrollView.showsVerticalScrollIndicator = NO;

    [self.view addSubview:_videoScrollView];
    
}

- (void)loadTableView{
    _videoTableView = [[UITableView alloc]initWithFrame:CGRectMake(40, 2, SCREEN_WIDTH, SCREEN_HEIGHT - 40) style:UITableViewStylePlain];
    _videoTableView.delegate = self;
    _videoTableView.dataSource = self;
   // self.videoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.videoTableView.rowHeight = 160;
    [self.videoScrollView addSubview:_videoTableView];
    [_videoTableView registerClass:[VideoViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
