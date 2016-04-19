//
//  DetailAAndQTableViewCell.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "DetailAAndQTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface DetailAAndQTableViewCell ()

@property (nonatomic,assign) CGFloat width;
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
    
    
//    self.answerView = [[UIView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
    
    
}

- (void)setDataWithModel:(TopicQuestionModel *)model {
    [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.userHeadPicUrl]];
    self.userNameLabel.text = model.userName;
    self.userContentLabel.text = model.content;
}

- (CGFloat)stringHeight:(NSString *)string {
    CGRect temp = [string boundingRectWithSize:CGSizeMake(285, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return temp.size.height;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
