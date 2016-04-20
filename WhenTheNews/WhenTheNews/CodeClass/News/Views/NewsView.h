//
//  NewsView.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImgAndContextTableViewCell.h"
#import "ImgAndTitleTableViewCell.h"
#import "MoreImgTableViewCell.h"

@interface NewsView : UIView 


@property(nonatomic,strong)UITableView *contextTable;
- (void)requesData:(NSString *)typeStr;
@end
