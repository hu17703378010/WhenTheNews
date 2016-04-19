//
//  TopicAnswerModel.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicAnswerModel : NSObject
@property (nonatomic,strong) NSString *answerId;
@property (nonatomic,strong) NSString *board;
@property (nonatomic,strong) NSString *commentId;
@property (nonatomic,strong) NSString *relatedQuestionId;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *specialistName;
@property (nonatomic,strong) NSString *specialistHeadPicUrl;
@property (nonatomic,strong) NSString *supportCount;
@property (nonatomic,strong) NSString *replyCount;
@property (nonatomic,strong) NSString *cTime;

@end
