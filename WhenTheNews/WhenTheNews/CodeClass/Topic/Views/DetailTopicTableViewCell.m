//
//  DetailTopicTableViewCell.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "DetailTopicTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation DetailTopicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
    [self addSubview:self.headImageView];
    
    self.nameAndTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 5, 200, 20)];
    self.nameAndTitleLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.nameAndTitleLabel];
    
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 31, 285, 22)];
    [self addSubview:self.descriptionLabel];
    
//    self.upLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, ScreenWidth, 20)];
//    self.upLabel.backgroundColor = [UIColor grayColor];
//    [self addSubview:self.upLabel];
}



- (void)setDataWithModel:(TopicDetailModel *)model {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.headpicurl]];
    });
    self.nameAndTitleLabel.text = [NSString stringWithFormat:@"%@ | %@", model.name, model.title];
    self.descriptionLabel.text = model.Description;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
