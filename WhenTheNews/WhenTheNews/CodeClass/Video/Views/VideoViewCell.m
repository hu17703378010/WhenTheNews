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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ]) {
        
        _titleLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:_titleLabel];
        
        _coverImage = [[UIImageView alloc]init];
        _coverImage.userInteractionEnabled = YES;
        [self.contentView addSubview:_coverImage];
        
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"bofang"] forState:(UIControlStateNormal)];
        [_playButton addTarget:self action:@selector(playVideo) forControlEvents:(UIControlEventTouchUpInside)];
        [_coverImage addSubview:_playButton];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(2, 2, SCREEN_WIDTH, 30);
    _coverImage.frame = CGRectMake(2, 34, SCREEN_WIDTH - 4, self.contentView.frame.size.height - 34);
    _playButton.frame = CGRectMake(_coverImage.frame.size.width / 2 - 25, _coverImage.frame.size.height / 2 - 25, 50, 50);
    
}
-(void)setModel:(VideoModel *)model{
    _model = model;
    _titleLabel.text = _model.title;
    [_coverImage sd_setImageWithURL:[NSURL URLWithString:_model.cover]];
}

-(void)playVideo{
    
    if ([self.delegate respondsToSelector:@selector(getVideoURL:title:)]) {
        
        [self.delegate getVideoURL:_model.mp4_url title:_model.title];
        
    }
  

}


@end
