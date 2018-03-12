//
//  NSDate+JLDateKit.h
//  JLToolsAndCategories
//
//  Created by Long on 16/4/13.
//  Copyright © 2016年 Long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDate (JLDateKit)

#pragma mark - 扩展属性
///年
@property (nonatomic, readonly) NSInteger year; ///< Year component
///月
@property (nonatomic, readonly) NSInteger month; ///< Month component (1~12)
///日
@property (nonatomic, readonly) NSInteger day; ///< Day component (1~31)
///时
@property (nonatomic, readonly) NSInteger hour; ///< Hour component (0~23)
///分
@property (nonatomic, readonly) NSInteger minute; ///< Minute component (0~59)
///秒
@property (nonatomic, readonly) NSInteger second; ///< Second component (0~59)
///毫秒
@property (nonatomic, readonly) NSInteger nanosecond; ///< Nanosecond component
///周几
@property (nonatomic, readonly) NSInteger weekday; ///< Weekday component (1~7, first day is based on user setting)
///当月的第几个周几
@property (nonatomic, readonly) NSInteger weekdayOrdinal; ///< WeekdayOrdinal component
///当月的第几周
@property (nonatomic, readonly) NSInteger weekOfMonth; ///< WeekOfMonth component (1~5)
///当年的第几周
@property (nonatomic, readonly) NSInteger weekOfYear; ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger yearForWeekOfYear; ///< YearForWeekOfYear component
///季度
@property (nonatomic, readonly) NSInteger quarter; ///< Quarter component

#pragma mark - 获取日、月、年、小时、分钟、秒
///获取日
- (NSUInteger)jl_day;
///获取月
- (NSUInteger)jl_month;
///获取年
- (NSUInteger)jl_year;
///获取时
- (NSUInteger)jl_hour;
///获取分
- (NSUInteger)jl_minute;
///获取秒
- (NSUInteger)jl_second;
///获取date日
+ (NSUInteger)jl_day:(NSDate *)date;
///获取date月
+ (NSUInteger)jl_month:(NSDate *)date;
///获取date年
+ (NSUInteger)jl_year:(NSDate *)date;
///获取date时
+ (NSUInteger)jl_hour:(NSDate *)date;
///获取date分
+ (NSUInteger)jl_minute:(NSDate *)date;
///获取date秒
+ (NSUInteger)jl_second:(NSDate *)date;

#pragma mark - 获取一年中的总天数
///获取一年中的总天数
- (NSUInteger)jl_daysInYear;
///获取date年中的总天数
+ (NSUInteger)jl_daysInYear:(NSDate *)date;

#pragma mark - 判断是否是润年
/**
 * @return YES表示润年，NO表示平年
 */
///是否为润年
- (BOOL)jl_isLeapYear;
///date是否为润年
+ (BOOL)jl_isLeapYear:(NSDate *)date;

#pragma mark - 获取格式化为YYYY-MM-dd格式的日期字符串
///获取格式化为YYYY-MM-dd格式的日期字符串
- (NSString *)jl_formatYMD;
///获取date格式化为YYYY-MM-dd格式的日期字符串
+ (NSString *)jl_formatYMD:(NSDate *)date;

#pragma mark - 获取该日期是该年的第几周
///获取该日期是该年的第几周
- (NSUInteger)jl_weekOfYear;
///获取date是该年的第几周
+ (NSUInteger)jl_weekOfYear:(NSDate *)date;

#pragma mark - 获取当前月一共有几周(可能为4,5,6)
///获取当前月一共有几周
- (NSUInteger)jl_weeksOfMonth;
///获取date月一共有几周
+ (NSUInteger)jl_weeksOfMonth:(NSDate *)date;

#pragma mark - 获取该月的第一天的日期
///获取该月的第一天的日期
- (NSDate *)jl_begindayOfMonth;
///获取date月的第一天的日期
+ (NSDate *)jl_begindayOfMonth:(NSDate *)date;

#pragma mark - 获取该月的最后一天的日期
///获取该月的最后一天的日期
- (NSDate *)jl_lastdayOfMonth;
///获取date月的最后一天的日期
+ (NSDate *)jl_lastdayOfMonth:(NSDate *)date;

#pragma mark - 获取day天后的日期(若day为负数,则为|day|天前的日期)
///获取day天后的日期
- (NSDate *)jl_dateAfterDay:(int)day;
///获取day天后的日期
+ (NSDate *)jl_dateAfterDate:(NSDate *)date day:(int)day;

#pragma mark - 获取month月后的日期
///获取month月后的日期
- (NSDate *)jl_dateAfterMonth:(int)month;
///获取month月后的日期
+ (NSDate *)jl_dateAfterDate:(NSDate *)date month:(int)month;

#pragma mark - 获取numYears年后的日期
///获取numYears年后的日期
- (NSDate *)jl_offsetYears:(int)numYears;
///获取numYears年后的日期
+ (NSDate *)jl_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

