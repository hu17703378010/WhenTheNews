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

@property (nonatomic ,retain) UIAlertView *alertView;

@end

@implementation NewsDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight)];
    //self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor blackColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self htmlContentTowebView];
        [self.view addSubview:self.webView];
    });
    
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
    
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"collection_False"] style:UIBarButtonItemStyleDone target:self action:@selector(collectionAciton:)];
//    self.barButtonItem = item;
//    self.navigationItem.rightBarButtonItem = item;
    
    
    
    NSString *documents = [self documentsForFilePath];
    NSMutableArray *dataArr = [NSMutableArray arrayWithContentsOfFile:documents];
    if (dataArr.count > 0) {
        for (NSDictionary *dic in dataArr) {
            NSString *str = [dic valueForKey:@"title"];
            if ([self.titleName isEqualToString:str]) {
                self.isCollect = YES;
                _barButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"collection_True"] style:UIBarButtonItemStyleDone target:self action:@selector(collectionAciton)];
                self.navigationItem.rightBarButtonItem = _barButtonItem;
                break;
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
                break;
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
            NSDictionary *dic = @{@"docid":self.docid,@"title":self.titleName};
            [dataArr addObject:dic];
            [dataArr writeToFile:documents atomically:YES];
        }else{
            dataArr = [NSMutableArray array];
            NSDictionary *dic = @{@"docid":self.docid,@"title":self.titleName};
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







#pragma mark - Html
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
