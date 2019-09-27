//
//  MMFlyControlPointParameter.h
//  SwellPro
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 MM. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MMFlyControlPointParameter : NSObject
//飞控相关参数
@property (nonatomic,strong) NSString *FK_height;//高度
@property (nonatomic,strong) NSString *FK_speed;//速度
@property (nonatomic,strong) NSString *FK_standingTime;//停留时间
@property (nonatomic,strong) NSString *FK_headOrientation;//机头朝向
@property (nonatomic,strong) NSString *FK_circle;//绕圈
@property (nonatomic,strong) NSString *FK_hoveringRadius;//悬停半径
@property (nonatomic,strong) NSString *FK_circleNumber;//圈数
@end


