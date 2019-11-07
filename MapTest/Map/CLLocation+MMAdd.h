//
//  CLLocation+MMAdd.h
//  NewUAV
//
//  Created by solumon on 2019/7/14.
//  Copyright © 2019 MM. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLLocation (MMAdd)


/**
 火星坐标 ---> 地球坐标

 @param coordinate 火星坐标
 @return 地球坐标
 */
+(CLLocationCoordinate2D)transformFromGCJToWGS:(CLLocationCoordinate2D)coordinate;
/**
 地球坐标 ---> 火星坐标

 @param coordinate 地球坐标
 @return 火星坐标
 */
+ (CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)coordinate;

@end

NS_ASSUME_NONNULL_END
