//
//  readFristCell.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ReadingModel.h"

@interface readFristCell : UITableViewCell

@property (nonatomic,strong)UIImageView *imgView;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong) UILabel *digetLabel;

@property (nonatomic,strong) ReadingModel *model;

@property (nonatomic,strong) UIImageView *backView;

@end
