//
//  ReadScendCell.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "ReadScendCell.h"
#import <UIImageView+WebCache.h>

@interface ReadScendCell()

@end
@implementation ReadScendCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backView = [[UIImageView alloc]init];
        self.backView.image = [UIImage imageNamed:@"readBack.png"];
        [self.backView.layer setMasksToBounds:YES];
        self.backView.layer.cornerRadius = 3;
        [self.contentView addSubview:self.backView];
        
        self.imgView = [[UIImageView alloc]init];
        [self.backView addSubview:self.imgView];
        self.topImage = [[UIImageView alloc]init];
        [self.backView addSubview:self.topImage];
        self.buttomImage = [[UIImageView alloc]init];
        [self.backView addSubview:self.buttomImage];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.numberOfLines = 0;
        [self.backView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
     self.backView.frame = CGRectMake(5, 4, ScreenWidth - 10, self.contentView.frame.size.height - 6);
    CGFloat backW = self.backView.frame.size.width;
    CGFloat backH = self.backView.frame.size.height;
    
    
    self.imgView.frame = CGRectMake(0, 0,backW/3*2, backH - 30);
    
    self.topImage.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + 2, 0, self.imgView.frame.size.width/2 - 2, (self.imgView.frame.size.height)/ 2 - 1);
    
    self.buttomImage.frame = CGRectMake(self.topImage.frame.origin.x, self.topImage.frame.size.height + 2, self.topImage.frame.size.width,self.topImage.frame.size.height);

    self.titleLabel.frame = CGRectMake(2, backH - 30, backW, 30);
}


- (void)setModel:(ReadingModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    NSArray *imgArr = [NSArray arrayWithArray:model.imgnewextra];
    if (imgArr.count>1) {
        NSDictionary *d1 = [NSDictionary dictionaryWithDictionary:imgArr[0]];
        [self.topImage sd_setImageWithURL:[NSURL URLWithString:d1[@"imgsrc"]]];
        NSDictionary *d2 = [NSDictionary dictionaryWithDictionary:imgArr[1]];
        
        [self.buttomImage sd_setImageWithURL:[NSURL URLWithString:d2[@"imgsrc"]]];
        
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
