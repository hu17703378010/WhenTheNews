//
//  readFristCell.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 HCC. All rights reserved.
//


#import "readFristCell.h"
#import  <UIImageView+WebCache.h>

@implementation readFristCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleLabel];
        
        self.digetLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.digetLabel];
        
        self.imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgView];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imgView.frame = CGRectMake(2, 2, (ScreenWidth - 4) / 2.5, ScreenHeight - 4);
#warning
    self.titleLabel.frame = CGRectMake((ScreenWidth - 4) / 2.5 + 4, 2, ScreenWidth - (ScreenWidth - 4) / 2.5 - 6, 30);
    self.digetLabel.frame = CGRectMake((ScreenWidth - 4) / 2.5 + 4, 2 + 30, ScreenWidth - (ScreenWidth - 4) / 2.5 - 6, ScreenHeight - 4 - self.titleLabel.frame.size.height);
}

- (void)setModel:(ReadingModel *)model{
    _model = model;
    
    _titleLabel.text = model.title;
    _digetLabel.text = model.digest;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
}


@end
