//
//  MMGoogleMapView.h
//  SwellPro
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 MM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMGoogleMapView;
@protocol MMGoogleMapViewDelegate <NSObject>
/**
 在地图上单击之后

 */
- (void)googleMapView:(MMGoogleMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate;

@end

@interface MMGoogleMapView : UIView

@property(nonatomic, weak) id<MMGoogleMapViewDelegate> delegate;
/** 1我的位置、2指南针、3图层、4地图切换 、5无人机位置*/
@property (nonatomic,assign) MAP_function mapFunction;

/** 我的位置 */
@property (nonatomic,strong) MMAnnotation *userAnnotation;

/**
 初始化地图
 */
+ (instancetype)mapView;


/**
 添加一个点
 
 @param annotation 点信息
 */
- (void)addAnnotation:(MMAnnotation *)annotation;

/**
 添加多个点
 
 @param annotations 点信息
 */
- (void)addAnnotations:(NSArray <MMAnnotation *> *)annotations;


/**
 添加航线
 
 @param annotations 点信息
 */
- (void)addPolyLines:(NSArray <MMAnnotation *>*)annotations lineColor:(MAPLineColor)lineColor lineType:(MAPLineType)lineType;

/**
 绘制区域
 
 @param annotations 点信息
 */
- (void)addPolygon:(NSArray <MMAnnotation *>*)annotations lineType:(MAPLineType)lineType;
/**
 清除地图上所有自定义点线等信息
 */
-(void)clear;
@end


