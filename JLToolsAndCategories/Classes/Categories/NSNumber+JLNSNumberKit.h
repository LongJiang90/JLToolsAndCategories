//
//  NSNumber+JLNSNumberKit.h
//  JLToolsAndCategories
//
//  Created by Long on 16/4/14.
//  Copyright © 2016年 Long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSNumber (JLNSNumberKit)

#pragma mark - 类型转换
///NSString转NSNumber
+ (NSNumber *)jl_numberWithString:(NSString *)string;
/**
 *  @param digit  限制最大位数
 */
///NSNumber转NSString
- (NSString *)jl_numberStringWithDigit:(NSInteger)digit;
///NSNumber转NSString【百分比】
- (NSString *)jl_percentageStringWithDigit:(NSInteger)digit;
///NSNumber转罗马数字字符串
- (NSString *)jl_romanNumeralString;
///NSNumber转CGFloat
- (CGFloat)jl_CGFloatValue;
///用CGFloat初始化NSNumber
- (id)initWithCGFloat:(CGFloat)value;
///用CGFloat初始化NSNumber
+ (NSNumber *)jl_numberWithCGFloat:(CGFloat)value;

#pragma mark - Round
/**
 *  @param digit  限制最大位数
 */
///四舍五入
- (NSNumber *)jl_doRoundWithDigit:(NSUInteger)digit;
///取上整（只入不舍,自动去零）
- (NSNumber *)jl_doCeilWithDigit:(NSUInteger)digit;
///取上整（只入不舍,不去零）
- (NSString *)jl_doCeilWithMinDigit:(NSUInteger)digit;
///取下整（只舍不入,自动去零）
- (NSNumber *)jl_doFloorWithDigit:(NSUInteger)digit;
///取下整（只舍不入,不去零）
- (NSString *)jl_doFloorWithMinDigit:(NSUInteger)digit;

#pragma mark - 计算
/**
 *  计算-加法
 *  addend：加数
 *  augend：被加数
 **/
+ (NSNumber *)jl_calculateBySubtractingWithAddend:(double)addend augend:(double)augend;

/**
 *  计算-减法
 *  subtrahend：减数
 *  minuend：被减数
 **/
+ (NSNumber *)jl_calculateBySubtractingWithSubtrahend:(double)subtrahend minuend:(double)minuend;

/**
 *  计算-乘法
 *  multiplier：乘数
 *  multiplicand：被乘数
 **/
+ (NSNumber *)jl_calculateBySubtractingWithMultiplier:(double)multiplier multiplicand:(double)multiplicand;

/**
 *  计算-除法
 *  divisor：除数
 *  dividend：被除数
 **/
+ (NSNumber *)jl_calculateBySubtractingWithDivisor:(double)divisor dividend:(double)dividend;


@end
