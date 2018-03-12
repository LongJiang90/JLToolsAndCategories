//
//  NSNumber+JLNSNumberKit.m
//  JLToolsAndCategories
//
//  Created by Long on 16/4/14.
//  Copyright © 2016年 Long. All rights reserved.
//

#import "NSNumber+JLNSNumberKit.h"
#import "NSString+JLNSStringKit.h"

@implementation NSNumber (JLNSNumberKit)

#pragma mark - 类型转换
#pragma mark ---NSString转NSNumber
+ (NSNumber *)jl_numberWithString:(NSString *)string
{
    NSString *str = [[string jl_stringByTrim] lowercaseString];
    if (!str || !str.length) {
        return nil;
    }
    
    static NSDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{@"true" :   @(YES),
                @"yes" :    @(YES),
                @"false" :  @(NO),
                @"no" :     @(NO),
                @"nil" :    [NSNull null],
                @"null" :   [NSNull null],
                @"<null>" : [NSNull null]};
    });
    NSNumber *num = dic[str];
    if (num) {
        if (num == (id)[NSNull null]) return nil;
        return num;
    }
    
    // hex number
    int sign = 0;
    if ([str hasPrefix:@"0x"]) sign = 1;
    else if ([str hasPrefix:@"-0x"]) sign = -1;
    if (sign != 0) {
        NSScanner *scan = [NSScanner scannerWithString:str];
        unsigned num = -1;
        BOOL suc = [scan scanHexInt:&num];
        if (suc)
            return [NSNumber numberWithLong:((long)num * sign)];
        else
            return nil;
    }
    // normal number
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter numberFromString:string];
}

#pragma mark ---NSNumber转NSString
- (NSString *)jl_numberStringWithDigit:(NSInteger)digit
{
    NSString *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    result = [formatter  stringFromNumber:self];
    if (result == nil)
        return @"";
    return result;
    
}

#pragma mark ---NSNumber转NSString【百分比】
- (NSString *)jl_percentageStringWithDigit:(NSInteger)digit
{
    NSString *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    //NSLog(@"percentage target:%@ result:%@",number,[formatter  stringFromNumber:number]);
    result = [formatter  stringFromNumber:self];
    return result;
}

#pragma mark ---NSNumber转罗马数字字符串
- (NSString *)jl_romanNumeralString
{
    NSInteger n = [self integerValue];
    
    NSArray *numerals = [NSArray arrayWithObjects:@"M", @"CM", @"D", @"CD", @"C", @"XC", @"L", @"XL", @"X", @"IX", @"V", @"IV", @"I", nil];
    
    NSUInteger valueCount = 13;
    NSUInteger values[] = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
    
    NSMutableString *numeralString = [NSMutableString string];
    
    for (NSUInteger i = 0; i < valueCount; i++)
    {
        while (n >= values[i])
        {
            n -= values[i];
            [numeralString appendString:[numerals objectAtIndex:i]];
        }
    }
    
    return numeralString;
}

#pragma mark ---NSNumber转CGFloat
- (CGFloat)jl_CGFloatValue
{
#if (CGFLOAT_IS_DOUBLE == 1)
    CGFloat result = [self doubleValue];
#else
    CGFloat result = [self floatValue];
#endif
    return result;
}

#pragma mark ---用CGFloat初始化NSNumber
- (id)initWithCGFloat:(CGFloat)value
{
#if (CGFLOAT_IS_DOUBLE == 1)
    self = [self initWithDouble:value];
#else
    self = [self initWithFloat:value];
#endif
    return self;
}

#pragma mark ---用CGFloat初始化NSNumber
+ (NSNumber *)jl_numberWithCGFloat:(CGFloat)value
{
    NSNumber *result = [[self alloc] initWithCGFloat:value];
    return result;
}

#pragma mark - Round
#pragma mark ---四舍五入
- (NSNumber *)jl_doRoundWithDigit:(NSUInteger)digit
{
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    [formatter setMinimumFractionDigits:digit];
    
    result = [NSNumber numberWithDouble:[[formatter stringFromNumber:self] doubleValue]];
    return result;
}

