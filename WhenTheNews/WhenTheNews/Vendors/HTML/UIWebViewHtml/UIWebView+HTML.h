//
//  UIWebView+HTML.h
//  WhenTheNews
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModelForDetail;
@interface UIWebView (HTML)
- (NSString *)setUpData:(ModelForDetail *)model;
@end
