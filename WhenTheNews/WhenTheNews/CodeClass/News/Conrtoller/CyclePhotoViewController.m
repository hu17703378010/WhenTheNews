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

@property (nonatomic,assign) BOOL isCollect;
@property(nonatomic,strong)UIBarButtonItem *barButtonItem;
@property (nonatomic ,retain) UIAlertView *alertView;

@end

@implementation CyclePhotoViewController


-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    NSString *documents = [self documentsForFilePath];
    NSMutableArray *dataArr = [NSMutableArray arrayWithContentsOfFile:documents];
    if (dataArr.count > 0) {
        for (NSDictionary *dic in dataArr) {
            if ([self.title_name isEqualToString:dic[@"title"]]) {
                if ([dic[@"collction"] isEqualToString:@"1"]) {
                    self.isCollect = YES;
                }else{
                    self.isCollect = NO;
                }
            }
        }
    }
}
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
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    [self setClooectionItem];
    [self requestData];
    
   // self.navigationController.
}

#pragma mark - 收藏
-(void)setClooectionItem{
    NSString *documents = [self documentsForFilePath];
    NSMutableArray *dataArr = [NSMutableArray arrayWithContentsOfFile:documents];
    if (dataArr.count > 0) {
        for (NSDictionary *dic in dataArr) {
            NSString *str = [dic valueForKey:@"title"];
            if ([self.title_name isEqualToString:str]) {
                self.isCollect = YES;
                _barButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"collection_True"] style:UIBarButtonItemStyleDone target:self action:@selector(collectionAciton)];
                self.navigationItem.rightBarButtonItem = _barButtonItem;
            }else{
                _barButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"collection_False"] style:UIBarButtonItemStyleDone target:self action:@selector(collectionAciton)];
                
                self.navigationItem.rightBarButtonItem = _barButtonItem;
                self.isCollect = NO;
            }
            
        }
    }else{
        _barButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"collection_False"] style:UIBarButtonItemStyleDone target:self action:@selector(collectionAciton)];
        
        self.navigationItem.rightBarButtonItem = _barButtonItem;
        self.isCollect = NO;
    }
}

-(void)collectionAciton{
    if (self.isCollect== YES) {
        self.alertView = [[UIAlertView alloc] initWithTitle:nil message:@"已取消收藏" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        _alertView.tag = 700;
        [_alertView show];
        NSTimer *timer;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dismissAlertViewCancel) userInfo:nil repeats:NO];
        
        [_barButtonItem setImage:[UIImage imageNamed:@"collection_False"]];
        self.isCollect = NO;
        NSString *documents = [self documentsForFilePath];
        NSMutableArray *dataArr = [NSMutableArray arrayWithContentsOfFile:documents];
        //NSDictionary *dic = @{@"url":self.docid,@"title":self.titleName,@"collection":[NSString stringWithFormat:@"%d",self.isCollect]};
        for (NSDictionary *dic in dataArr) {
            if ([dic[@"title"] isEqualToString:self.title]) {
                [dataArr removeObject:dic];
            }
        }
        [dataArr writeToFile:documents atomically:YES];
        
    } else {
        
        self.alertView = [[UIAlertView alloc] initWithTitle:nil message:@"收藏成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        _alertView.tag = 700;
        [_alertView show];
        NSTimer *timer;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dismissAlertViewCancel) userInfo:nil repeats:NO];
        self.isCollect = YES;
        [_barButtonItem setImage:[UIImage imageNamed:@"collection_True"]];
        
        
        NSString *documents = [self documentsForFilePath];
        NSMutableArray *dataArr = [NSMutableArray arrayWithContentsOfFile:documents];
        if (dataArr!=nil) {
            NSDictionary *dic = @{@"skipID":self.photo_skipID,@"title":self.title_name,@"collection":[NSString stringWithFormat:@"%d",self.isCollect]};
            [dataArr addObject:dic];
            [dataArr writeToFile:documents atomically:YES];
        }else{
            dataArr = [NSMutableArray array];
            NSDictionary *dic = @{@"skipID":self.photo_skipID,@"title":self.title_name,@"collection":[NSString stringWithFormat:@"%d",self.isCollect]};
            [dataArr addObject:dic];
            [dataArr writeToFile:documents atomically:YES];
        }
        
    }
}
#pragma mark --  UIAlertView 自动消失
- (void)dismissAlertViewCancel
{
    [_alertView dismissWithClickedButtonIndex:0 animated:YES];
}
-(NSString *)documentsForFilePath{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [filePath.firstObject stringByAppendingPathComponent:@"collectNews.plist"];
    NSLog(@"%@",documents);
    return documents;
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
