//
//  MoreImgTableViewCell.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "MoreImgTableViewCell.h"
#import "NewsModel.h"
#import <UIImageView+WebCache.h>

@implementation MoreImgTableViewCell

- (void)setModelContentToCell:(NewsModel *)model{
    self.titleLabel.text = model.title;
    [self.firstimg sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"shixun"]];
    [self.secondImg sd_setImageWithURL:[NSURL URLWithString:model.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"shixun"]];
    [self.thirstImg sd_setImageWithURL:[NSURL URLWithString:model.imgextra[1][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"shixun"]];
    self.timeLabel.text = [NSString stringWithFormat:@"%@回复",model.replyCount];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
