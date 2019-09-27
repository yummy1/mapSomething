//
//  UITextField+Extension.m
//  xiuyue
//
//  Created by 毛毛 on 16/6/21.
//  Copyright © 2016年 锐拓. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)
/**
 *  添加TextFiled的左边视图(图片)
 */
-(void)hd_addLeftViewWithImage:(NSString *)image
{
    // 密码输入框左边图片
    UIImageView *lockIv = [[UIImageView alloc] init];
    
    // 设置尺寸
    CGRect imageBound = self.bounds;
    
    // 宽度高度一样
    imageBound.size.width = imageBound.size.height;
    lockIv.bounds = imageBound;
    
    // 设置图片
    lockIv.image = [UIImage imageNamed:image];
    
    // 设置图片居中显示
    lockIv.contentMode = UIViewContentModeCenter;
    
    // 添加TextFiled的左边视图
    self.leftView = lockIv;
    
    // 设置TextField左边的总是显示
    self.leftViewMode = UITextFieldViewModeAlways;
}
/**
 *  获取选中光标位置
 *
 *  @return 返回NSRange
 */
- (NSRange)hd_selectedRange
{
    UITextPosition *beginning = self.beginningOfDocument;
    
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}
/**
 *  设置光标位置
 */
- (void)hd_setSelectedRange:(NSRange)range
{
    UITextPosition *beginning = self.beginningOfDocument;
    
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}

@end
