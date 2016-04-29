//
//  AnimationViewController.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/28.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imgView.image = [UIImage imageNamed:@"whennews.png"];
    
    [self.view addSubview:imgView];
    [UIView transitionWithView:imgView duration:3 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        imgView.frame = CGRectMake(-50, -80, self.view.bounds.size.width *1.3, self.view.bounds.size.height *1.3);
        
    } completion:^(BOOL finished) {
        
    } ];
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
