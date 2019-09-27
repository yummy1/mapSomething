//
//  NSString+Date.h
//  happyDot
//
//  Created by LCHK on 17/5/23.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Date)
/** 毫秒字符串 */
+ (NSString *)stringWithDateStr:(NSString *)dateStr format:(NSString *)format;
/** 时间 */
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;
@end
