//
//  NSString+MMRegex.m
//  IT程序园
//

#import "NSString+MMRegex.h"

@implementation NSString (MMRegex)
/**
 *  正则匹配验证
 *
 *  @param pattern 正则表达式
 *
 *  @return 匹配结果
 */
- (BOOL)match:(NSString *)pattern{
    
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
    NSArray *res = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return res.count==1;
}
/**
 *  谓词
 *
 *  @param pattern 需要匹配的字符串
 *  BEGINSWITH：检查某个字符串是否以指定的字符串开头（如判断字符串是否以a开头：BEGINSWITH 'a'）
 *  ENDSWITH：检查某个字符串是否以指定的字符串结尾
 *  CONTAINS：检查某个字符串是否包含指定的字符串
 *  LIKE：检查某个字符串是否匹配指定的字符串模板"name LIKE '*ac*'"
 *  MATCHES：检查某个字符串是否匹配指定的正则表达式。
 *
 *  @return 匹配结果
 */
- (BOOL)matchStr:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:self] == YES)
    {
        return YES;
    }else{
        return NO;
    }

}
/** 是否是数字（单个字） */
- (BOOL)isNumber{
    return [self match:@"\\d"];
}
- (BOOL)isNumberStr
{
    return [self match:@"^[0-9]+$"];
}
/** 是否是字母（单个字） */
- (BOOL)isLetter{
    return [self match:@"[a-zA-Z]"];
}
/** 是否是拼音字符串 */
- (BOOL)isLetterStr
{
    return [self match:@"^[A-Za-z]*$"];
}
/** 是否是数字和字母的组合 */
- (BOOL)isNumberOrLetter{
    NSString *regex = @"^[A-Za-z0-9]+$";
    return [self match:regex];
}
/** 是否是QQ */
- (BOOL)isQQ{
    return [self match:@"^[1-9]\\d{4,10}$"];
}
/** 是否是手机号 */
- (BOOL)isMobileNumber{
    return [self match:@"^1[3|4|5|7|8][0-9]\\d{8}$"];
}
/** 是否是邮箱 */
- (BOOL)isEmail{
    return [self match:@"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"];
}
/** 是否是身份证号 */
- (BOOL)isIDCard{
//    return [self match:@"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$"];
    // 只支持18位身份证号码
    return [self match:@"^\\d{6}(18|19|20)\\d{2}(0[1-9]|1[12])(0[1-9]|[12]\\d|3[01])\\d{3}(\\d|[Xx])$"];
}
/** 是否是汉字(单个字) */
- (BOOL)isChinese{
    return [self match:@"[\\u4e00-\\u9fa5]"];
}
/** 验证密码 密码长度6-16位，不能包含特殊字符*/
- (BOOL)isPassword{
    return [self match:@"^[A-Za-z0-9\\@\\#\\,\\.\\<\\>\\?\\~\\!\\`\\!\\$\\%\\^\\*\\&\\+\\-\\_\\=]{6,16}$"];
}
/** 是否邮政编码 */
- (BOOL)isPostcodes
{
    return [self match:@"[1-9]\\d{5}(?!\\d)"];
}
/** 是否昵称符合中英文、数字、"_"或减号 */
- (BOOL)isNiCheng
{
    return [self match:@"^[0-9A-Za-z\\u4e00-\\u9fa5_\\-]+{4,12}$"];
}
/** 判断全数字 */
- (BOOL) deptNumInputShouldNumber
{
    return [self match:@"[0-9]*"];
}
/** 判断全字母 */
- (BOOL) deptPassInputShouldAlpha
{
    return [self match:@"[a-zA-Z]*"];
}
/** 判断仅输入字母或数字 */
- (BOOL) deptIdInputShouldAlphaNum
{
    return [self match:@"[a-zA-Z0-9]*"];
}

@end
