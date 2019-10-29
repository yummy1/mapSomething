//
//  MMFlyControlPointParameter.m
//  SwellPro
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 MM. All rights reserved.
//

#import "MMFlyControlPointParameter.h"

@implementation MMFlyControlPointParameter
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.FK_height = @"20";
        self.FK_speed = @"5";
        self.FK_standingTime = @"0";
        self.FK_headOrientation = @"0";//°
        self.FK_circle = @"";
        self.FK_hoveringRadius = @"10";
        self.FK_circleNumber = @"0";
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone
{
    MMFlyControlPointParameter *parameter = [[self class] allocWithZone:zone];
    parameter.FK_height = [_FK_height copy];
    parameter.FK_speed = [_FK_speed copy];
    parameter.FK_standingTime = [_FK_standingTime copy];
    parameter.FK_headOrientation = [_FK_headOrientation copy];
    parameter.FK_circle = [_FK_circle copy];
    parameter.FK_hoveringRadius = [_FK_hoveringRadius copy];
    parameter.FK_circleNumber = [_FK_circleNumber copy];
    return parameter;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
    MMFlyControlPointParameter *parameter = [[self class] allocWithZone:zone];
    parameter.FK_height = [_FK_height copy];
    parameter.FK_speed = [_FK_speed copy];
    parameter.FK_standingTime = [_FK_standingTime copy];
    parameter.FK_headOrientation = [_FK_headOrientation copy];
    parameter.FK_circle = [_FK_circle copy];
    parameter.FK_hoveringRadius = [_FK_hoveringRadius copy];
    parameter.FK_circleNumber = [_FK_circleNumber copy];
    return parameter;
}
@end
