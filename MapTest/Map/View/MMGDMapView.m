//
//  MMGDMapView.m
//  SwellPro
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 MM. All rights reserved.
//

#import "MMGDMapView.h"
#import "MMDistanceLimitAnnotationView.h"
#import "MMSingleTapAnnotationView.h"
#import "MMCustomAnnotationView.h"
#import "MMGDPolyLine.h"
#import "MMGDPolygon.h"
#import "MMMapEditAnnotationsPopupView.h"
#import "AppDelegate.h"

@interface MMGDMapView()<MAMapViewDelegate,MMSingleTapAnnotationViewDelegate,MMMapEditAnnotationsPopupViewDelegate>
@property (strong, nonatomic)MAMapView *mapView;
/** 编辑点的弹出框 */
//@property (nonatomic,strong) MMMapEditAnnotationsPopupView *editAnnotationsView;
@end
@implementation MMGDMapView
+ (instancetype)mapView{
    return [[self alloc] init];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (void)commonInit
{
    ///////////////////////高德地图
    
    [AMapServices sharedServices].enableHTTPS = YES;
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.bounds];
    _mapView.delegate=self;
    _mapView.mapType = MAMapTypeSatellite;
    [self addSubview:_mapView];
    
    //地图跟着位置移动
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    //设置成NO表示关闭指南针；YES表示显示指南针
    _mapView.showsCompass= NO;
    //缩放等级
    [_mapView setZoomLevel:17 animated:YES];
}
//- (MMMapEditAnnotationsPopupView *)editAnnotationsView
//{
//    if (!_editAnnotationsView) {
//        _editAnnotationsView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MMMapEditAnnotationsPopupView class]) owner:self options:nil][0];
//        _editAnnotationsView.frame = CGRectMake(ViewWidth*0.15, 30, ViewWidth*0.7, 326);
//        _editAnnotationsView.delegate = self;
//    }
//    return _editAnnotationsView;
//}

- (void)setMapFunction:(MAP_function)mapFunction
{
    _mapFunction = mapFunction;
    switch (mapFunction) {
        case MAP_functionMyLocation:
        {
            self.mapView.userTrackingMode =MAUserTrackingModeFollow;//更新
        }
            break;
        case MAP_functionCompass:
        {
            self.mapView.userTrackingMode =MAUserTrackingModeFollow;
            self.mapView.rotationDegree=0.0;;
            self.mapView.cameraDegree=0.0;
        }
            break;
        case MAP_functionLayer:
        {
            if (_mapView.mapType == MAMapTypeStandard) {
                _mapView.mapType = MAMapTypeSatellite;///< 卫星地图
            }else{
                _mapView.mapType = MAMapTypeStandard;///< 普通地图
            }
        }
            break;
        case MAP_functionMapSwitch:
        {
            
        }
            break;
        case MAP_functionFlyLocation:
        {
            
        }
            break;
        default:
            break;
    }
}
- (MMAnnotation *)userAnnotation
{
    MMAnnotation *annotation = [[MMAnnotation alloc] init];
    annotation.coordinate = _mapView.userLocation.coordinate;
    _userAnnotation = annotation;
    return _userAnnotation;
}
- (void)addAnnotation:(MMAnnotation *)annotation
{
    [_mapView addAnnotation:annotation];
}
- (void)addAnnotations:(NSArray<MMAnnotation *> *)annotations
{
    [_mapView addAnnotations:annotations];
}
-(void)removeAnnotation:(MMAnnotation *)annotation
{
    [_mapView removeAnnotation:annotation];
}

-(void)removeAnnotations:(NSArray <MMAnnotation *>*)annotations
{
    [_mapView removeAnnotations:annotations];
}

- (void)addPolyLines:(NSArray <MMAnnotation *>*)annotations lineColor:(MAPLineColor)lineColor
{
    // 设置起始点坐标
    CLLocationCoordinate2D commonPolylineCoords[annotations.count];
    for (int i=0; i<annotations.count; i++) {
        MMAnnotation *pointAnnotation= annotations[i];
        CLLocationCoordinate2D Coordinate = pointAnnotation.coordinate;
        commonPolylineCoords[i] = Coordinate;
    }
    //构造折线对象
    MMGDPolyLine *Polyline = [MMGDPolyLine polylineWithCoordinates:commonPolylineCoords count:annotations.count];
    Polyline.lineColor = lineColor;
    [_mapView addOverlay: Polyline];
}
- (void)removePolyLines
{
    [self.mapView removeOverlays:_mapView.overlays];
}
- (void)addPolygon:(NSArray <MMAnnotation *>*)annotations lineType:(MAPLineType)lineType
{
    CLLocationCoordinate2D rectPoints[annotations.count];
    for (int i=0; i<annotations.count; i++) {
        MMAnnotation *pointAnnotation= annotations[i];
        CLLocationCoordinate2D Coordinate = pointAnnotation.coordinate;
        rectPoints[i] = Coordinate;
        
    }
    MMGDPolygon *rectangle = [MMGDPolygon polygonWithCoordinates:rectPoints count:annotations.count];
    rectangle.lineType = lineType;
    [self.mapView addOverlay:rectangle];
}

