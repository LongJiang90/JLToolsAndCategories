//
//  JLTools.m
//  JLToolsAndCategories
//
//  Created by Long on 16/4/13.
//  Copyright © 2016年 Long. All rights reserved.
//

#import "JLTools.h"

@implementation JLTools

// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|4[0-9]|5[0-9]|7[0-9]|8[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[356])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//获取页面地址
+(NSURLRequest*)getPagePath:(NSString*)pageName {
    NSString* path = [[NSBundle mainBundle] pathForResource:pageName ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    return request;
}

//利用正则表达式验证
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//在手机上创建目录
+ (NSString *)dataPath:(NSString *)dir isDir:(BOOL)isDirectory
{
    NSString *path;
    BOOL result;
    if (isDirectory) {
        path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",CACHEPATH,dir]];
        result =  [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }else{
        path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:CACHEPATH];
        //创建一个plist文件
        NSFileManager* fm = [NSFileManager defaultManager];
        NSString *filename = [path stringByAppendingPathComponent:dir];
        result = [fm createFileAtPath:filename contents:nil attributes:nil];
    }
    
    return result?@"YES":@"NO";
}
/** 设置文本颜色
 red:    红
 gree：  绿
 blue：  蓝
 alpha： 透明度
 */
+(NSDictionary*)setTitleTextAttributes:(CGFloat)red fGreen:(CGFloat)green fBlue:(CGFloat)blue fAlpha:(CGFloat)alpha{
    NSDictionary *titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha],
                                         NSForegroundColorAttributeName,
                                         nil];
    return titleTextAttributes;
}

//返回 YES表示文件已经存在 NO表示不存在
+(BOOL)isExistsFile:(NSString *)filepath{
    NSString *dirPath = [JLTools dowLoadCachesURL:CACHEPATH];
    NSFileManager *filemanage = [NSFileManager defaultManager];
    NSString* allpath=[dirPath stringByAppendingPathComponent:filepath];
    return [filemanage fileExistsAtPath:allpath];
}
+(BOOL)existsFile:(NSString *)filename{
    NSFileManager *filemanage = [NSFileManager defaultManager];
    return [filemanage fileExistsAtPath:filename];
}
#pragma mark-
#pragma mark 缓存路径
//下载缓存路径
+(NSString  *)dowLoadCachesURL:(NSString*)cachesPath
{
    //设置缓存方式
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * diskCachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:cachesPath];
    //如果目录imageCache不存在，创建目录
    if (![[NSFileManager defaultManager] fileExistsAtPath:diskCachePath])
    {
        NSError *error=nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    return diskCachePath;
}

//对传入的字符数据进行MD5加密,并返回
+(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_LONG cc_long = @(strlen(cStr)).floatValue;
    CC_MD5( cStr, cc_long, result );
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/***
 *删除指定的文件
 *@param allPath 文件的全路径(包含要删除文件的名称)
 ***/
+(void)deleteFileByPath:(NSString *)allPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:allPath error:nil];
}
/***
 *删除指定目录下指定扩展名的所有文件
 *@param dirctory 目录路径
 *@param suffix   后缀名
 ***/
+(void)deleteFileByDirctory:(NSString *)dirctory extension:(NSString *)suffix{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *direnum = [manager enumeratorAtPath:dirctory];
    NSString *filename ;
    while (filename = [direnum nextObject]) {
        if ([[filename pathExtension] isEqualToString:suffix]) {
            [JLTools deleteFileByPath:[dirctory stringByAppendingString:filename]];
        }
    }
}

