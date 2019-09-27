//
//  NSArray+MMExtension.m
//  xiuyue
//
//  Created by 毛毛 on 2016/12/17.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import "NSArray+MMExtension.h"
#import "MJExtension.h"

@implementation NSArray (MMExtension)

+(BOOL)saveHangxianWith:(NSDictionary *)dic
{
    NSString *filename=[NSString hd_filePathAtDocumentsWithFileName:@"hangxian.plist"];
    NSMutableArray *array=[[NSMutableArray alloc] initWithContentsOfFile:filename];
    //    若里面无历史数组，则添加空数组
    if (array == nil) {
        array = [[NSMutableArray alloc] init];
        [array writeToFile:filename atomically:YES];
    }
    [array addObject:dic];
    return [array writeToFile:filename atomically:YES];
}
+(NSArray *)getHangxian
{
    NSString *filename=[NSString hd_filePathAtDocumentsWithFileName:@"hangxian.plist"];
    NSMutableArray *array=[[NSMutableArray alloc] initWithContentsOfFile:filename];
    //    若里面无历史数组，则添加空数组
    if (array == nil) {
        array = [[NSMutableArray alloc] init];
        [array writeToFile:filename atomically:YES];
    }
    return array;
}
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        [str appendFormat:@"\t%@, \n", obj];
    }
    
    [str appendString:@")"];
    
    return str;
}
@end
