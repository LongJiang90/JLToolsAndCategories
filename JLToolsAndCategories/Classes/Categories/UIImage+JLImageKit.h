//
//  UIImage+JLImageKit.h
//  JLToolsAndCategories
//
//  Created by Long on 16/4/13.
//  Copyright © 2016年 Long. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UIImageGrayLevelTypeHalfGray    = 0,
    UIImageGrayLevelTypeGrayLevel   = 1,
    UIImageGrayLevelTypeDarkBrown   = 2,
    UIImageGrayLevelTypeInverse     = 3
} UIImageGrayLevelType;

@interface UIImage (JLImageKit)
#pragma mark - 获取图片
///中间可伸缩图像
+(UIImage *)jl_middleStretchableImageWithKey:(NSString *)key;
///根据图片名称获取图片
+(UIImage*)jl_imageContentFileWithName:(NSString*)imageName ofType:(NSString*)type;

#pragma mark - 裁剪、缩放图片
///缩放图片
+(UIImage *)jl_imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
///剪切
+(UIImage*)jl_imageWithImage:(UIImage*)image cutToRect:(CGRect)newRect;
///等比缩放
+(UIImage*)jl_imageWithImage:(UIImage *)image ratioToSize:(CGSize)newSize;
///添加圆角
+(UIImage*)jl_imageWithImage:(UIImage*)image roundRect:(CGSize)size;
///按最短边 等比压缩
+(UIImage*)jl_imageWithImage:(UIImage *)image ratioCompressToSize:(CGSize)newSize;
///根据Data和缩放比例创建图片
+(UIImage *)jl_imageWithData2:(NSData *)data scale:(CGFloat)scale;

#pragma mark - 色值、灰度处理图片
/// 图片处理 0 半灰色  1 灰度   2 深棕色    3 反色
+(UIImage*)jl_imageWithImage:(UIImage*)image grayLevelType:(UIImageGrayLevelType)type;

///色值 变暗多少 0.0 - 1.0
+(UIImage*)jl_imageWithImage:(UIImage*)image darkValue:(float)darkValue;

@end
