//
//  NSArray+MMExtension.h
//  xiuyue
//
//  Created by 毛毛 on 2016/12/17.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MMAnnotation;
@interface NSArray (MMExtension)

/*   return  plist文件中的数组[NSString]
 *   FileName:plist文件名字
 *   dic：存储的路线(2:航线规划，3区域航线)
 */
+(BOOL)saveHangxianWith:(NSDictionary *)dic;
+(NSArray *)getHangxian;
/** 打印汉字 */
- (NSString *)descriptionWithLocale:(id)locale;
@end
