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
        
        self.backView = [[UIImageView alloc]init];
        [self.backView.layer setMasksToBounds:YES];
        self.backView.image = [UIImage imageNamed:@"readBack.png"];
        self.backView.layer.cornerRadius = 3;
        [self.contentView addSubview:self.backView];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.numberOfLines = 0;
        [self.backView addSubview:self.titleLabel];
        
        self.digetLabel = [[UILabel alloc]init];
        self.digetLabel.textColor = [UIColor grayColor];
        self.digetLabel.font = [UIFont systemFontOfSize:14];
        self.digetLabel.numberOfLines = 0;
        [self.backView addSubview:self.digetLabel];
        
        self.imgView = [[UIImageView alloc]init];
        [self.imgView.layer setMasksToBounds:YES];
        self.imgView.layer.cornerRadius = 5;

        [self.backView addSubview:self.imgView];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.backView.frame = CGRectMake(5, 4, ScreenWidth - 10, self.contentView.frame.size.height - 8);
    
    CGFloat backW = self.backView.frame.size.width;
    CGFloat backH = self.backView.frame.size.height;
    self.imgView.frame = CGRectMake(2, 4, backW/2.5, backH-8);
  
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+4, 4, backW - CGRectGetMaxX(self.imgView.frame)-8, (self.imgView.frame.size.height-8)/2);
    self.digetLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, 4 + CGRectGetMaxY(self.titleLabel.frame), self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);}

- (void)setModel:(ReadingModel *)model{
    _model = model;
    
    _titleLabel.text = model.title;
    _digetLabel.text = model.digest;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
 
}


@end
