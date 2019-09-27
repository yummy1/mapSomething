//
//  NSString+MMEncrypt.h
//  MMEncrypt
//

#import <Foundation/Foundation.h>

@interface NSString (MMEncrypt)

/**
 *  32位MD5加密
 *
 *  @return 32位MD5加密结果
 */
- (NSString *)md5;

/**
 *  SHA1加密
 *
 *  @return SHA1加密结果
 */
- (NSString *)sha1;

/**
 *  核心加密算法
 *
 *  @return 核心加密算法
 */
- (NSString *)encrypt;

/**
 *  返回sha256编码后的字符串
 */
@property (nonatomic, readonly) NSString *hd_sha256String;

/**
 *  返回sha512编码后的字符串
 */
@property (nonatomic, readonly) NSString *hd_sha512String;

/**
 *  返回Base64编码后的字符串
 */
@property (nonatomic, readonly) NSString *hd_base64Encode;

/**
 *  返回Base64解码后的字符串
 */
@property (nonatomic, readonly) NSString *hd_base64Decode;

/**
 *  图片转字符串
 */
-(NSString *)UIImageToBase64Str:(UIImage *) image;

@end