#pragma mark ---取上整（只入不舍,自动去零）
- (NSNumber *)jl_doCeilWithDigit:(NSUInteger)digit
{
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundCeiling];
    [formatter setMaximumFractionDigits:digit];
    
    result = [NSNumber numberWithDouble:[[formatter stringFromNumber:self] doubleValue]];
    return result;
}

#pragma mark ---取上整（只入不舍,不去零）
- (NSString *)jl_doCeilWithMinDigit:(NSUInteger)digit
{
    NSString *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundCeiling];
    [formatter setMinimumFractionDigits:digit];
    result = [formatter stringFromNumber:self];
    
    return result;
}

#pragma mark ---取下整（只舍不入,自动去零）
- (NSNumber *)jl_doFloorWithDigit:(NSUInteger)digit
{
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundFloor];
    [formatter setMaximumFractionDigits:digit];
    result = [NSNumber numberWithDouble:[[formatter stringFromNumber:self] doubleValue]];
    
    return result;
}

#pragma mark ---取下整（只舍不入,不去零）
- (NSString *)jl_doFloorWithMinDigit:(NSUInteger)digit
{
    NSString *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundFloor];
    [formatter setMinimumFractionDigits:digit];
    result = [formatter stringFromNumber:self];
    
    return result;
}

#pragma mark - 计算
#pragma mark ---加
+ (NSNumber *)jl_calculateBySubtractingWithAddend:(double)addend augend:(double)augend
{
    NSString *addendStr = [NSString stringWithFormat:@"%.02f",addend];
    NSString *augendStr = [NSString stringWithFormat:@"%.02f",augend];
    
    NSDecimalNumber *addendNum = [NSDecimalNumber decimalNumberWithString:addendStr];
    NSDecimalNumber *augendNum = [NSDecimalNumber decimalNumberWithString:augendStr];
    
    NSDecimalNumber *resultNum = [addendNum decimalNumberByAdding:augendNum];
    
    return resultNum;
}

#pragma mark ---减
+ (NSNumber *)jl_calculateBySubtractingWithSubtrahend:(double)subtrahend minuend:(double)minuend
{
    NSString *subtrahendStr = [NSString stringWithFormat:@"%.02f",subtrahend];
    NSString *minuendStr = [NSString stringWithFormat:@"%.02f",minuend];
    
    NSDecimalNumber *subtrahendNum = [NSDecimalNumber decimalNumberWithString:subtrahendStr];
    NSDecimalNumber *minuendNum = [NSDecimalNumber decimalNumberWithString:minuendStr];
    
    NSDecimalNumber *resultNum = [subtrahendNum decimalNumberBySubtracting:minuendNum];
    
    return resultNum;
}

#pragma mark ---乘
+ (NSNumber *)jl_calculateBySubtractingWithMultiplier:(double)multiplier multiplicand:(double)multiplicand
{
    NSString *multiplierStr = [NSString stringWithFormat:@"%.02f",multiplier];
    NSString *multiplicandStr = [NSString stringWithFormat:@"%.02f",multiplicand];
    
    NSDecimalNumber *multiplierNum = [NSDecimalNumber decimalNumberWithString:multiplierStr];
    NSDecimalNumber *multiplicandNum = [NSDecimalNumber decimalNumberWithString:multiplicandStr];
    
    NSDecimalNumber *resultNum = [multiplierNum decimalNumberByMultiplyingBy:multiplicandNum];
    
    return resultNum;
}

#pragma mark ---除
+ (NSNumber *)jl_calculateBySubtractingWithDivisor:(double)divisor dividend:(double)dividend
{
    NSString *divisorStr = [NSString stringWithFormat:@"%.02f",divisor];
    NSString *dividendStr = [NSString stringWithFormat:@"%.02f",dividend];
    
    NSDecimalNumber *divisorNum = [NSDecimalNumber decimalNumberWithString:divisorStr];
    NSDecimalNumber *dividendNum = [NSDecimalNumber decimalNumberWithString:dividendStr];
    
    NSDecimalNumber *resultNum = [divisorNum decimalNumberByDividingBy:dividendNum];
    
    return resultNum;
}

@end
