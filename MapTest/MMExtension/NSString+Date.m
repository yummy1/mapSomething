//
//  NSString+Date.m
//  happyDot
//
//  Created by LCHK on 17/5/23.
//
//

#import "NSString+Date.h"

@implementation NSString (Date)
/** 毫秒字符串 */
+ (NSString *)stringWithDateStr:(NSString *)dateStr format:(NSString *)format
{
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:[dateStr doubleValue]/1000.0];
    return [NSString stringWithDate:d format:format];
}
/** 时间 */
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

@end
