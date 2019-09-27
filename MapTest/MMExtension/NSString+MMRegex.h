//
//  NSString+MMRegExp.h

#import <Foundation/Foundation.h>

@interface NSString (MMRegex)
/**
 *  正则匹配验证
 *
 *  @param pattern 正则表达式
 *
 *  @return 匹配结果
 */
- (BOOL)match:(NSString *)pattern;

/** 是否是数字（单个字） */
- (BOOL)isNumber;

/** 是否是数字字符串 */
- (BOOL)isNumberStr;

/** 是否是字母（单个字） */
- (BOOL)isLetter;

/** 是否是拼音字符串 */
- (BOOL)isLetterStr;

/** 是否是数字和字母的组合 */
- (BOOL)isNumberOrLetter;

/** 是否是QQ */
- (BOOL)isQQ;

/** 是否是手机号 */
- (BOOL)isMobileNumber;

/** 是否是邮箱 */
- (BOOL)isEmail;

/** 是否是身份证号 */
- (BOOL)isIDCard;

/** 是否是汉字(单个字) */
- (BOOL)isChinese;

/** 验证密码 密码长度6-16位，不能包含特殊字符*/
- (BOOL)isPassword;

/** 是否邮政编码 */
- (BOOL)isPostcodes;

/** 是否昵称符合中英文、数字、"_"或减号 */
- (BOOL)isNiCheng;

/** 判断全数字 */
- (BOOL) deptNumInputShouldNumber;

/** 判断全字母 */
- (BOOL) deptPassInputShouldAlpha;

/** 判断仅输入字母或数字 */
- (BOOL) deptIdInputShouldAlphaNum;
@end
