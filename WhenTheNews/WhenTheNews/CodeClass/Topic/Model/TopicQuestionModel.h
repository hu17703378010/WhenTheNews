//
//  TopicQuestionModel.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicQuestionModel : NSObject

@property (nonatomic,strong) NSString *questionId;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *relatedExpertId;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userHeadPicUrl;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *cTime;

@end
