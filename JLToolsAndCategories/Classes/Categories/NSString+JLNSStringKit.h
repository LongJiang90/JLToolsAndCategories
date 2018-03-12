//
//  NSString+JLNSStringKit.h
//  JLToolsAndCategories
//
//  Created by Long on 16/4/13.
//  Copyright © 2016年 Long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (JLNSStringKit)

#pragma mark - 拼音
/**
 *  以下方法的实现主要使用了CoreFoundation库自带的CFString文件中的CFString​Transform函数
 **/
///汉字转拼音
- (NSString*)jl_pinyinWithPhoneticSymbol;
///汉字转拼音
- (NSString*)jl_pinyin;
///汉字转拼音数组
- (NSArray*)jl_pinyinArray;
///汉字转拼音去空格
- (NSString*)jl_pinyinWithoutBlank;
///所有汉字的首写字母数组
- (NSArray*)jl_pinyinInitialsArray;
///所有汉字的首写字母字符串
- (NSString*)jl_pinyinInitialsString;

#pragma mark - 字符串SIZE
///计算文字的大小
- (CGSize)jl_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;
///计算文字的大小(约束宽度)
- (CGSize)jl_sizeForFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
///计算文字的大小(约束高度)
- (CGSize)jl_sizeForFont:(UIFont *)font constrainedToHeight:(CGFloat)height;
///计算文字的宽度
- (CGFloat)jl_widthForFont:(UIFont *)font;
///计算文字的宽度（约束高度）
- (CGFloat)jl_widthForFont:(UIFont *)font constrainedToHeight:(CGFloat)height;
///计算文字的高度（约束宽度）
- (CGFloat)jl_heightForFont:(UIFont *)font width:(CGFloat)width;

#pragma mark - 字符串验证
///正则表达式验证
- (BOOL)jl_matchesRegex:(NSString *)regex options:(NSRegularExpressionOptions)options;
///正则表达式验证后BLOCK操作
- (void)jl_enumerateRegexMatches:(NSString *)regex
                         options:(NSRegularExpressionOptions)options
                      usingBlock:(void (^)(NSString *match, NSRange matchRange, BOOL *stop))block;
///获得字符串中符合正则表达式的字符串
- (NSString *)jl_stringByReplacingRegex:(NSString *)regex
                                options:(NSRegularExpressionOptions)options
                             withString:(NSString *)replacement;
///是否为空字符串
- (BOOL)jl_isEmptyString;

#pragma mark - Emoji
///是否包含Emoji
- (BOOL)jl_containsEmoji;
///是否包含Emoji（根据系统版本）
- (BOOL)jl_containsEmojiForSystemVersion:(float)systemVersion;
///删除字符串中包含的Emoji
- (NSString *)jl_removedEmojiString;

#pragma mark - MIME
///根据文件url 返回对应的MIMEType
- (NSString *)jl_MIMEType;
///根据文件url后缀 返回对应的MIMEType
+ (NSString *)jl_MIMETypeForExtension:(NSString *)extension;
///常见MIME集合
+ (NSDictionary *)jl_MIMEDict;

#pragma mark - 类型转换
///NSInteger型转为字符串
+ (NSString *)jl_stringWithIntegerValue:(NSInteger)value;
///CGFloat型转为小数点后places位的字符串
+ (NSString *)jl_stringWithFloatValue:(CGFloat)value places:(NSInteger)places;
///
+ (NSString *)jl_stringWithTruncatedFloatValue:(CGFloat)value;
///
+ (NSString *)jl_stringWithFloatValue:(CGFloat)value zero:(NSString *)zero singluar:(NSString *)singular plural:(NSString *)plural;
///Unicode编码的字符串转成NSString
- (NSString *)jl_makeUnicodeToString;

@property (readonly) char charValue;
@property (readonly) unsigned char unsignedCharValue;
@property (readonly) short shortValue;
@property (readonly) unsigned short unsignedShortValue;
@property (readonly) unsigned int unsignedIntValue;
@property (readonly) long longValue;
@property (readonly) unsigned long unsignedLongValue;
@property (readonly) unsigned long long unsignedLongLongValue;
@property (readonly) NSUInteger unsignedIntegerValue;

///NSString转NSNumber
- (NSNumber *)jl_numberValue;
///NSString转NSData
- (NSData *)jl_dataValue;
///NSString转NSData[针对特殊编码]
- (NSData *)jl_dataValueWithEncoding:(NSStringEncoding)encoding;
///NSString转Byte集合
- (Byte *)jl_Byte;
///NSString转Byte集合[针对特殊编码]
- (Byte *)jl_byteWithEncoding:(NSStringEncoding)encoding;
///获得NSString的NSRange
- (NSRange)jl_rangeOfAll;

#pragma mark - 字符串处理
///是否包含中文
- (BOOL)jl_isContainChinese;
///字符串中是否包含另一个字符串
- (BOOL)jl_containsaString:(NSString *)string;
///是否包含空格
- (BOOL)jl_isContainBlank;
///判断字符串是否全为数字 不能包含小数点这些
- (BOOL)jl_isPureNumandCharacters:(NSString *)string;
///判断字符串是否为浮点型
- (BOOL)jl_isPureFloat:(NSString *)string;
///判断是否是正确的身份证号
- (BOOL)jl_validateIdentityCard:(NSString *)identityCard;

///字符串去空格
- (NSString *)jl_stringByTrim;
///去除字符串与空行
- (NSString *)jl_trimmingWhitespaceAndNewlines;
///清除html标签
- (NSString *)jl_stringByStrippingHTML;
///清除js脚本
- (NSString *)jl_stringByRemovingScriptsAndStrippingHTML;

///获取字符数量
- (int)jl_wordsCount;

///截取字符串中的对应字节数字符
- (NSString *)jl_cutByteBytesCount:(int)count;
///把手机号码中间几位显示为*****
- (NSString *)jl_changeMobileNumber;



#pragma mark - UUID(唯一性验证)
///获取随机 UUID
+ (NSString *)jl_stringWithUUID;
///毫秒时间戳
+ (NSString *)jl_UUIDTimestamp;

#pragma mark - 通过文件资源获取字符串
///通过文件名获取字符串
+ (NSString *)jl_stringWithNamed:(NSString *)name;

#pragma mark - NSAttributedString
///NSString 转 NSMutableAttributedString
+ (NSMutableAttributedString *)jl_attributedStringWithStrings:(NSArray <NSString *> *)strings fonts:(NSArray <UIFont *> *)fonts colours:(NSArray <UIColor *> *)colours;
///返回attributedString基础的font、color属性字典
+ (NSDictionary *)jl_attributedTextDicWithFont:(UIFont *)font color:(UIColor *)color;

@end
