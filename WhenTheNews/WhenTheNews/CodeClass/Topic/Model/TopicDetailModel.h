//
//  TopicDetailModel.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicDetailModel : NSObject

@property (nonatomic,strong) NSString *alias;
@property (nonatomic,strong) NSString *picurl;
@property (nonatomic,strong) NSString *concernCount;
@property (nonatomic,strong) NSString *headpicurl;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *Description;
@property (nonatomic,strong) NSString *questionCount;
@property (nonatomic,strong) NSString *answerCount;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userHeadPicUrl;
@property (nonatomic,strong) NSString *content;//提问 回答 内容
@property (nonatomic,strong) NSString *specialistHeadPicUrl;
@property (nonatomic,strong) NSString *specialistName;
@property (nonatomic,strong) NSString *supportCount;
@property (nonatomic,strong) NSString *replyCount;
@property (nonatomic,strong) NSString *questionId;
@property (nonatomic,strong) NSString *relatedExpertId;
@property (nonatomic,strong) NSString *answerId;
@property (nonatomic,strong) NSString *commentId;
@property (nonatomic,strong) NSString *relatedQuestionId;
@property (nonatomic,strong) NSString *expertId;
@property (nonatomic,strong) NSString *state;



@end
