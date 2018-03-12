//
//  JLTools.h
//  JLToolsAndCategories
//
//  Created by Long on 16/4/13.
//  Copyright © 2016年 Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Accelerate/Accelerate.h>
#import <CoreText/CoreText.h>

#define NET_WORK_STATUS @"NetworkStatus"
#define CACHEPATH   @"/Library/Caches/"
//@TODO:缓存
#define kUseCachePolicy  ASIUseDefaultCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy

@interface JLTools : NSObject

// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//利用正则表达式验证
+ (BOOL)isValidateEmail:(NSString *)email;
///获取网页地址
+ (NSURLRequest*)getPagePath:(NSString*)pageName;
/**
 *在手机上创建目录
 *@param dir  目录或文件名称
 **/
+ (NSString *)dataPath:(NSString *)dir isDir:(BOOL)isDirectory;
/**
 *判断指定的文件是否在手机上存在
 *@param filepath 文件的完整路径
 **/
+ (BOOL)isExistsFile:(NSString *)filepath;
/**
 *判断指定的文件是否在手机上存在
 *@param filename 文件的完整路径
 **/
+ (BOOL)existsFile:(NSString *)filename;
//下载缓存路径
+ (NSString  *)dowLoadCachesURL:(NSString*)cachesPath;
/**
 *MD5加密
 *@param str 需要加密的内容
 **/
+ (NSString *)md5:(NSString *)str;
/***
 *删除指定的文件
 *@param allPath 文件的全路径(包含要删除文件的名称)
 ***/
+ (void)deleteFileByPath:(NSString *)allPath;
/***
 *删除指定目录下指定扩展名的所有文件
 *@param dirctory 目录路径
 *@param suffix   后缀名
 ***/
+ (void)deleteFileByDirctory:(NSString *)dirctory extension:(NSString *)suffix;
/**
 * 跑马灯效果
 **/
+ (void)executePaoMaDengAnim:(UILabel *)labPaoMaDeng;

+ (NSDictionary*)setTitleTextAttributes:(CGFloat)red fGreen:(CGFloat)green fBlue:(CGFloat)blue fAlpha:(CGFloat)alpha;
/*
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 */
+ (NSData *)DESEncrypt:(NSString *)data WithKey:(NSString *)key;
/*
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 */
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;
/**
 *  引用第三方字体
 *
 *  @param path 字体路径
 *
 *  @return 返回字体类型
 */
+ (NSString*)customFontWithPath:(NSString*)path;
/**
 *  统一字体
 *
 *  @param fontFamily <#fontFamily description#>
 *  @param view       <#view description#>
 *  @param isSubViews <#isSubViews description#>
 */
+ (void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews;
#pragma mark-
#pragma mark other
//判断图片是否是jpg
+ (int)isJPEGValid:(NSData *)jpeg;
//判断图片是否是png
+ (int)isPNGValid:(NSData *)png;
//判断图片是否完整
+ (BOOL)isImageValid:(NSData *)imageData;
//获取处理后的图片url
+ (NSURL *)getTrueImgUrlFromUrl:(NSString *)url;
//获取缩略图url
+ (NSURL *)getSmallImageFromImgStr:(NSString *)imgStr;
//写本地设置
+ (void)writeLocalPlist:(NSString *)key value:(id)value;
//读本地设置
+ (id)readLocalPlist:(NSString *)key;
//创建barItem
+ (UIBarButtonItem*)buildBarButtonItem:(NSString*)title target:(id)target_ action:(SEL)action_;
//根据图片创建barItem
+ (UIBarButtonItem*)buildBarButtonItemByImg:(UIImage*)image_ target:(id)target_ action:(SEL)action_ LOrR:(BOOL)isLeftItem_;
//创建返回按钮
+ (UIBarButtonItem*)buildBackButton:(id)target_ action:(SEL)action;
//根据图片的不同创建返回按钮
+ (UIBarButtonItem*)buildBackButtonByImage:(id)target_ action:(SEL)action image:(UIImage*)image_;
//加圆角
+ (void)viewFillet:(UIView *)view and:(CGFloat)cornerRadius;
//边框
+ (void)viewBorder:(UIView *)view andBWidth:(float)bdW andBColor:(UIColor *)bColor;
/**
 图片模糊
 
 @param image 图片
 @param blur       模糊度
 */
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

/**
 通过tableViewCell上面的View 找到该view所在的indexPath
 
 @param view 被查找的视图
 @param tableView 表视图
 @return IndexPath
 */
+(NSIndexPath*)indexsPathFromView:(UIView *)view byTableView:(UITableView *)tableView;

/**
 通过CollectionViewCell上面的View 找到该view所在的indexPath

 @param view 被查找的视图
 @param collectionView 集合视图
 @return IndexPath
 */
+(NSIndexPath*)indexsPathFromView:(UIView *)view byCollectionView:(UICollectionView *)collectionView;

@end
