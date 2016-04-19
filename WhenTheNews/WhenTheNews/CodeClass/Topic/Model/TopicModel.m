//
//  TopicModel.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([self.Description isEqualToString:@"description"]) {
        [self.Description setValue:value forKey:key];
    }
    
    NSLog(@"%@", key);
}


@end
