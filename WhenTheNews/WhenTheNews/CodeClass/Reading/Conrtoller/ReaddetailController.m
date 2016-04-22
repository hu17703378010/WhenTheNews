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
    
       [self loadTextViewData];
}


- (void)loadTextViewData{
    //设置webView
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0,ScreenWidth, ScreenHeight - 44)];
    self.webView.delegate = self;
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
 //   __weak wSelf = self;
    NSString *string = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.URLStr];
    
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
            [manager GET:string parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
                NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:responseObject];
           NSDictionary *dic = [dataDic objectForKey:self.URLStr];
                ModelForDetail *model = [[ModelForDetail alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                
    
                _contentString = [[[model.title stringByAppendingString:model.ptime]stringByAppendingString:model.body]stringByAppendingString:model.source];
                
               _webView.scalesPageToFit = NO;
          //      把原来的html通过importStyleWithHtmlString进行替换，修改html的布局
             NSString *newString = [NSString importStyleWithHtmlString:_contentString];
                //baseURL可以让界面加载的时候按照本地样式去加载
                NSURL *baseURL = [NSURL fileURLWithPath:[NSBundle
                                                         mainBundle].bundlePath];
                [_webView loadHTMLString:newString baseURL:baseURL];

   
    
    
    
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];

   }





- (void)webViewDidFinishLoad:(UIWebView *)webView{
        
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
 

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
