//
//  CyclePhotoViewController.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 HCC. All rights reserved.
//


//http://c.m.163.com/nc/article/%@/full.html
//3R710001|116389 参数 shipID
//http://c.m.163.com/photo/api/set/0001/116389.json
#import "CyclePhotoViewController.h"
#import "AutoView.h"
#import <AFHTTPSessionManager.h>

#define IMAGE_URL @"http://c.m.163.com/photo/api/set/%@.json"
@interface CyclePhotoViewController ()

@property(nonatomic,strong)AutoView *cycleView;

@property(nonatomic,strong)NSMutableArray *imageArray;//图片
@property(nonatomic,strong)NSMutableArray *titleArray;//标题

@end

@implementation CyclePhotoViewController



-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.title = self.title_name;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    self.tabBarController.tabBar.hidden = YES;
    [self requestData];
    
   // self.navigationController.
}

-(void)setCycleviewInTheView{
    self.cycleView = [AutoView imageScrollViewWithFrame:[UIScreen mainScreen].bounds imageLinkURL:self.imageArray titleArr:self.titleArray placeHolderImageName:nil pageControlShowStyle:(UIPageControlShowStyleNone)];
    
    self.cycleView.isNeedCycleRoll = NO;
    [self.view addSubview:self.cycleView];
}

-(void)requestData{
    NSArray *skipArray = [self.photo_skipID componentsSeparatedByString:@"|"];
    
    NSString *urlString_skipID = [NSString stringWithFormat:@"%@/%@",[skipArray[0] substringFromIndex:4],skipArray[1]];
    NSLog(@"%@",urlString_skipID);
    
    NSString *urlStr = [NSString stringWithFormat:IMAGE_URL,urlString_skipID];
    NSLog(@"%@",urlStr);
    
    __block CyclePhotoViewController *cycleVC = self;
    [[AFHTTPSessionManager manager]GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *array = dic[@"photos"];
        for (NSDictionary *temp in array) {
            [cycleVC.imageArray addObject:temp[@"imgurl"]];
            [cycleVC.titleArray addObject:temp[@"note"]];
        }
        [self setCycleviewInTheView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"AFN出错");
    }];
    
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
