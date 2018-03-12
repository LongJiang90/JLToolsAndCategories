//
//  UIButton+JLUIButtonKit.m
//  JLToolsAndCategories
//
//  Created by Long Jiang on 16/4/15.
//  Copyright © 2016年 Long. All rights reserved.
//

#import "UIButton+JLUIButtonKit.h"
#include <objc/runtime.h>
@implementation UIButton (JLUIButtonKit)

+ (UIButton *)new
{
    return [self.class buttonWithType:UIButtonTypeCustom];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self.nextResponder touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self.nextResponder touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self.nextResponder touchesCancelled:touches withEvent:event];
}

-(void)setN_BG:(NSString *)nbg H_BG:(NSString *)hbg{
    [self setBackgroundImage:[UIImage imageNamed:nbg] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:hbg] forState:UIControlStateHighlighted];
}


-(void)setResizeN_BG:(NSString *)nbg H_BG:(NSString *)hbg{
    [self setBackgroundImage:[self stretchedImageWithName:nbg] forState:UIControlStateNormal];
    [self setBackgroundImage:[self stretchedImageWithName:hbg] forState:UIControlStateHighlighted];
}

-(UIImage *)stretchedImageWithName:(NSString *)name{
    
    UIImage *image = [UIImage imageNamed:name];
    int leftCap = image.size.width * 0.5;
    int topCap = image.size.height * 0.5;
    return [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}

@end
