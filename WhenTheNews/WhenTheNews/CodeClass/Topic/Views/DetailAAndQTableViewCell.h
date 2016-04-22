//
//  DetailAAndQTableViewCell.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicAnswerModel.h"
#import "TopicQuestionModel.h"

@interface DetailAAndQTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *userHeadImageView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *userContentLabel;
@property (nonatomic,strong) UIImageView *specialistHeadImageView;
@property (nonatomic,strong) UILabel *specialistNameLabel;
@property (nonatomic,strong) UILabel *answerContentLabel;
@property (nonatomic,strong) UIView *answerView;


- (void)setDataWithModel:(TopicQuestionModel *)model;
- (void)setDataWithAnswerModel:(TopicAnswerModel *)model;

@end