-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//判断图片是否是jpg
+ (int)isJPEGValid:(NSData *)jpeg
{
    if ([jpeg length] < 4) return 1;
    const unsigned char * bytes = (const unsigned char *)[jpeg bytes];
    if (bytes[0] != 0xFF || bytes[1] != 0xD8) return 2;
    if (bytes[[jpeg length] - 2] != 0xFF ||
        bytes[[jpeg length] - 1] != 0xD9) return 3;
    return 0;
}
//1.JPEG
//- 文件头标识 (2 bytes): $ff, $d8 (SOI) (JPEG 文件标识)
//- 文件结束标识 (2 bytes): $ff, $d9 (EOI)
//3.PNG
//- 文件头标识 (8 bytes)   89 50 4E 47 0D 0A 1A 0A
//判断图片是否是png
+ (int)isPNGValid:(NSData *)png
{
    if ([png length] < 8) return 1;
    const unsigned char * bytes = (const unsigned char *)[png bytes];
    if (bytes[0] != 0x89 || bytes[1] != 0x50 || bytes[2] != 0x4E || bytes[3] != 0x47 || bytes[4] != 0x0D || bytes[5] != 0x0A || bytes[6] != 0x1A || bytes[7] != 0x0A  ) return 2;
    return 0;
}
//判断图片是否完整
+ (BOOL)isImageValid:(NSData *)imageData
{
    int isValidNum =[self isJPEGValid:imageData];
    int  isValidPangNum =[self isPNGValid:imageData];
    BOOL isValid =NO;
    if (!isValidNum|| !isValidPangNum) {
        isValid =YES;
    }
    
    return isValid;
}
/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESEncrypt:(NSString *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength =[data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data cStringUsingEncoding:NSUTF8StringEncoding], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}
/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}
/**
 *  引用第三方字体
 *
 *  @param path 字体路径
 *
 *  @return 返回字体名称
 */
+(NSString*)customFontWithPath:(NSString*)path
{
    NSURL *fontUrl = [NSURL fileURLWithPath:path];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    CGFontRelease(fontRef);
    return fontName;
}
/**
 *  统一字体
 *
 *  @param fontFamily <#fontFamily description#>
 *  @param view       <#view description#>
 *  @param isSubViews <#isSubViews description#>
 */
+(void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews
{
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *lbl = (UILabel *)view;
        [lbl setFont:[UIFont fontWithName:fontFamily size:[[lbl font] pointSize]]];
    }
    if ([view isKindOfClass:[UITextView class]])
    {
        UITextView *lbl = (UITextView *)view;
        [lbl setFont:[UIFont fontWithName:fontFamily size:[[lbl font] pointSize]]];
    }
    if ([view isKindOfClass:[UITextField class]])
    {
        UITextField *lbl = (UITextField *)view;
        [lbl setFont:[UIFont fontWithName:fontFamily size:[[lbl font] pointSize]]];
    }
    if ([view isKindOfClass:[UIButton class]])
    {
        UIButton *lbl = (UIButton *)view;
        [lbl.titleLabel setFont:[UIFont fontWithName:fontFamily size:[[lbl.titleLabel font] pointSize]]];
    }
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self setFontFamily:fontFamily forView:sview andSubViews:YES];
        }
    }
}
/**
 * 跑马灯效果
 **/
+(void)executePaoMaDengAnim:(UILabel *)labPaoMaDeng{
    //    for (UIViewAnimation *animation in [labPaoMaDeng.layer animationKeys]) {
    //
    //    }
    
    CGFloat labelX = labPaoMaDeng.frame.origin.x;
    CGRect frame = labPaoMaDeng.frame;
    frame.origin.x = frame.size.width+labelX;
    labPaoMaDeng.frame = frame;
    
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:8.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    
    frame = labPaoMaDeng.frame;
    frame.origin.x = -frame.size.width+labelX;
    labPaoMaDeng.frame = frame;
    
    [UIView commitAnimations];
}

//获取当前用户id
+(NSInteger)getCurrentUid{
    //TODO:当用户登录后，需要更新当前用户ID
    int uid=[[self readLocalPlist:@"uid"] intValue];
    if(uid>0){
        return uid;
    }
    return -1;
}

