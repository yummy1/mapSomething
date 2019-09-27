//
//  NSDictionary+MMExtension.m
//  SwellPro
//
//  Created by MM on 2018/6/25.
//  Copyright © 2018年 MM. All rights reserved.
//

#import "NSDictionary+MMExtension.h"

@implementation NSDictionary (MMExtension)
/** 打印汉字 */
- (NSString *)descriptionWithLocale:(id)locale
{
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
        id value= self[key];
        [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    [str appendString:@"}"];
    
    return str;
}
@end
