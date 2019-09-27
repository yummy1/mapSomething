//
//  AppDelegate+MMMap.m
//  SwellPro
//
//  Created by solumon on 2019/7/3.
//  Copyright © 2019 MM. All rights reserved.
//

#import "AppDelegate+MMMap.h"

#import <AMapFoundationKit/AMapFoundationKit.h>
#import <GoogleMaps/GoogleMaps.h>

@implementation AppDelegate (MMMap)

- (void)init_map_config{
    //高德地图Key
    [AMapServices sharedServices].apiKey =@"fb3bc67b785f1349b0c6ec4931d7983e";
    
    //GoogleMap
    [GMSServices provideAPIKey:@"AIzaSyAGoe_sTAxocI-JkTAhFLtTpp2BlwvLwgo"];
    
}


@end
