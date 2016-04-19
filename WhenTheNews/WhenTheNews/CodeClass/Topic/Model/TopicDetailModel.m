//
//  TopicDetailModel.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "TopicDetailModel.h"

@implementation TopicDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([self.Description isEqualToString:@"description"]) {
        [self.Description setValue:value forKey:key];
    }
    NSLog(@"key = %@", key);
}

@end
