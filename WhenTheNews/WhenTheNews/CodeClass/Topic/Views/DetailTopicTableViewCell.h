//
//  DetailTopicTableViewCell.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicDetailModel.h"

@interface DetailTopicTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nameAndTitleLabel;
@property (nonatomic,strong) UILabel *descriptionLabel;
@property (nonatomic,strong) UILabel *upLabel;

- (void)setDataWithModel:(TopicDetailModel *)model;

@end