-(void)clear
{
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    
}
#pragma mark - Map Delegate
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{
    if ([_delegate respondsToSelector:@selector(GDMapView:didSingleTappedAtCoordinate:)]) {
        [_delegate GDMapView:self didSingleTappedAtCoordinate:coordinate];
    }
    
}
//根据anntation生成对应的View
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"location_phone"];
        return annotationView;
    }
    if ([annotation isKindOfClass:[MMAnnotation class]])
    {
        MMAnnotation *point = (MMAnnotation *)annotation;
        if ([[MMMapManager manager] isOverFlightAtFlyCoordinate:annotation.coordinate userCoordinate:_mapView.userLocation.coordinate]) {
            static NSString *reusedID = @"DistanceLimitAnnotationView_reusedID";
            MMDistanceLimitAnnotationView *annotationView = (MMDistanceLimitAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reusedID];
            if (!annotationView) {
                annotationView = [[MMDistanceLimitAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reusedID];
                annotationView.canShowCallout = NO;//设置此属性为NO，防止点击的时候高德自带的气泡弹出
            }
            annotationView.centerOffset = CGPointMake(45, -38);
            //给气泡赋值
            return annotationView;
        }
        switch ([MMMapManager manager].mapFunction) {
            case MAP_pointTypePointingFlight:
            {
                //指点飞行
//                static NSString *reusedID = @"DDPointAnnotation_reusedID";
//                MMSingleTapAnnotationView *annotationView = (MMSingleTapAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reusedID];
//                if (!annotationView) {
//                    annotationView = [[MMSingleTapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reusedID];
//                    annotationView.canShowCallout = NO;//设置此属性为NO，防止点击的时候高德自带的气泡弹出
//                    annotationView.delegate = self;
//                }
//                annotationView.centerOffset = CGPointMake(0, 0.5*annotationView.image.size.height);
//                //给气泡赋值
//                return annotationView;
                static NSString *customReuseIndetifier = @"customReuseIndetifier";
                MMCustomAnnotationView *annotationView = (MMCustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
                if (annotationView == nil)
                {
                    annotationView = [[MMCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
                    annotationView.canShowCallout = NO;
                    annotationView.draggable = YES;
                }
//                annotationView.name= point.name?point.name:[NSString stringWithFormat:@"%ld",(long)point.index];
                annotationView.portrait = [UIImage imageNamed:@"location_blue"];
                annotationView.centerOffset = CGPointMake(0, -0.5*annotationView.portrait.size.height);
                return annotationView;
            }
                break;
            case MAP_pointTypeRoutePlanning:
            {
                //航线规划
                static NSString *customReuseIndetifier = @"customReuseIndetifier";
                MMCustomAnnotationView *annotationView = (MMCustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
                if (annotationView == nil)
                {
                    annotationView = [[MMCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
                    annotationView.canShowCallout = NO;
                    annotationView.draggable = YES;
                }
                annotationView.name= point.name?point.name:[NSString stringWithFormat:@"%ld",(long)point.index];
                if (point.iconType == MAP_iconTypeCommonRed) {
                    annotationView.portrait = [UIImage imageNamed:@"location_red"];
                }else{
                    annotationView.portrait = [UIImage imageNamed:@"location_blue"];
                }
                annotationView.centerOffset = CGPointMake(0, -0.5*annotationView.portrait.size.height);
                return annotationView;
            }
                break;
            case MAP_pointTypeRegionalRoute:
            {
                if (point.iconType == MAP_iconTypeCommonRed || point.iconType == MAP_iconTypeCommonBlue) {
                    static NSString *customReuseIndetifier = @"customReuseIndetifier";
                    MMCustomAnnotationView *annotationView = (MMCustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
                    if (annotationView == nil)
                    {
                        annotationView = [[MMCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
                        annotationView.canShowCallout = NO;
                        annotationView.draggable = YES;
                    }
                    annotationView.name=[NSString stringWithFormat:@"%ld",(long)point.index];
                    if (point.iconType == MAP_iconTypeCommonRed) {
                        annotationView.portrait = [UIImage imageNamed:@"location_red"];
                    }else{
                        annotationView.portrait = [UIImage imageNamed:@"location_blue"];
                    }
                    annotationView.centerOffset = CGPointMake(0, -0.5*annotationView.portrait.size.height);
                    return annotationView;
                }else{
                    static NSString *customReuseIndetifier = @"customReuseIndetifier1";
                    MMCustomAnnotationView *annotationView = (MMCustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
                    if (annotationView == nil)
                    {
                        annotationView = [[MMCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
                        annotationView.canShowCallout = NO;
                        annotationView.draggable = YES;
                    }
                    annotationView.name= point.name;
                    if (point.iconType == MAP_iconTypeRoundedRedNumbers || point.iconType == MAP_iconTypeRoundedRedAlphabet) {
                        //红色
                        annotationView.portrait = [UIImage imageNamed:@"map_18"];
                    }else{
                        if (point.iconType == MAP_iconTypeRoundedBlueNumbers) {
                            //数字、蓝色
                            annotationView.portrait = [UIImage imageNamed:@"map_19"];
                        }else{
                            //字母、灰色
                            annotationView.portrait = [UIImage imageNamed:@"map_20"];
                        }
                    }
                    return annotationView;
                }
            }
                break;
            default:
                break;
        }
    }
    return nil;
}
//位置或者设备方向更新后
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    // 让定位箭头随着方向旋转
//    if (!updatingLocation && self.userLocationAnnotationView != nil)
//    {
//        [UIView animateWithDuration:0.1 animations:^{
//
//            double degree = userLocation.heading.trueHeading - self.mapView.rotationDegree;
//            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f);
//        }];
//    }
}
//划线
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MMGDPolyLine class]])//多点航线
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        MMGDPolyLine *lineModel = (MMGDPolyLine *)overlay;
        if (lineModel.lineColor == MAPLineBlueColor) {
            //蓝线
            polylineRenderer.strokeColor = ThemeBlueColor;
            polylineRenderer.lineWidth   = 3.f;
        }else{
            //黄线
            polylineRenderer.strokeColor = ThemeYellowColor;
            polylineRenderer.lineWidth   = 3.f;
        }
        return polylineRenderer;
    }
    
    if ([overlay isKindOfClass:[MMGDPolygon class]])//区域航线
    {
        MAPolygonRenderer *polygonRenderer = [[MAPolygonRenderer alloc] initWithPolygon:overlay];
        polygonRenderer.lineWidth   = 3.f;
        polygonRenderer.strokeColor = ThemeBlueColor;
        polygonRenderer.fillColor   = ThemeBlueColorWith(0.25);
        MMGDPolygon *quyuModel = (MMGDPolygon *)overlay;
        if (quyuModel.lineType == MAPLineTypeSolid) {
            //实线
            polygonRenderer.lineDashType=kMALineDashTypeNone;
        }else{
            //虚线
            polygonRenderer.lineDashType=kMALineDashTypeSquare;
        }
        return polygonRenderer;
    }
    return nil;
}
//#pragma mark - DDCustomAnnotationViewDelegate
//- (void)MMSingleTapAnnotationViewSingleTapEdit:(MMSingleTapAnnotationView *)annotationView
//{
//    [[MMMapManager manager] addPopopView:self.editAnnotationsView];
//    self.editAnnotationsView.model = [MMMapManager manager].annotations[0];
//    self.editAnnotationsView.tittleText = Localized(@"EditSingleFlight");
//
//}
//- (void)MMSingleTapAnnotationViewSingleTapGo:(MMSingleTapAnnotationView *)annotationView
//{
//
//    if ([_delegate respondsToSelector:@selector(GDMapViewSingleClickGO:)]) {
//        [_delegate GDMapViewSingleClickGO:self];
//    }
//}
#pragma mark - MMMapEditAnnotationsPopupViewDelegate
- (void)editEndOnMMMapEditAnnotationsPopupView:(MMMapEditAnnotationsPopupView *)view editModel:(MMAnnotation *)model
{
    //自动更新model
    [[MMMapManager manager].annotations removeAllObjects];
    [[MMMapManager manager].annotations addObject:model];
    //重绘
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView addAnnotations:@[model]];
    //对应的View,赋值
    MMSingleTapAnnotationView *annView = (MMSingleTapAnnotationView *)[self.mapView viewForAnnotation:model];
    annView.calloutView.model = model;
    [self addPolyLines:@[self.userAnnotation,model] lineColor:MAPLineBlueColor];
    //去除遮罩
    [[MMMapManager manager] clearShadeView];
}
- (void)cancelOnMMMapEditAnnotationsPopupView:(MMMapEditAnnotationsPopupView *)view
{
    [[MMMapManager manager] clearShadeView];
}

@end
