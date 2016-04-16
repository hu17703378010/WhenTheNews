//
//  AllCodeClassViewController.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "AllCodeClassViewController.h"


#import "NewsViewController.h"
#import "ReadingViewController.h"
#import "TopicViewController.h"
#import "VideoViewController.h"
#import "OneSelfViewController.h"



@interface AllCodeClassViewController ()

@end

@implementation AllCodeClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setIntoViewMoreChirldViews];
}
- (void)setIntoViewMoreChirldViews{
    
    self.viewControllers = @[[self setNavigationController:@"NewsViewController" tabbarItem:@"新闻" Image:@"新闻" selectedImage:@""],[self setNavigationController:@"ReadingViewController" tabbarItem:@"阅读" Image:@"阅读" selectedImage:@""],[self setNavigationController:@"TopicViewController" tabbarItem:@"话题" Image:@"话题" selectedImage:@""],[self setNavigationController:@"VideoViewController" tabbarItem:@"视频" Image:@"视频" selectedImage:@""],[self setNavigationController:@"OneSelfViewController" tabbarItem:@"我的" Image:@"我的" selectedImage:@""]];
}

- (UIViewController *)setNavigationController:(NSString *)controller tabbarItem:(NSString *)title Image:(NSString *)image selectedImage:(NSString *)selectImage{
    
    UINavigationController *navigationNews = [[UINavigationController alloc]initWithRootViewController:[[NSClassFromString(controller) alloc]init]];
    navigationNews.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectImage]];
    
    return navigationNews;
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
