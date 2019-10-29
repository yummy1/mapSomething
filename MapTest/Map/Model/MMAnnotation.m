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
        _name = @"";
        _parameter = [[MMFlyControlPointParameter alloc] init];
        _isSelected = NO;
    }
    return self;
}
//#pragma mark - NSCopying
//- (id)copyWithZone:(NSZone *)zone
//{
//    MMAnnotation *annotation = [[self class] allocWithZone:zone];
//    annotation.iconType = _iconType;
//    annotation.index = _index;
//    annotation.name = [_name copy];
//    annotation.isSelected = _isSelected;
//    annotation.coor = _coor;
//    annotation.parameter = [_parameter copy];
//    return annotation;
//}
//#pragma mark - NSMutableCopying
//- (id)mutableCopyWithZone:(NSZone *)zone
//{
//    MMAnnotation *annotation = [[self class] allocWithZone:zone];
//    annotation.iconType = _iconType;
//    annotation.index = _index;
//    annotation.name = [_name copy];
//    annotation.isSelected = _isSelected;
//    annotation.coor = _coor;
//    annotation.parameter = [_parameter copy];
//    return annotation;
//}

@end