#pragma mark - 获取numMonths月后的日期
///获取numMonths月后的日期
- (NSDate *)jl_offsetMonths:(int)numMonths;
///获取numMonths月后的日期
+ (NSDate *)jl_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

#pragma mark - 获取numDays天后的日期
///获取numDays天后的日期
- (NSDate *)jl_offsetDays:(int)numDays;
///获取numDays天后的日期
+ (NSDate *)jl_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

#pragma mark - 获取numHours小时后的日期
///获取hours小时后的日期
- (NSDate *)jl_offsetHours:(int)hours;
///获取numHours小时后的日期
+ (NSDate *)jl_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

#pragma mark - 距离该日期前几天
///距离该日期的天数
- (NSUInteger)jl_daysAgo;
///距离该日期的天数
+ (NSUInteger)jl_daysAgo:(NSDate *)date;

#pragma mark - 获取星期几
/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
///获取星期几
- (NSInteger)jl_weekday;
///获取星期几
+ (NSInteger)jl_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
///获取星期几(名称)
- (NSString *)jl_dayFromWeekday;
///获取星期几(名称)
+ (NSString *)jl_dayFromWeekday:(NSDate *)date;

#pragma mark - 判断日期是否相等
/**
 * @return YES表示相等，NO表示不相等
 */
///判断日期是否相等
- (BOOL)jl_isSameDay:(NSDate *)anotherDate;

#pragma mark - 是否是今天
/**
 * @return YES表示是今天，NO表示不是今天
 */
- (BOOL)jl_isToday;

#pragma mark - 获取date增加后的日期
///获取date增加years年后的日期
- (NSDate *)jl_dateByAddingYears:(int)years;
///获取date增加months月后的日期
- (NSDate *)jl_dateByAddingMonths:(int)months;
///获取date增加weeks周后的日期
- (NSDate *)jl_dateByAddingWeeks:(int)weeks;
///获取date增加days天后的日期
- (NSDate *)jl_dateByAddingDays:(int)days;
///获取date增加hours小时后的日期
- (NSDate *)jl_dateByAddingHours:(int)hours;
///获取date增加minutes分钟后的日期
- (NSDate *)jl_dateByAddingMinutes:(int)minutes;
///获取date增加seconds秒后的日期
- (NSDate *)jl_dateByAddingSeconds:(int)seconds;

#pragma mark - 获取几月(名称)
/**
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
///获取几月(英文)
+ (NSString *)jl_monthWithMonthNumber:(int)month;
///获取几月(中文)
+ (NSString *)jl_monthChineseWithMonthNumber:(int)month;

#pragma mark - 根据日期返回字符串
+ (NSString *)jl_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)jl_stringWithFormat:(NSString *)format;
+ (NSDate *)jl_dateWithString:(NSString *)string format:(NSString *)format;

#pragma mark - JAVA时间戳转换
+ (NSString *)jl_stringWithFormatJaveTime:(NSString *)timeIntervalStr format:(NSString *)format;
///JAVA时间戳转换（yyyy-MM-dd）
+ (NSString *)jl_stringWithFormatJaveTimeYMD:(NSString *)timeIntervalStr;
///JAVA时间戳转换（yyyy-MM-dd HH:mm）
+ (NSString *)jl_stringWithFormatJaveTimeYMDHM:(NSString *)timeIntervalStr;
///JAVA时间戳转换（yyyy-MM-dd HH:mm:ss）
+ (NSString *)jl_stringWithFormatJaveTimeYMDHMS:(NSString *)timeIntervalStr;

#pragma mark - 获取Date年指定月份的天数
///获取Date年指定月份的天数
- (NSUInteger)jl_daysInMonth:(NSUInteger)month;
///获取Date年指定月份的天数
+ (NSUInteger)jl_daysInMonth:(NSDate *)date month:(NSUInteger)month;

#pragma mark - 获取Date当前月份的天数
///获取Date当前月份的天数
- (NSUInteger)jl_daysInMonth;
///获取Date当前月份的天数
+ (NSUInteger)jl_daysInMonth:(NSDate *)date;

#pragma mark - 获取x分钟前/x小时前/昨天/x天前/x个月前/x年前
///返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
- (NSString *)jl_timeInfo;
///返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
+ (NSString *)jl_timeInfoWithDate:(NSDate *)date;
///返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
+ (NSString *)jl_timeInfoWithDateString:(NSString *)dateString;

#pragma mark - 获取时间格式字符串
///yyyy-MM-dd
- (NSString *)jl_ymdFormat;
///HH:mm:ss
- (NSString *)jl_hmsFormat;
///yyyy-MM-dd HH:mm
- (NSString *)jl_ymdhmFormat;
///yyyy-MM-dd HH:mm:ss
- (NSString *)jl_ymdHmsFormat;
///yyyy-MM-dd
+ (NSString *)jl_ymdFormat;
///HH:mm:ss
+ (NSString *)jl_hmsFormat;
///yyyy-MM-dd HH:mm
+ (NSString *)jl_ymdhmFormat;
///yyyy-MM-dd HH:mm:ss
+ (NSString *)jl_ymdHmsFormat;

@end
