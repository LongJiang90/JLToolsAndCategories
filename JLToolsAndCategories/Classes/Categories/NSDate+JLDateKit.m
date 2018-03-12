//
//  NSDate+JLDateKit.m
//  JLToolsAndCategories
//
//  Created by Long on 16/4/13.
//  Copyright © 2016年 Long. All rights reserved.
//

#import "NSDate+JLDateKit.h"

@implementation NSDate (JLDateKit)


#pragma mark - 扩展属性
- (NSInteger)year
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekdayOrdinal
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)quarter
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

#pragma mark - 获取日、月、年、小时、分钟、秒
#pragma mark ---获取日
- (NSUInteger)jl_day
{
    return [NSDate jl_day:self];
}

#pragma mark ---获取月
- (NSUInteger)jl_month
{
    return [NSDate jl_month:self];
}

#pragma mark ---获取年
- (NSUInteger)jl_year
{
    return [NSDate jl_year:self];
}

#pragma mark ---获取时
- (NSUInteger)jl_hour
{
    return [NSDate jl_hour:self];
}

#pragma mark ---获取分
- (NSUInteger)jl_minute
{
    return [NSDate jl_minute:self];
}

#pragma mark ---获取秒
- (NSUInteger)jl_second
{
    return [NSDate jl_second:self];
}

#pragma mark ---获取date日
+ (NSUInteger)jl_day:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

#pragma mark ---获取date月
+ (NSUInteger)jl_month:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

#pragma mark ---获取date年
+ (NSUInteger)jl_year:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

#pragma mark ---获取date时
+ (NSUInteger)jl_hour:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

#pragma mark ---获取date分
+ (NSUInteger)jl_minute:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

#pragma mark ---获取date秒
+ (NSUInteger)jl_second:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

#pragma mark - 获取一年中的总天数
#pragma mark ---获取一年中的总天数
- (NSUInteger)jl_daysInYear
{
    return [NSDate jl_daysInYear:self];
}

#pragma mark ---获取date年中的总天数
+ (NSUInteger)jl_daysInYear:(NSDate *)date
{
    return [self jl_isLeapYear:date] ? 366 : 365;
}

#pragma mark - 判断是否是润年
#pragma mark ---是否为润年
- (BOOL)jl_isLeapYear
{
    return [NSDate jl_isLeapYear:self];
}

#pragma mark ---date是否为润年
+ (BOOL)jl_isLeapYear:(NSDate *)date
{
    NSUInteger year = [date year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

#pragma mark - 获取格式化为YYYY-MM-dd格式的日期字符串
#pragma mark ---获取格式化为YYYY-MM-dd格式的日期字符串
- (NSString *)jl_formatYMD
{
    return [NSDate jl_formatYMD:self];
}

#pragma mark ---获取date格式化为YYYY-MM-dd格式的日期字符串
+ (NSString *)jl_formatYMD:(NSDate *)date
{
    return [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)[date year],(long)[date month], (long)[date day]];
}

#pragma mark - 获取该日期是该年的第几周
#pragma mark ---获取该日期是该年的第几周
- (NSUInteger)jl_weekOfYear
{
    return [NSDate jl_weekOfYear:self];
}

#pragma mark ---获取date是该年的第几周
+ (NSUInteger)jl_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date year];
    
    NSDate *lastdate = [date jl_lastdayOfMonth];
    
    for (i = 1;[[lastdate jl_dateAfterDay:@(-7 * i).intValue] year] == year; i++) {
        
    }
    
    return i;
}

#pragma mark - 获取当前月一共有几周(可能为4,5,6)
#pragma mark ---获取当前月一共有几周
- (NSUInteger)jl_weeksOfMonth
{
    return [NSDate jl_weeksOfMonth:self];
}

#pragma mark ---获取date月一共有几周
+ (NSUInteger)jl_weeksOfMonth:(NSDate *)date
{
    return [[date jl_lastdayOfMonth] weekOfYear] - [[date jl_begindayOfMonth] weekOfYear] + 1;
}

#pragma mark - 获取该月的第一天的日期
#pragma mark ---获取该月的第一天的日期
- (NSDate *)jl_begindayOfMonth
{
    return [NSDate jl_begindayOfMonth:self];
}

#pragma mark ---获取date月的第一天的日期
+ (NSDate *)jl_begindayOfMonth:(NSDate *)date
{
    NSString *dateDay = [NSString stringWithFormat:@"%ld",(long)[date day]];
    return [self jl_dateAfterDate:date day:-dateDay.intValue + 1];
}

#pragma mark - 获取该月的最后一天的日期
#pragma mark ---获取该月的最后一天的日期
- (NSDate *)jl_lastdayOfMonth
{
    return [NSDate jl_lastdayOfMonth:self];
}

