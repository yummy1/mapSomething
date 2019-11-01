//
//  MMGoogleMapView.m
//  SwellPro
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 MM. All rights reserved.
//

#import "MMGoogleMapView.h"

@interface MMGoogleMapView()<GMSMapViewDelegate>
@property (nonatomic,strong) GMSMapView *mapView;

@end
@implementation MMGoogleMapView
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
    self.backgroundColor = [UIColor redColor];
    /*
     地图初始化
     **/
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:39.952047
    longitude:116.408669
         zoom:17];
    _mapView = [GMSMapView mapWithFrame:self.bounds camera:camera];
    _mapView.delegate = self;
    _mapView.indoorEnabled = YES;//设置室内地图是否显示在哪里。默认值为YES
    _mapView.settings.rotateGestures = YES;//控制是否启用了旋转手势(默认)或禁用。如果启用后，用户可以使用一个双手指旋转手势来旋转相机。这不限制对相机轴承的编程式控制。
    _mapView.settings.tiltGestures = YES;//控制倾斜手势是否启用(默认)或禁用。如果启用,用户可以使用两指垂直向下或向上滑动来倾斜相机。这不限制相机的取景角的编程式控制。
    _mapView.settings.myLocationButton = NO;//启用或禁用我的位置按钮。这是一个可以看到的按钮当用户点击时，地图会显示当前用户的地图位置。
    _mapView.settings.compassButton = YES;//启用或禁用罗盘。指南针是地图上的一个图标在地图上显示北方的方向。
    _mapView.myLocationEnabled = YES;//控制是否启用了我的位置点和精度圆。默认为没有。

    [self addSubview:_mapView];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.mapView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (MMAnnotation *)userAnnotation
{
    MMAnnotation *annotation = [[MMAnnotation alloc] init];
    annotation.coordinate = _mapView.myLocation.coordinate;
    _userAnnotation = annotation;
    return _userAnnotation;
}

- (void)setMapFunction:(MAP_function)mapFunction
{
    _mapFunction = mapFunction;
    switch (mapFunction) {
        case MAP_functionMyLocation:
        {
            [_mapView animateToLocation:_mapView.myLocation.coordinate];
        }
            break;
        case MAP_functionCompass:
        {
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:_mapView.myLocation.coordinate zoom:_mapView.camera.zoom bearing:0 viewingAngle:0];
            [_mapView animateToCameraPosition:camera];
        }
            break;
        case MAP_functionLayer:
        {
            if (_mapView.mapType == kGMSTypeNormal) {
                _mapView.mapType = kGMSTypeSatellite;
            }else{
                _mapView.mapType = kGMSTypeNormal;
            }
        }
            break;
        default:
            break;
    }
}
- (void)addAnnotation:(MMAnnotation *)annotation
{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = annotation.coordinate;
    marker.appearAnimation = kGMSMarkerAnimationNone;
    if ([[MMMapManager manager] isOverFlightAtFlyCoordinate:annotation.coordinate userCoordinate:_mapView.myLocation.coordinate]) {
        if (![MMMapManager manager].isEnglish) {
            marker.icon = [UIImage imageNamed:@"distanceLimit"];
        }else{
            marker.icon = [UIImage imageNamed:@"distanceLimit_en"];
        }
        marker.groundAnchor = CGPointMake(0.275, 1);
        marker.infoWindowAnchor = CGPointMake(0.5, 1);
    }else{
        UIButton *icon = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 23, 32)];
        //普通的地图点d图标
        if (annotation.iconType == MAP_iconTypeCommonRed || annotation.iconType == MAP_iconTypeCommonBlue) {
            if (annotation.iconType == MAP_iconTypeCommonRed) {
                [icon setBackgroundImage:[UIImage imageNamed:@"location_red"] forState:UIControlStateNormal];
            }else{
                [icon setBackgroundImage:[UIImage imageNamed:@"location_blue"] forState:UIControlStateNormal];
            }
            [icon setTitle:annotation.name forState:UIControlStateNormal];
            [icon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [icon setTitleEdgeInsets:UIEdgeInsetsMake(-11, 0, 0, 0)];
            [icon.titleLabel setFont:[UIFont systemFontOfSize:10 weight:UIFontWeightThin]];
            marker.iconView = icon;
        }else{
            //圆形点图标
            icon.frame = CGRectMake(0, 0, 26, 26);
            if (annotation.iconType == MAP_iconTypeRoundedRedNumbers || annotation.iconType == MAP_iconTypeRoundedRedAlphabet) {
                [icon setBackgroundColor:ThemeColor];
            }else if (annotation.iconType == MAP_iconTypeRoundedBlueNumbers) {
                [icon setBackgroundColor:ThemeBlueColor];
            }else{
                [icon setBackgroundColor:[UIColor lightGrayColor]];
            }
            
            [icon setTitle:annotation.name forState:UIControlStateNormal];
            [icon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [icon setTitleEdgeInsets:UIEdgeInsetsMake(-11, 0, 0, 0)];
            [icon.titleLabel setFont:[UIFont systemFontOfSize:10 weight:UIFontWeightThin]];
            marker.iconView = icon;
        }
    }
    marker.map = _mapView;
}

- (void)addAnnotations:(NSArray <MMAnnotation *> *)annotations
{
    [annotations enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addAnnotation:obj];
    }];
}


- (void)addPolyLines:(NSArray <MMAnnotation *>*)annotations lineColor:(MAPLineColor)lineColor lineType:(MAPLineType)lineType;
{
    GMSMutablePath * gmspath=[GMSMutablePath path];
    for (MMAnnotation * model in annotations){
        [gmspath addCoordinate:model.coordinate];
    }
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:gmspath];
    if (lineType == MAPLineTypeSolid) {
        if (lineColor == MAPLineBlueColor) {
            polyline.spans = @[[GMSStyleSpan spanWithColor:ThemeBlueColor]];
        }else{
            polyline.spans = @[[GMSStyleSpan spanWithColor:ThemeYellowColor]];
        }
    }else{
        NSArray *styles = @[[GMSStrokeStyle solidColor:[UIColor clearColor]],[GMSStrokeStyle solidColor:ThemeBlueColor]];
        NSArray *lengths = @[@4];
        polyline.spans = GMSStyleSpans(polyline.path, styles, lengths, kGMSLengthRhumb);
    }
    polyline.strokeWidth = 3;
    polyline.map = _mapView;
}


- (void)addPolygon:(NSArray <MMAnnotation *>*)annotations lineType:(MAPLineType)lineType
{
    GMSMutablePath *rect = [GMSMutablePath path];
    [annotations enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [rect addCoordinate:obj.coordinate];
    }];
    GMSPolygon *polygon = [GMSPolygon polygonWithPath:rect];
    polygon.fillColor = ThemeBlueColorWith(0.25);
    polygon.strokeColor = ThemeBlueColor;
    polygon.strokeWidth = 2;
    polygon.map = self.mapView;
}

-(void)clear
{
    [_mapView clear];
    
}

#pragma  mark - GMSMapViewDelegate
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    NSLog(@"lat:%f,log:%f",coordinate.latitude,coordinate.longitude);
    if ([_delegate respondsToSelector:@selector(googleMapView:didSingleTappedAtCoordinate:)]) {
        [_delegate googleMapView:self didSingleTappedAtCoordinate:coordinate];
    }
    
}

@end
