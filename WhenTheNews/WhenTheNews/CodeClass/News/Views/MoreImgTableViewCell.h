//
//  MoreImgTableViewCell.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;
@interface MoreImgTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *firstimg;

@property (weak, nonatomic) IBOutlet UIImageView *secondImg;

@property (weak, nonatomic) IBOutlet UIImageView *thirstImg;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)setModelContentToCell:(NewsModel *)model;


@end
