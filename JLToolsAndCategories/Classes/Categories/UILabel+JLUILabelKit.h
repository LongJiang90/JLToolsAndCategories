//
//  UILabel+JLUILabelKit.h
//  JLToolsAndCategories
//
//  Created by Long Jiang on 16/4/14.
//  Copyright © 2016年 Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (JLUILabelKit)

- (void)jl_getLineSpacingLabelWithString:(NSString *)text X:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)maxWidth Font:(CGFloat)fontSize LineSpace:(CGFloat)lineSpace;

@end