#pragma mark ---获取date月的最后一天的日期
+ (NSDate *)jl_lastdayOfMonth:(NSDate *)date
{
    NSDate *lastDate = [self jl_begindayOfMonth:date];
    return [[lastDate jl_dateAfterMonth:1] jl_dateAfterDay:-1];
}

#pragma mark - 获取day天后的日期(若day为负数,则为|day|天前的日期)
#pragma mark ---获取day天后的日期
- (NSDate *)jl_dateAfterDay:(int)day
{
    return [NSDate jl_dateAfterDate:self day:day];
}

#pragma mark ---获取day天后的日期
+ (NSDate *)jl_dateAfterDate:(NSDate *)date day:(int)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

#pragma mark - 获取month月后的日期
#pragma mark ---获取month月后的日期
- (NSDate *)jl_dateAfterMonth:(int)month
{
    return [NSDate jl_dateAfterDate:self month:month];
}

#pragma mark ---获取month月后的日期
+ (NSDate *)jl_dateAfterDate:(NSDate *)date month:(int)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

#pragma mark - 获取numYears年后的日期
#pragma mark ---获取numYears年后的日期
- (NSDate *)jl_offsetYears:(int)numYears
{
    return [NSDate jl_offsetYears:numYears fromDate:self];
}

#pragma mark ---获取numYears年后的日期
+ (NSDate *)jl_offsetYears:(int)numYears fromDate:(NSDate *)fromDate
{
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

#pragma mark - 获取numMonths月后的日期
#pragma mark ---获取numMonths月后的日期
- (NSDate *)jl_offsetMonths:(int)numMonths
{
    return [NSDate jl_offsetMonths:numMonths fromDate:self];
}

#pragma mark ---获取numMonths月后的日期
+ (NSDate *)jl_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate
{
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

#pragma mark - 获取numDays天后的日期
#pragma mark ---获取numDays天后的日期
- (NSDate *)jl_offsetDays:(int)numDays
{
    return [NSDate jl_offsetDays:numDays fromDate:self];
}

#pragma mark ---获取numDays天后的日期
+ (NSDate *)jl_offsetDays:(int)numDays fromDate:(NSDate *)fromDate
{
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

#pragma mark - 获取numHours小时后的日期
#pragma mark ---获取numHours小时后的日期
- (NSDate *)jl_offsetHours:(int)hours
{
    return [NSDate jl_offsetHours:hours fromDate:self];
}

#pragma mark ---获取numHours小时后的日期
+ (NSDate *)jl_offsetHours:(int)numHours fromDate:(NSDate *)fromDate
{
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

#pragma mark - 距离该日期前几天
#pragma mark ---距离该日期的天数
- (NSUInteger)jl_daysAgo
{
    return [NSDate jl_daysAgo:self];
}

#pragma mark ---距离该日期的天数
+ (NSUInteger)jl_daysAgo:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

#pragma mark - 获取星期几
#pragma mark ---获取星期几
- (NSInteger)jl_weekday
{
    return [NSDate jl_weekday:self];
}

#pragma mark ---获取星期几
+ (NSInteger)jl_weekday:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

#pragma mark ---获取星期几(名称)
- (NSString *)jl_dayFromWeekday
{
    return [NSDate jl_dayFromWeekday:self];
}

#pragma mark ---获取星期几(名称)
+ (NSString *)jl_dayFromWeekday:(NSDate *)date
{
    switch([date weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

#pragma mark - 判断日期是否相等
- (BOOL)jl_isSameDay:(NSDate *)anotherDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

#pragma mark - 是否是今天
- (BOOL)jl_isToday
{
    return [self jl_isSameDay:[NSDate date]];
}

#pragma mark - 获取date增加后的日期
#pragma mark ---获取date增加years年后的日期
- (NSDate *)jl_dateByAddingYears:(int)years
{
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark ---获取date增加months月后的日期
- (NSDate *)jl_dateByAddingMonths:(int)months
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark ---获取date增加weeks周后的日期
- (NSDate *)jl_dateByAddingWeeks:(int)weeks
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark ---获取date增加days天后的日期
- (NSDate *)jl_dateByAddingDays:(int)days
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark ---获取date增加hours小时后的日期
- (NSDate *)jl_dateByAddingHours:(int)hours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 3600 * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark ---获取date增加minutes分钟后的日期
- (NSDate *)jl_dateByAddingMinutes:(int)minutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 60 * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark ---获取date增加seconds秒后的日期
- (NSDate *)jl_dateByAddingSeconds:(int)seconds
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - 获取几月(名称)
#pragma mark ---获取几月(英文)
+ (NSString *)jl_monthWithMonthNumber:(int)month
{
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

#pragma mark ---获取几月(中文)
+ (NSString *)jl_monthChineseWithMonthNumber:(int)month
{
    switch(month) {
        case 1:
            return @"一月";
            break;
        case 2:
            return @"二月";
            break;
        case 3:
            return @"三月";
            break;
        case 4:
            return @"四月";
            break;
        case 5:
            return @"五月";
            break;
        case 6:
            return @"六月";
            break;
        case 7:
            return @"七月";
            break;
        case 8:
            return @"八月";
            break;
        case 9:
            return @"九月";
            break;
        case 10:
            return @"十月";
            break;
        case 11:
            return @"十一月";
            break;
        case 12:
            return @"十二月";
            break;
        default:
            break;
    }
    return @"";
}

#pragma mark - 根据日期返回字符串
+ (NSString *)jl_stringWithDate:(NSDate *)date format:(NSString *)format
{
    return [date jl_stringWithFormat:format];
}

- (NSString *)jl_stringWithFormat:(NSString *)format
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)jl_dateWithString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

#pragma mark - JAVA时间戳转换
+ (NSString *)jl_stringWithFormatJaveTime:(NSString *)timeIntervalStr format:(NSString *)format
{
    if ([timeIntervalStr isEqualToString:@""] || [timeIntervalStr isKindOfClass:[NSNull class]] || timeIntervalStr == nil) {
        return @"";
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeIntervalStr.doubleValue / 1000];
    
    NSString *dateStr = [date jl_stringWithFormat:format];
    
    return dateStr;
}

+ (NSString *)jl_stringWithFormatJaveTimeYMD:(NSString *)timeIntervalStr
{
    return [self jl_stringWithFormatJaveTime:timeIntervalStr format:[self jl_ymdFormat]];
}

+ (NSString *)jl_stringWithFormatJaveTimeYMDHM:(NSString *)timeIntervalStr
{
    return [self jl_stringWithFormatJaveTime:timeIntervalStr format:[self jl_ymdhmFormat]];
}

+ (NSString *)jl_stringWithFormatJaveTimeYMDHMS:(NSString *)timeIntervalStr
{
    return [self jl_stringWithFormatJaveTime:timeIntervalStr format:[self jl_ymdHmsFormat]];
}

#pragma mark - 获取Date年指定月份的天数
- (NSUInteger)jl_daysInMonth:(NSUInteger)month
{
    return [NSDate jl_daysInMonth:self month:month];
}

+ (NSUInteger)jl_daysInMonth:(NSDate *)date month:(NSUInteger)month
{
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date jl_isLeapYear] ? 29 : 28;
    }
    return 30;
}

#pragma mark - 获取Date当前月份的天数
- (NSUInteger)jl_daysInMonth
{
    return [NSDate jl_daysInMonth:self];
}

+ (NSUInteger)jl_daysInMonth:(NSDate *)date
{
    return [self jl_daysInMonth:date month:[date month]];
}

#pragma mark - 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
- (NSString *)jl_timeInfo
{
    return [NSDate jl_timeInfoWithDate:self];
}

+ (NSString *)jl_timeInfoWithDate:(NSDate *)date
{
    return [self jl_timeInfoWithDateString:[self jl_stringWithDate:date format:[self jl_ymdHmsFormat]]];
}

+ (NSString *)jl_timeInfoWithDateString:(NSString *)dateString
{
    NSDate *date = [self jl_dateWithString:dateString format:[self jl_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate month] - [date month]);
    int year = (int)([curDate year] - [date year]);
    int day = (int)([curDate day] - [date day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate month] == 1 && [date month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self jl_daysInMonth:date month:[date month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate day] + (totalDays - (int)[date day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate month];
            int preMonth = (int)[date month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

#pragma mark - 获取时间格式字符串
#pragma mark ---yyyy-MM-dd
- (NSString *)jl_ymdFormat
{
    return [NSDate jl_ymdFormat];
}

#pragma mark ---HH:mm:ss
- (NSString *)jl_hmsFormat
{
    return [NSDate jl_hmsFormat];
}

#pragma mark ---yyyy-MM-dd HH:mm
- (NSString *)jl_ymdhmFormat
{
    return [NSDate jl_ymdhmFormat];
}

#pragma mark ---yyyy-MM-dd HH:mm:ss
- (NSString *)jl_ymdHmsFormat
{
    return [NSDate jl_ymdHmsFormat];
}

#pragma mark ---yyyy-MM-dd
+ (NSString *)jl_ymdFormat
{
    return @"yyyy-MM-dd";
}

#pragma mark ---HH:mm:ss
+ (NSString *)jl_hmsFormat
{
    return @"HH:mm:ss";
}

#pragma mark ---yyyy-MM-dd HH:mm
+ (NSString *)jl_ymdhmFormat
{
    return [NSString stringWithFormat:@"%@ %@", [self jl_ymdFormat], @"HH:mm"];
}

#pragma mark ---yyyy-MM-dd HH:mm:ss
+ (NSString *)jl_ymdHmsFormat
{
    return [NSString stringWithFormat:@"%@ %@", [self jl_ymdFormat], [self jl_hmsFormat]];
}

@end
