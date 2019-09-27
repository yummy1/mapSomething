//
//  MMMapView.h
//  SwellPro
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 MM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMMapView;

@protocol MMMapViewDelegate <NSObject>

@optional
/**
 预览模式下点击地图视图回调
 
 @param mapView mapView
 */
-(void)MMMapViewPreviewClick:(MMMapView *)mapView;
/**
 地图以返回坐标为中心移动
 
 @param mapView mapView
 @param sender 点击的location按钮
 @return 返回需要移动到的位置
 */
//-(CLLocationCoordinate2D)MMMapView:(MMMapView *)mapView locationClick:(UIButton *)sender;

@end
@interface MMMapView : UIView

@property(nonatomic, weak) id<MMMapViewDelegate> delegate;
//地图中心点坐标，设置该值地图会自动以该位置坐标为中间点在地图上显示
@property (nonatomic, assign) CLLocationCoordinate2D centerCoordinate;
///缩放级别, [3, 20]
@property (nonatomic, assign) double zoomLevel;

/**
    初始化地图
 */
+ (instancetype)mapView;


/**
    地图缩小，隐藏边栏和顶栏
 */
- (void)mapChangeSmall:(BOOL)isSmall;



///**
// 添加一个点
//
// @param annotation 点信息
// */
//- (void)addAnnotation:(MMAnnotation *)annotation;
//
//
///**
// 移除一个点
//
// @param annotation 点信息
// */
//-(void)removeAnnotation:(MMAnnotation *)annotation;
//
///**
// 移除多个点
//
// @param annotations 点信息数组
// */
//-(void)removeAnnotations:(NSArray <MMAnnotation *>*)annotations;
//
///**
// 添加航线
//
// @param annotation 点信息
// */
//- (void)addPolyLines:(NSArray <MMAnnotation *>*)annotations lineColor:(MAPLineColor)lineColor;
//
///**
// 绘制区域
//
// @param annotation 点信息
// */
//- (void)addPolygon:(NSArray <MMAnnotation *>*)annotations lineType:(MAPLineType)lineType;
///**
// 清除地图上所有自定义点线等信息
// */
//-(void)clear;
@end


