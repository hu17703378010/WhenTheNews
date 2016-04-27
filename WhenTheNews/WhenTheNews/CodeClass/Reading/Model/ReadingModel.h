//
//  ReadingModel.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadingModel : NSObject
@property(nonatomic,copy) NSString *boardid;
@property (nonatomic , copy) NSString *docid; //跳转id

@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *digest;

@property (nonatomic,copy)NSString *img;//左边大图
@property(nonatomic,copy) NSString *templaTe;//


@property (nonatomic,strong) NSArray *imgnewextra;

@property (nonatomic,strong) NSString *Id;





@end
