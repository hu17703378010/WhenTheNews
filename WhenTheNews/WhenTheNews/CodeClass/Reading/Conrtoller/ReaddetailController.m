//
//  ReaddetailController.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 HCC. All rights reserved.
//http://c.m.163.com/nc/article/BKMMQTSN9001QTSO/full.html

#import "ReaddetailController.h"
#import "AFNetworking.h"
#import "NSString+Html.h"
#import "ModelForDetail.h"
#import "UIWebView+HTML.h"




@interface ReaddetailController ()<UIWebViewDelegate>
   
@property (nonatomic,strong)UIWebView *webView;

@property (nonatomic ,retain) UIAlertView *alertView;

@property (nonatomic,strong) UIBarButtonItem *barButton;
@end

@implementation ReaddetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];

    NSString *documents = [self documentsForFilePath];
    NSMutableArray *dataArr = [NSMutableArray arrayWithContentsOfFile:documents];
    if (dataArr.count>0) {
        
        for (NSDictionary *dic in dataArr) {
            NSString *str = [dic valueForKey:@"title"];
            if ([self.titleString isEqualToString:str]) {
              
                self.isCollect = YES;
                _barButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"collection_True"] style:UIBarButtonItemStyleDone target:self action:@selector(collectionAciton)];
                
                self.navigationItem.rightBarButtonItem = _barButton;
                
                
            }else{
                //        [_barButton setImage:[UIImage imageNamed:@"collection_False"]];
                _barButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"collection_False"] style:UIBarButtonItemStyleDone target:self action:@selector(collectionAciton)];
                
                self.navigationItem.rightBarButtonItem = _barButton;
                self.isCollect = NO;
            }
        }
        
    }else{
        _barButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"collection_False"] style:UIBarButtonItemStyleDone target:self action:@selector(collectionAciton)];
        
        self.navigationItem.rightBarButtonItem = _barButton;
        self.isCollect = NO;
        
    }
    
    
    

    
    [self loadTextViewData];
    
  
}

- (NSString *)documentsForFilePath
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [filePath.firstObject stringByAppendingPathComponent:@"collectNews.plist"];
    NSLog(@"%@",documents);
    return documents;
}


#pragma mark ---- collectionAciton
-(void)collectionAciton{
    if (self.isCollect== YES) {
        self.alertView = [[UIAlertView alloc] initWithTitle:nil message:@"已取消收藏" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        _alertView.tag = 700;
        [_alertView show];
        NSTimer *timer;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dismissAlertViewCancel) userInfo:nil repeats:NO];
        
        [_barButton setImage:[UIImage imageNamed:@"collection_False"]];
        self.isCollect = NO;
        NSString *documents = [self documentsForFilePath];
        NSMutableArray *dataArr = [NSMutableArray arrayWithContentsOfFile:documents];
        NSDictionary *dic = @{@"url":self.URLStr,@"title":self.titleString};
        [dataArr removeObject:dic];
        [dataArr writeToFile:documents atomically:YES];
        
        
    } else {
        
        self.alertView = [[UIAlertView alloc] initWithTitle:nil message:@"收藏成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        _alertView.tag = 700;
        [_alertView show];
        NSTimer *timer;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dismissAlertViewCancel) userInfo:nil repeats:NO];
        self.isCollect = YES;
        [_barButton setImage:[UIImage imageNamed:@"collection_True"]];
        
        
        NSString *documents = [self documentsForFilePath];
        NSMutableArray *dataArr = [NSMutableArray arrayWithContentsOfFile:documents];
        NSDictionary *dic = @{@"url":self.URLStr,@"title":self.titleString};
        [dataArr addObject:dic];
        [dataArr writeToFile:documents atomically:YES];
    }
    
    


    
    
}

#pragma mark --  UIAlertView 自动消失
- (void)dismissAlertViewCancel
{
    [_alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)loadTextViewData{
    //设置webView
    
    self.webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    //解析数据
        NSString *string = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.URLStr];
    __block typeof(self)wSelf = self;
    [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:string] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        NSDictionary *dic = [dataDic valueForKey:self.URLStr];
        
        ModelForDetail *model = [[ModelForDetail alloc]init];
        [model setValuesForKeysWithDictionary:dic];  // KVC
        [wSelf.webView loadHTMLString:[wSelf.webView setUpData:model] baseURL:nil];
    }]resume];

   }


- (void)webViewDidFinishLoad:(UIWebView *)webView{
        
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
