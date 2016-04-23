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

    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];

    
    
    [self loadTextViewData];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"collection_False"] style:UIBarButtonItemStyleDone target:self action:@selector(collectionAciton:)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.barButton = item;

}

- (NSString *)documentsForFilePath
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [filePath.firstObject stringByAppendingPathComponent:@"collectNews.plist"];
    NSLog(@"%@",documents);
    return documents;
}
#pragma mark --  判断是否已收藏
- (BOOL)isCollect
{
    NSString *documents = [self documentsForFilePath];
    NSMutableArray *dataArr = [NSMutableArray arrayWithContentsOfFile:documents];
    for (NSDictionary *dic in dataArr) {
        NSString *str = [dic valueForKey:@"title"];
        if ([self.titleString isEqualToString:str]) {
   //    [self.barButton setImage:[UIImage imageNamed:@"collection_False"] ];

        return YES;
        }
    }
  //  [self.barButton setImage:[UIImage imageNamed:@"collection_True"] ];
    return NO;

}


#pragma mark ---- collectionAciton
-(void)collectionAciton:(UIBarButtonItem *)item{
    NSLog(@"收藏了新闻");
    if ([self isCollect]) {
        self.alertView = [[UIAlertView alloc] initWithTitle:nil message:@"该资讯已收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        _alertView.tag = 700;
        [_alertView show];
        NSTimer *timer;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dismissAlertViewCancel) userInfo:nil repeats:NO];
        
    } else {
        
        [item setImage:[UIImage imageNamed:@"iconfont_True.png"]];
        
        NSString *documents = [self documentsForFilePath];
        NSMutableArray *dataArr = [NSMutableArray arrayWithContentsOfFile:documents];
        
        if (!dataArr) {
            dataArr = [[NSMutableArray alloc] init];
        }
        
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
