//
//  ImgAndTitleTableViewCell.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;
@interface ImgAndTitleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
//@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)setModelContentToCell:(NewsModel *)model;
@end
