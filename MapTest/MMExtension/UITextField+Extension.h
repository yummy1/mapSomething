//
//  UITextField+Extension.h
//  xiuyue
//
//  Created by 毛毛 on 16/6/21.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

/**
 *  添加TextFiled的左边视图(图片)
 */
- (void)hd_addLeftViewWithImage:(NSString *)image;

/**
 *  获取选中光标位置
 *
 *  @return 返回NSRange
 */
- (NSRange)hd_selectedRange;

/**
 *  设置光标位置
 */
- (void)hd_setSelectedRange:(NSRange)range;

@end
