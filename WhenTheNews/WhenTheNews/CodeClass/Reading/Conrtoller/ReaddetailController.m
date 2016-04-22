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

@property (nonatomic,copy)NSString *contentString;

@property (nonatomic ,retain) NSMutableArray *imageArr; // 图片数组
@property (nonatomic ,retain) NSMutableArray *titleArr; // 标题数组


@end

@implementation ReaddetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];
    
    self.webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];

    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [self loadTextViewData];

}


- (void)loadTextViewData{
    //设置webView
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
