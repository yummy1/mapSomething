//
//  NSString+size.h
//  MLLabelCell
//
//  Created by 毛毛 on 16/9/7.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (size)


#pragma mark - 文本计算方法
/**
 *  快速计算出文本的真实尺寸
 *
 *  @param font    文字的字体
 *  @param maxSize 文本的最大尺寸
 *
 *  @return 快速计算出文本的真实尺寸
 */
- (CGSize)hd_sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

/**
 *  快速计算出文本的真实尺寸
 *
 *  @param text    需要计算尺寸的文本
 *  @param font    文字的字体
 *  @param maxSize 文本的最大尺寸
 *
 *  @return 快速计算出文本的真实尺寸
 */
+ (CGSize)hd_sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize;


@end
