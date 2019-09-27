//
//  NSString+Encrypt.m

#import "NSString+MMEncrypt.h"
#import <CommonCrypto/CommonDigest.h>
#include <zlib.h>




@implementation NSString (MMEncrypt)

static NSString *const salt = @"1431608414@qq.com";
/**
 *  32位MD5加密
 *
 *  @return 32位MD5加密结果
 */
- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

/**
 *  SHA1加密
 *
 *  @return SHA1加密结果
 */
- (NSString *)sha1{
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

/**
 *  核心加密算法
 *
 *  @return 核心加密算法
 */
- (NSString *)encrypt{
    NSString *encryptStr = self;
    
    // 加盐(串前盐后)、MD5加密
    encryptStr = [[NSString stringWithFormat:@"%@%@", encryptStr, salt] md5];
    //    NSLog(@"md5+yan:%@",encryptStr);
    // 字符串重组
    encryptStr = [encryptStr reCombination];
    // 加盐(盐前串后)、SHA1加密
    encryptStr = [[NSString stringWithFormat:@"%@%@", salt, encryptStr] sha1];
    // 字符串重组
    encryptStr = [encryptStr reCombination];
    
    
    return encryptStr;
}

/** 字符串重组 */
- (instancetype)reCombination{
    /** 将字符串分成四份的话，一份的长度 */
    NSInteger itemLength = self.length / 4;
    
    NSMutableArray *temp = [NSMutableArray  array];
    for (int i=0; i<4; i++) {
        NSRange range = NSMakeRange(i*itemLength, itemLength);
        NSString *item = [self substringWithRange:range];
        [temp addObject:item];
    }
    
    // 字符串重组，0123 -> 1032
    NSString *encryptStr = [NSString stringWithFormat:@"%@%@%@%@", temp[1], temp[0], temp[3], temp[2]];
    return encryptStr;
}

/**
 *  返回sha256编码后的字符串
 */
- (NSString *)hd_sha256String
{
    const char *str = self.UTF8String;
    int length = (int)strlen(str);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, length, bytes);
    
    return [self hd_stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

/**
 *  返回sha512编码后的字符串
 */
- (NSString *)hd_sha512String
{
    const char *str = self.UTF8String;
    int length = (int)strlen(str);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(str, length, bytes);
    
    return [self hd_stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)hd_stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    return [strM copy];
}

/**
 *  返回Base64编码后的字符串
 */
- (NSString *)hd_base64Encode
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

/**
 *  返回Base64解码后的字符串
 */
- (NSString *)hd_base64Decode
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/**
 *  图片转字符串
 */
-(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

@end
