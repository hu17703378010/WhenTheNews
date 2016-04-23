//
//  NewsDetailViewController.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NSString+Html.h"
#import "TFHpple.h"

#import "UIWebView+HTML.h"
#import "ModelForDetail.h"
#import <AFHTTPSessionManager.h>

//http://c.m.163.com/nc/article/%@/full.html
//http://c.m.163.com/nc/article/9IG74V5H00963VRO_BL5JNUMObjjikeupdateDoc/full.html

@interface NewsDetailViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)UIBarButtonItem *barButtonItem;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    //self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [self htmlContentTowebView];
    self.navigationController.navigationBar.translucent = NO;
    
    
    //[self setContentToWebView];
    self.title = self.titleName;
    //[self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    //设置网页链接可用
    //self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    //设置音频播放是否支持
    //self.webView.mediaPlaybackAllowsAirPlay = YES;
    //设置视频是否自动播放
    //self.webView.mediaPlaybackRequiresUserAction = YES;
    //设置是否将数据加载如内存后渲染界面
    //self.webView.suppressesIncrementalRendering = YES;
    //设置用户交互模式
    //self.webView.keyboardDisplayRequiresUserAction = YES;
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"collection_False"] style:UIBarButtonItemStyleDone target:self action:@selector(collectionAciton:)];
    self.navigationItem.rightBarButtonItem = item;
    self.tabBarController.tabBar.hidden = YES;
    self.barButtonItem = item;
}

-(void)collectionAciton:(UIBarButtonItem *)item{
    NSLog(@"收藏");
    item.image = [UIImage imageNamed:@"collection_True"];
}

- (void)htmlContentTowebView{
    
    NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.docid];
    __block typeof(self) wSelf = self;
    [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        NSDictionary *dic = [dataDic valueForKey:self.docid];
        
        ModelForDetail *model = [[ModelForDetail alloc]init];
        [model setValuesForKeysWithDictionary:dic];  // KVC
        [wSelf.webView loadHTMLString:[wSelf.webView setUpData:model] baseURL:nil];
    }]resume];
}

- (void)setContentToWebView{
    NSMutableString *mutableStr = [NSMutableString string];
    
    NSString *urlStrin = [self.url_3w stringByReplacingOccurrencesOfString:@".html" withString:@"_0.html"];
    
    NSData *urldata = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStrin]];
    
    TFHpple *tfHpple = [[TFHpple alloc]initWithHTMLData:urldata];
    
    NSArray *headArray = [tfHpple searchWithXPathQuery:@"//style"];
    NSArray *divArray = [tfHpple searchWithXPathQuery:@"//div"];
    
    for (TFHppleElement *element in headArray) {
        NSLog(@"%@",element.raw);
        
        mutableStr = [NSMutableString stringWithFormat:@"%@%@",mutableStr,element.raw];
        
    }
    
    NSArray *title = [tfHpple searchWithXPathQuery:@"//h1"];
    
    for (TFHppleElement *element in title) {
        NSLog(@"%@",element.raw);
        
        if ([[element objectForKey:@"class"]isEqualToString:@"atitle tCenter"]) {
            mutableStr = [NSMutableString stringWithFormat:@"%@%@",mutableStr,element.raw];
        }
    }
    for (TFHppleElement *element in divArray) {
        
        if ([[element objectForKey:@"class"]isEqualToString:@"content"]) {
            mutableStr = [NSMutableString stringWithFormat:@"%@%@",mutableStr,element.raw];
        }
    }
    
    
    NSArray *parray = [tfHpple searchWithXPathQuery:@"//p"];
    for (TFHppleElement *element in parray) {
        if ([[element objectForKey:@"class"]isEqualToString:@"backTop"]) {
            mutableStr = [NSMutableString stringWithFormat:@"%@%@",mutableStr,element.raw];
        }
    }
    
    [self.webView
     loadHTMLString:mutableStr baseURL:nil];
   
    
}

#pragma mark - webViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //修改标签字体
    NSString *tempString2 = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.fontSize='%@';",@"10px"];
    [webView stringByEvaluatingJavaScriptFromString:tempString2];
    
    
    // 修改图片大小
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth = 1100;" //缩放系数
     "for(i=0;i < document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "myimg.height = myimg.height * (maxwidth/oldwidth) + 90;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
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
