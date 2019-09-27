//
//  MMGDPolygon.m
//  SwellPro
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 MM. All rights reserved.
//

#import "MMGDPolygon.h"

@implementation MMGDPolygon
- (instancetype)init
{
    self = [super init];
    if (self) {
        _lineType = MAPLineTypeSolid;
    }
    return self;
}
@end
