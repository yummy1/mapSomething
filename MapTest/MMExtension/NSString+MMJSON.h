//
//  NSString+MMJSON.h
//  xiuyue
//
//  Created by 毛毛 on 2016/12/7.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MMJSON)
/**
 * string to dictionary
 */
+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;
/**
 * string to array
 */
+(NSArray *)parseJSONStringToArray:(NSString *)JSONString;

//字典转为Json字符串
+(NSString *)dictionaryToJson:(NSDictionary *)dic;

@end
