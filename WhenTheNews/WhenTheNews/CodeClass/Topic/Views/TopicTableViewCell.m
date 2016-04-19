//
//  TopicTableViewCell.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "TopicTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface TopicTableViewCell ()

@end

@implementation TopicTableViewCell



- (void)setDataWithModel:(TopicModel *)model {
    NSLog(@"name = %@, picurl = %@, headima = %@", model.name, model.picurl, model.headpicurl);
    self.nameAndtitleLabel.text = [NSString stringWithFormat:@"%@ / %@", model.name, model.title];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.picurl]];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.headpicurl]];
    self.aliasLabel.text = model.alias;
    self.aliasLabel.numberOfLines = 0;
    self.classificationLabel.text = model.classification;
    self.classificationLabel.textColor = [UIColor blueColor];
    NSInteger con = [model.concernCount integerValue];
    CGFloat con1 = con / 10000;
    NSString *conString = [NSString stringWithFormat:@"%0.1f", con1];
    NSLog(@"constring = %@", conString);
    self.concernAndquestion.text = [NSString stringWithFormat:@"| %@万关注 | %@提问",conString, model.questionCount];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
