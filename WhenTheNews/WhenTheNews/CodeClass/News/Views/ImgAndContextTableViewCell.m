//
//  ImgAndContextTableViewCell.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "ImgAndContextTableViewCell.h"
#import "NewsModel.h"
#import <UIImageView+WebCache.h>

@implementation ImgAndContextTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModelContentToCell:(NewsModel *)model{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"whenNewsBack1"]];
    self.titleLabel.text = model.title;
    self.contextLabel.text = model.digest;
    self.timeLabel.text = [NSString stringWithFormat:@"%@回复",model.replyCount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
