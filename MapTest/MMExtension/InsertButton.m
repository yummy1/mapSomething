//
//  InsertButton.m
//  智享生活
//
//  Created by LCHK on 17/5/25.
//  Copyright © 2017年 SmartYou. All rights reserved.
//

#import "InsertButton.h"

@implementation InsertButton

- (CGSize)intrinsicContentSize
{
    //按钮加边距
    CGSize originalSize = [super intrinsicContentSize];
    
    CGSize size = CGSizeMake(originalSize.width+20, originalSize.height);
    
    return size;
}

@end
