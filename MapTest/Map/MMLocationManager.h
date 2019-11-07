//
//  MMLocationManager.h
//  NewUAV
//
//  Created by solumon on 2019/7/14.
//  Copyright © 2019 MM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class MMLocationManager;

@protocol MMLocationManagerDelegate <NSObject>

@optional

-(void)MMLocationManager:(MMLocationManager *)manager didUpdateLocation:(CLLocation *)location;

-(void)MMLocationManager:(MMLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading;

@end

@interface MMLocationManager : NSObject

+(instancetype)manager;

@property(nonatomic, weak) id<MMLocationManagerDelegate> delegate;


/**
 是否允许定位
 系统有定位权限 且允许自己应用定位
 @return BOOL
 */
+ (BOOL)allowLocation;

/**
 系统是否有定位权限

 @return BOOL
 */
+ (BOOL)locationServicesEnabled;

/**
 获取应用定位权限

 @return 权限
 */
+ (CLAuthorizationStatus)authorizationStatus;
/**
 开始结束定位
 */
-(void)startUpdatingLocation;
- (void)stopUpdatingLocation;

/**
 开始结束获取设备的真北方向
 */
-(void)startUpdatingHeading;
-(void)stopUpdatingHeading;



@end
