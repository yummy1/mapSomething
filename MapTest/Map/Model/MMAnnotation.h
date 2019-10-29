//
//  MMAnnotation.h
//  SwellPro
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 MM. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "MMFlyControlPointParameter.h"

@interface MMAnnotation : MAPointAnnotation//<NSCopying, NSMutableCopying>
//点的样式显示：1普通红色，2普通蓝色，3圆形红色数字，4圆形蓝色数字，5圆形红色字母，6圆形灰色字母
@property (nonatomic,assign) MAP_iconType iconType;
//序号
@property (nonatomic,assign) NSInteger index;
//tittle
@property (nonatomic,strong) NSString *name;
///经纬度
//@property (nonatomic, assign) CLLocationCoordinate2D coor;

//经度
@property (nonatomic,strong) NSString *lat;
//纬度
@property (nonatomic,strong) NSString *log;

@property (nonatomic,strong) MMFlyControlPointParameter *parameter;

@property(nonatomic, assign) BOOL isSelected;
@end


