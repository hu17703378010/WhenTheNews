//
//  TopicModel.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject

@property (nonatomic,strong) NSString *alias;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *headpicurl;
@property (nonatomic,strong) NSString *picurl;
@property (nonatomic,strong) NSString *questionCount;//提问
@property (nonatomic,strong) NSString *concernCount;//关注
@property (nonatomic,strong) NSString *classification;//类别
@property (nonatomic,strong) NSString *Description;
@property (nonatomic,strong) NSString *expertId;



@end
