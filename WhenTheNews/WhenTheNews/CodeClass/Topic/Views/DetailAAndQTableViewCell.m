//
//  DetailAAndQTableViewCell.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "DetailAAndQTableViewCell.h"
#import <UIImageView+WebCache.h>
#define width @"285"
#define WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)


@interface DetailAAndQTableViewCell ()


@property (nonatomic,assign) CGFloat height;

@end

@implementation DetailAAndQTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCell];
    }
    return self;
}


- (void)setupCell {
    
    self.userHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 30, 30)];
    self.userHeadImageView.layer.masksToBounds = YES;
    self.userHeadImageView.layer.cornerRadius = 15;
    [self addSubview:self.userHeadImageView];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, 200, 20)];
    self.userNameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.userNameLabel];
    
    self.userContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 30, 285, 20)];
    self.userContentLabel.font = [UIFont systemFontOfSize:14];
    self.userContentLabel.numberOfLines = 0;
    [self addSubview:self.userContentLabel];

    self.specialistHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 30, 30)];
    self.specialistHeadImageView.layer.masksToBounds = YES;
    self.specialistHeadImageView.backgroundColor = [UIColor redColor];
    self.specialistHeadImageView.layer.cornerRadius = 15;
    [self addSubview:self.specialistHeadImageView];
    
    self.specialistNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, 200, 20)];
    self.specialistNameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.specialistNameLabel];
    
    self.answerContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 30, 285, 20)];
    self.answerContentLabel.font = [UIFont systemFontOfSize:14];
    self.answerContentLabel.numberOfLines = 0;
    [self addSubview:self.answerContentLabel];
    
//    self.stretchButton = [[UIButton alloc] initWithFrame:CGRectMake(330, 0, 40, 30)];
//    self.stretchButton.backgroundColor = [UIColor grayColor];
//    [self addSubview:self.stretchButton];
    
}

- (void)setDataWithModel:(TopicQuestionModel *)model {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.userHeadPicUrl]];
    });
    self.userNameLabel.text = model.userName;
    self.userContentLabel.text = model.content;
}

- (void)setDataWithAnswerModel:(TopicAnswerModel *)model {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.specialistHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.specialistHeadPicUrl]];
    });
    self.specialistNameLabel.text = model.specialistName;
    self.answerContentLabel.text = model.content;
}

- (CGFloat)stringHeight:(NSString *)string {
    CGRect temp = [string boundingRectWithSize:CGSizeMake(285, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return temp.size.height;
}

- (void)awakeFromNib {
    
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
