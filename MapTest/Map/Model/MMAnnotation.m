//
//  MMAnnotation.m
//  SwellPro
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 MM. All rights reserved.
//

#import "MMAnnotation.h"

@implementation MMAnnotation
- (instancetype)init
{
    self = [super init];
    if (self) {
        _iconType = MAP_iconTypeCommonBlue;
        _index = 1;
        _title = @"";
        _parameter = [[MMFlyControlPointParameter alloc] init];
        _isSelected = NO;
    }
    return self;
}
- (void)setIndex:(NSInteger)index
{
    _index = index;
    _name = [NSString stringWithFormat:@"%ld",index];
}
@end
