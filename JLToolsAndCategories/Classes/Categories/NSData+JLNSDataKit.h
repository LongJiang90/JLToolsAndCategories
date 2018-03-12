//
//  NSData+JLNSDataKit.h
//  JLToolsAndCategories
//
//  Created by Long on 16/4/14.
//  Copyright © 2016年 Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JLNSDataKit)

#pragma mark - 加密相关（Hash）
/**
 *  以下转换使用了<CommonCrypto/CommonCrypto.h>库中的原生方法 需要引用libz.tbd
 **/
- (NSString *)jl_md2String;
- (NSData *)jl_md2Data;
- (NSString *)jl_md4String;
- (NSData *)jl_md4Data;
- (NSString *)jl_md5String;
- (NSData *)jl_md5Data;
- (NSString *)jl_sha1String;
- (NSData *)jl_sha1Data;
- (NSString *)jl_sha224String;
- (NSData *)jl_sha224Data;
- (NSString *)jl_sha256String;
- (NSData *)jl_sha256Data;
- (NSString *)jl_sha384String;
- (NSData *)jl_sha384Data;
- (NSString *)jl_sha512String;
- (NSData *)jl_sha512Data;
- (NSString *)jl_hmacMD5StringWithKey:(NSString *)key;
- (NSData *)jl_hmacMD5DataWithKey:(NSData *)key;
- (NSString *)jl_hmacSHA1StringWithKey:(NSString *)key;
- (NSData *)jl_hmacSHA1DataWithKey:(NSData *)key;
- (NSString *)jl_hmacSHA224StringWithKey:(NSString *)key;
- (NSData *)jl_hmacSHA224DataWithKey:(NSData *)key;
- (NSString *)jl_hmacSHA256StringWithKey:(NSString *)key;
- (NSData *)jl_hmacSHA256DataWithKey:(NSData *)key;
- (NSString *)jl_hmacSHA384StringWithKey:(NSString *)key;
- (NSData *)jl_hmacSHA384DataWithKey:(NSData *)key;
- (NSString *)jl_hmacSHA512StringWithKey:(NSString *)key;
- (NSData *)jl_hmacSHA512DataWithKey:(NSData *)key;
- (NSString *)jl_crc32String;
- (uint32_t)jl_crc32;

#pragma mark - 加密与解密
/**
 *  @param key 为任何自定义的字符串秘钥
 *  @param iv  为向量IV
 **/
///利用AES128加密数据
- (NSData *)jl_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;
///利用AES128解密数据
- (NSData *)jl_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;
///利用3DES加密数据
- (NSData *)jl_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;
///利用3DES解密数据
- (NSData *)jl_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;
///利用AES256加密数据
- (NSData *)jl_decryptedWithAes256EncryptWithKey:(NSData *)key iv:(NSData *)iv;
///利用AES256加密数据
- (NSData *)jl_decryptedWithAes256DecryptWithkey:(NSData *)key iv:(NSData *)iv;

#pragma mark - 转码相关
///NSData 转成 UTF8字符串
- (NSString *)jl_utf8String;
///NSData 转成 十六进制字符串
- (NSString *)jl_hexString;
///十六进制字符串 转成 NSData
+ (NSData *)jl_dataWithHexString:(NSString *)hexString;
///NSData 转成 BASE64字符串
- (NSString *)jl_base64EncodedString;
///BASE64字符串 转成 NSData
+ (NSData *)jl_dataWithBase64EncodedString:(NSString *)base64EncodedString;
///解析JSON DATA
- (id)jl_jsonValueDecoded;

#pragma mark - 压缩和解压
///gzip压缩
- (NSData *)jl_gzipInflate;
///gzip解压
- (NSData *)jl_gzipDeflate;
///zlib压缩
- (NSData *)jl_zlibInflate;
///zlib解压
- (NSData *)jl_zlibDeflate;

#pragma mark - 通过文件资源获取NSData
///通过文件名获取NSData
+ (NSData *)jl_dataWithNamed:(NSString *)name;

#pragma mark - 将APNS NSData类型token 格式化成字符串
///获得token格式化字符串
- (NSString *)jl_APNSToken;

#pragma mark - 缓存
/**
 *  @param identifier 为缓存KEY
 */
///将data保存到磁盘里缓存起来
- (void)jl_saveDataCacheWithIdentifier:(NSString *)identifier;
///取出缓存data
+ (NSData *)jl_getDataCacheWithIdentifier:(NSString *)identifier;

@end
