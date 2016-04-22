//
//  ImgAndTitleTableViewCell.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "ImgAndTitleTableViewCell.h"
#import "NewsModel.h"
#import <UIImageView+WebCache.h>

@implementation ImgAndTitleTableViewCell

- (void)setModelContentToCell:(NewsModel *)model{
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = model.title;
    //self.timeLabel.text = [NSString stringWithFormat:@"%@回复",model.replyCount];
    self.contextLabel.text = model.digest;
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