//写本地设置
+(void)writeLocalPlist:(NSString *)key value:(id)value{
    //    //获取路径对象
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    //获取完整路径
    //    NSString *documentsDirectory = [paths objectAtIndex:0];
    //    NSString *filename = [documentsDirectory stringByAppendingPathComponent:@"localset.plist"];
    //
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(
                                                            NSDocumentDirectory,
                                                            NSUserDomainMask, YES) objectAtIndex: 0];
    NSString *filename=[[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@image",CACHEPATH]] stringByAppendingPathComponent:@"localset.plist"];
    
    NSMutableDictionary *data;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:filename]){
        data = [[[NSMutableDictionary alloc]initWithContentsOfFile:filename]mutableCopy];
    }else{
        data = [[NSMutableDictionary alloc ] init];
    }
    //设置属性值
    [data setObject:value forKey:key];
    //写入文件
    [data writeToFile:filename atomically:YES];
    
}
//读本地设置
+(id)readLocalPlist:(NSString *)key{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(
                                                            NSDocumentDirectory,
                                                            NSUserDomainMask, YES) objectAtIndex: 0];
    NSString *path=[[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@image",CACHEPATH]] stringByAppendingPathComponent:@"localset.plist"];
    //根据路径获取localset.plist的全部内容
    NSMutableDictionary *data= [[[NSMutableDictionary alloc]initWithContentsOfFile:path]mutableCopy];
    id returnObj=[data objectForKey:key];
    
    return returnObj;
}

+(NSString*)formatDistance:(CGFloat)distence{
    if (distence<1000) {
        return [NSString stringWithFormat:@"%0.0lfm",ceil(distence)];
    }
    if (distence<10000&&distence>1000) {
        CGFloat d=distence/1000.0;
        return [NSString stringWithFormat:@"%0.2lfkm",d];
    }else{
        return @"未知";
    }
    
}

+(float)getSystemVersion{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return version;
}

+(NSString *)getBundleVersion{
    NSString *bundleVersion=[NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    return bundleVersion;
}

//创建barItem
+(UIBarButtonItem*)buildBarButtonItem:(NSString*)title target:(id)target_ action:(SEL)action_{
    CGSize titlesize=[title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, titlesize.width+10, 28);
    //    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    [button setBackgroundImage:[[UIImage imageNamed:@"button_bg.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:@"button_bg.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0] forState:UIControlStateSelected];
    [button addTarget:target_ action:action_ forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    //    [button setTitleColor:RGBACOLOR(76, 159, 243, 1.0) forState:UIControlStateNormal];
    //    [button setTitleColor:RGBACOLOR(76, 159, 243, 1.0) forState:UIControlStateSelected];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    UIBarButtonItem *addBtnItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    return addBtnItem;
}
//根据图片创建barItem
+(UIBarButtonItem*)buildBarButtonItemByImg:(UIImage*)image_ target:(id)target_ action:(SEL)action_ LOrR:(BOOL)isLeftItem_{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 48, 48);
    if (isLeftItem_==YES) {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];//top, left, bottom, right
    }else if(isLeftItem_==NO) {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    }
    
    [button addTarget:target_ action:action_ forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image_ forState:UIControlStateNormal];
    [button setImage:image_ forState:UIControlStateSelected];
    
    UIBarButtonItem *addBtnItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    return addBtnItem;
}

//创建返回按钮
+(UIBarButtonItem*)buildBackButton:(id)target_ action:(SEL)action{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    //    button.backgroundColor = [UIColor blueColor];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    
    [button setImage:[UIImage imageNamed:@"login_licon"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"login_licon_hov"] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"login_licon_hov"] forState:UIControlStateHighlighted];
    [button addTarget:target_ action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton=[[UIBarButtonItem alloc] initWithCustomView:button];
    return backButton;
}
//创建返回按钮
+(UIBarButtonItem*)buildBackButtonByImage:(id)target_ action:(SEL)action image:(UIImage*)image_{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 31,44);
    //    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    [button setImage:image_ forState:UIControlStateNormal];
    [button setImage:image_ forState:UIControlStateSelected];
    [button addTarget:target_ action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton=[[UIBarButtonItem alloc] initWithCustomView:button];
    return backButton;
}

+(UIImage *)getImageFromImage:(UIImage *)bigImage{
    //定义myImageRect，截图的区域
    CGRect myImageRect = CGRectMake(10.0, 10.0, 320.0, 170.0);
    CGImageRef imageRef = bigImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size = CGSizeMake(320.0, 170.0);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}

#pragma mark-
#pragma mark 图片处理
//等比率缩放
+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize

{
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
//缩放图像
+(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//计算文本内容的宽度
+(CGSize)calculateFontHeight:(NSString*)nsString font:(UIFont*)txtFont labWidth:(CGFloat)contentWidth{
    
//    CGSize size = [nsString sizeWithFont:txtFont constrainedToSize:CGSizeMake(contentWidth, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];//iOS7及以下
    
    CGSize size = [nsString boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : txtFont} context:nil].size;
    
    return size;
}
//自定长宽
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(reSize);
    [image drawInRect:CGRectMake(0,0,reSize.width,reSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSURL *)getSmallImageFromImgStr:(NSString *)imgStr{
    NSRange pointRange= [imgStr rangeOfString:@"."];
    if (imgStr.length-pointRange.location>4) {
        pointRange=NSMakeRange(imgStr.length-4, 4);
    }
    NSString *endStr= [imgStr substringWithRange:NSMakeRange(pointRange.location,imgStr.length-pointRange.location)];
    NSURL *url=[JLTools getTrueImgUrlFromUrl:[NSString stringWithFormat:@"%@_72x72%@",imgStr,endStr]];
    return url;
}
+ (NSURL *)getTrueImgUrlFromUrl:(NSString *)url{
    
    if (![url isEqualToString:@""])
    {
        NSString *imgUrl = url;
        if (![imgUrl hasPrefix:@"http"]) {
            //            imgUrl = [NSString stringWithFormat:@"%@%@",INTERFACE_NETWORK_PHOTO,imgUrl];
        }
        NSURL *imageUrl = [NSURL URLWithString:imgUrl];
        return imageUrl;
    }
    else{
        return nil;
    }
}

//圆角
+ (void)viewFillet:(UIView *)view and:(CGFloat)cornerRadius {
    view .layer.cornerRadius =cornerRadius;
    view .layer.masksToBounds=YES;
    
}

+ (void)viewBorder:(UIView *)view andBWidth:(float)bdW andBColor:(UIColor *)bColor{
    view.layer.borderWidth = bdW;  // 给图层添加一个有色边框
    view.layer.borderColor = bColor.CGColor;
}

//图片模糊
//加模糊效果，image是图片，blur是模糊度
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    /*
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

/**
 *通过View 找到indexPath
 */
+(NSIndexPath*)indexsPathFromView:(UIView*)view byTableView:(UITableView*)tableView
{
    UIView *parentView = [view superview];
    while (![parentView isKindOfClass:[UITableViewCell class]] && parentView!=nil) {
        parentView = parentView.superview;
    }
    NSIndexPath *indexPath = [tableView indexPathForCell:(UITableViewCell*)parentView];
    return indexPath;
}

/**
 通过CollectionViewCell上面的View 找到该view所在的indexPath
 
 @param view 被查找的视图
 @param collectionView 集合视图
 @return IndexPath
 */
+(NSIndexPath*)indexsPathFromView:(UIView *)view byCollectionView:(UICollectionView *)collectionView {
    UIView *parentView = [view superview];
    while (![parentView isKindOfClass:[UICollectionViewCell class]] && parentView!=nil) {
        parentView = parentView.superview;
    }
    NSIndexPath *indexPath = [collectionView indexPathForCell:(UICollectionViewCell*)parentView];
    return indexPath;
}

@end
