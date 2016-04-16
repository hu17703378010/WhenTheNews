//
//  VideoViewCell.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

@interface VideoViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *coverImage;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIButton *playButton;

@property (nonatomic,strong) VideoModel *model;

- (void)setDataWithModel:(VideoModel *)model;

@end
