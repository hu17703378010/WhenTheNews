//
//  NewsModel.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject


@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *replyCount;
@property (nonatomic, strong) NSString *imgsrc;
@property (nonatomic, strong) NSArray *imgextra;
@property (nonatomic, strong) NSString *digest;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *photosetID;
@property (nonatomic, strong) NSString *imgType;

@end
