//
//  UIButton+JLUIButtonKit.h
//  JLToolsAndCategories
//
//  Created by Long Jiang on 16/4/15.
//  Copyright © 2016年 Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JLUIButtonKit)

///设置普通状态与高亮状态的背景图片
-(void)setN_BG:(NSString *)nbg H_BG:(NSString *)hbg;

///设置普通状态与高亮状态的拉伸后背景图片
-(void)setResizeN_BG:(NSString *)nbg H_BG:(NSString *)hbg;

@end
