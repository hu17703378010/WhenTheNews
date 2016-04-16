//
//  VideoViewCell.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "VideoViewCell.h"

#import <UIImageView+WebCache.h>

@implementation VideoViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, SCREEN_WIDTH, 30)];
        [self.contentView addSubview:_titleLabel];
        
        _coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(2, 34, SCREEN_WIDTH - 4, 100)];
        [self.contentView addSubview:_coverImage];
        
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playButton.frame = CGRectMake(self.coverImage.frame.size.width / 2 - 15, self.coverImage.frame.size.height / 2 - 15, 30, 30);
        
        [_playButton addTarget:self action:@selector(playButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.coverImage addSubview:_playButton];
    }
    return self;
}

- (void)setDataWithModel:(VideoModel *)model{
    _titleLabel.text = model.title;
    [_coverImage sd_setImageWithURL:[NSURL URLWithString:model.cover]];
}


- (void)playButton:(UIButton *)sender{
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
