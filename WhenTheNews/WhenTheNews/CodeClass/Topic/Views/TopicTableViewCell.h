//
//  TopicTableViewCell.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"

@interface TopicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameAndtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *aliasLabel;
@property (weak, nonatomic) IBOutlet UILabel *classificationLabel;
@property (weak, nonatomic) IBOutlet UILabel *concernAndquestion;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;


- (void)setDataWithModel:(TopicModel *)model;
@end
