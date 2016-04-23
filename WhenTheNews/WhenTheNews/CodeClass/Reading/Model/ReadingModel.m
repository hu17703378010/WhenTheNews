//
//  ReadingModel.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "ReadingModel.h"

@implementation ReadingModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if([key isEqualToString:@"id"]){
        self.Id = value;
    }
    if([key isEqualToString:@"template"]){
        self.templaTe = value;
    }
}

@end
