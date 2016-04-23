//
//  DataBaseManager.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "DataBaseManager.h"

@implementation DataBaseManager

+ (instancetype)defaultManager{
    static DataBaseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataBaseManager alloc]init];
    });
    return manager;
}

- (instancetype)init{
    if (self = [super init]) {
        //获取documents 路径
        NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        //创建数据库路径
        NSString *path = [string stringByAppendingPathComponent:@"news.sqlite"];
        self.database = [[FMDatabase alloc]initWithPath:path];
        BOOL isOpen = [self.database open];
        if (!isOpen) {
            NSLog(@"open sqlite error");
        }
    }
    return self;
}

- (void)closeDB{
    [self.database close];
}

@end
