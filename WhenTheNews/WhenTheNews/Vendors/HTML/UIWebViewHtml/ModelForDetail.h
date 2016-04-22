//
//  ModelForDetail.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ModelForDetail : NSObject
@property (nonatomic,copy) NSArray * img;// 图片数组

@property (nonatomic,copy) NSString * ptime;// 日期

@property (nonatomic,copy) NSString * title;//标题

@property (nonatomic,copy) NSString * body;//内容

@property (nonatomic,copy) NSString * source;//来源

@property(nonatomic,copy)NSString *digest;

@property(nonatomic,copy)NSString *Class;
@end
