//
//  DataBaseManager.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DataBaseManager : NSObject

+ (instancetype)defaultManager;

@property (nonatomic,strong)FMDatabase *database;

- (void)closeDB;

@end
