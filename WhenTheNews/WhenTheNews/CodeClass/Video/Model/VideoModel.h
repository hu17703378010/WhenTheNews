//
//  VideoModel.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property(nonatomic,strong) NSString *cover;

@property(nonatomic,strong) NSString *title;

@property(nonatomic,strong) NSString *mp4_url;

@property(nonatomic,strong) NSString *m3u8_url;

@property(nonatomic,strong) NSString *playCount;

@property(nonatomic,strong) NSString *length;



@end
