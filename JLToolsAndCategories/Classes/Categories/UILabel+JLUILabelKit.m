//
//  UILabel+JLUILabelKit.m
//  JLToolsAndCategories
//
//  Created by Long Jiang on 16/4/14.
//  Copyright © 2016年 Long. All rights reserved.
//

#import "UILabel+JLUILabelKit.h"

@implementation UILabel (JLUILabelKit)

/**
 *  将一个已经初始化的label设置行间距等属性后，返回一个适合大小的label
 *
 *  @param text      label的文字
 *  @param x         label的x
 *  @param y         label的y
 *  @param maxWidth  label的最大宽度
 *  @param fontSize  label的文字大小
 *  @param lineSpace label的行间距
 */
- (void)jl_getLineSpacingLabelWithString:(NSString *)text X:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)maxWidth Font:(CGFloat)fontSize LineSpace:(CGFloat)lineSpace
{
    // 设置label的属性
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    
    // 必须设置字体的
    self.font = [UIFont systemFontOfSize:fontSize];
    
    // 下面一句特别注意，我在这里就犯错了，计算出来的高度完全没有问题，新建一个项目，出来的size刚好完美的装着这个label，但是在本项目就是显示不完全，找了好久才找到问题的原因,下面这句话是修改字体的，每个项目都可能修改系统字体为自定义的字体，如果不在sizeToFit之前把字体改回来的话，最后得到的size就是按照系统字体计算出来的size，最后你改了字体，就会导致label的文字显示不完或者有多余的空白。
    [self setFont:[UIFont fontWithName:self.font.fontName size:[[self font] pointSize]]];
    
    
    // 根据内容设置label的大小,先设置初始的x,y,width
    self.frame = CGRectMake(x, y, maxWidth, 0);
    
    // 设置label的行间距
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    // 行间距为
    [paragraphStyle setLineSpacing:lineSpace];
    
    // 设置文字属性的范围
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    // 将attributeString赋值给label的attributedText
    self.attributedText = attributeString;
    
    // 最关键的一步，之后就获取高度就直接用 label.bounds.size.width
    [self sizeToFit];
}

@end
