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
@end
