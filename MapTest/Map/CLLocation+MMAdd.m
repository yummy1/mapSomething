//
//  CLLocation+MMAdd.m
//  NewUAV
//
//  Created by solumon on 2019/7/14.
//  Copyright © 2019 MM. All rights reserved.
//

#import "CLLocation+MMAdd.h"
#import "HZLocationConverter.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation CLLocation (MMAdd)

+(CLLocationCoordinate2D)transformFromGCJToWGS:(CLLocationCoordinate2D)coordinate{
    return [HZLocationConverter transformFromGCJToWGS:coordinate];
}

+ (CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)coordinate{
    return [HZLocationConverter transformFromWGSToGCJ:coordinate];
}



@end
