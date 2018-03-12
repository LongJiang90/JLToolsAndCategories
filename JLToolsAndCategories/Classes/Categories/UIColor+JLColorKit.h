//
//  UIColor+JLColorKit.h
//  JLToolsAndCategories
//
//  Created by Long Jiang on 16/4/14.
//  Copyright © 2016年 Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JLColorKit)
///根据hex字符串得到颜色
+ (UIColor *)jl_colorWithHex:(NSString *)string;

@end
