//
//  NewsDetailViewController.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController

@property(nonatomic,strong)NSString *url_3w;


@property(nonatomic,strong)NSString *docid;
@property(nonatomic,strong)NSString *titleName;
@property (nonatomic,assign) BOOL isCollect;
@end
