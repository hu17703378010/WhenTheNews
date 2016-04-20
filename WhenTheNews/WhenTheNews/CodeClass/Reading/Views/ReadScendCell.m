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

@property (nonatomic,strong) NSArray *imgArr;

@end
@implementation ReadScendCell

- (NSArray *)imgArr{
    if (_imgArr) {
        _imgArr = [NSArray array];
    }
    return _imgArr;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgView];
        self.topImage = [[UIImageView alloc]init];
        [self.contentView addSubview:self.topImage];
        self.buttomImage = [[UIImageView alloc]init];
        [self.contentView addSubview:self.buttomImage];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imgView.frame = CGRectMake(2, 2, (ScreenWidth - 4) / 3, ScreenHeight - 30);
    self.topImage.frame = CGRectMake((ScreenWidth - 4) / 3 + 2, 2, ScreenWidth - self.imgView.frame.size.width, (self.imgView.frame.size.height )/ 2);
    self.buttomImage.frame = CGRectMake(self.topImage.frame.origin.x, self.topImage.frame.size.height + 1, ScreenWidth - self.imgView.frame.size.width,(self.imgView.frame.size.height )/ 2 );
}

- (void)setModel:(ReadingModel *)model{
    _model = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    self.imgArr = model.imgnewextra;
    for (NSDictionary *dic in self.imgArr) {
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
