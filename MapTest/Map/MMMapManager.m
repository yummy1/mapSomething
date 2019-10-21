//
//  MMMapManager.m
//  SwellPro
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 MM. All rights reserved.
//

#import "MMMapManager.h"

@interface MMMapManager()
/** 地图 */
@property (nonatomic,strong) MMMapView *mapView;
/** 字母数组 */
@property (nonatomic,strong) NSArray *alphabetArr;
@end
@implementation MMMapManager
+ (instancetype)manager {
    static MMMapManager *sharedManager = nil;
    static dispatch_once_t storeToken;
    dispatch_once(&storeToken, ^{
        sharedManager = [[self alloc] init];
        [sharedManager commonInit];
    });
    return sharedManager;
}
- (void)commonInit
{
    NSString *localeLanguageCode = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] firstObject];
    NSLog(@"++%@",localeLanguageCode);
    if ([localeLanguageCode containsString:@"zh"]) {
        self.type = MapTypeGaoDe;
        self.isEnglish = NO;
    }else{
        self.type = MapTypeGoogle;
        self.isEnglish = YES;
    }
    self.mapFunction = MAP_pointTypePointingFlight;
    
    self.tapEnable = YES;
    
    self.showType = MapShowTypePreview;
    
    self.annotations = [NSMutableArray array];
    
}
- (NSArray *)alphabetArr
{
    if (!_alphabetArr) {
        _alphabetArr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    }
    return _alphabetArr;
}
- (NSMutableArray<MMAnnotation *> *)annotations
{
    [_annotations enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.index = idx+1;
        obj.title = [NSString stringWithFormat:@"%lu",(unsigned long)idx+1];
    }];
    return _annotations;
}
- (NSMutableArray *)selectedAnnotations
{
    NSMutableArray *array = [NSMutableArray array];
    [self.annotations enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected == YES) {
            [array addObject:obj];
        }
    }];
    _selectedAnnotations = [NSMutableArray arrayWithArray:array];
    return _selectedAnnotations;
}
- (NSMutableArray<MMAnnotation *> *)waiAnnotations
{
    _waiAnnotations = [NSMutableArray arrayWithArray:self.annotations];
    for (int i = 0; i < self.annotations.count-1; i++) {
        MMAnnotation *annotation = self.annotations[i];
        if([self isInRange:self.annotations annotation:annotation]){
            NSLog(@"在区域内");
            [_waiAnnotations removeObject:annotation];
        }
    }
    if (_waiAnnotations.count != self.annotations.count) {
        return _waiAnnotations;
    }else{
        _waiAnnotations = [[self reorder:_waiAnnotations] mutableCopy];
        return _waiAnnotations;
    }
}
- (NSArray *)groupArray
{
    NSMutableArray *fenzuArr = [NSMutableArray array];
    [self.waiAnnotations enumerateObjectsUsingBlock:^(MMAnnotation *point, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx != self.waiAnnotations.count-1) {
            [fenzuArr addObject:@[point,self.waiAnnotations[idx+1]]];
        }else{
            [fenzuArr addObject:@[point,self.waiAnnotations[0]]];
        }
    }];
    return [fenzuArr copy];
}
- (NSArray *)middleArray
{
    NSMutableArray *middleArr = [NSMutableArray array];
    [self.groupArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //起点
        MMAnnotation *point1 = obj[0];
        double lat1 = point1.coordinate.latitude;
        double log1 = point1.coordinate.longitude;
        //终点
        MMAnnotation *point2 = obj[1];
        double lat2 = point2.coordinate.latitude;;
        double log2 = point2.coordinate.longitude;
        //中点
        double middleLat = (lat1 + lat2)/2;
        double middleLog = (log1 + log2)/2;
        //加入数组
        MMAnnotation *middlePoint = [[MMAnnotation alloc] init];
        middlePoint.coordinate = CLLocationCoordinate2DMake(middleLat, middleLog);
        middlePoint.iconType = MAP_iconTypeRoundedGreyAlphabet;
        middlePoint.index = idx+1;
        middlePoint.title = self.alphabetArr[idx];
        [middleArr addObject:middlePoint];
    }];
    return [middleArr copy];
}
- (UIView *)shadeView
{
    if (!_shadeView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHight)];
        view.backgroundColor = RGBA(0, 0, 0, 0.6);
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:view];
        _shadeView = view;
    }
    _shadeView.hidden = NO;
    return _shadeView;
}
#pragma mark 判断某点是否在一个区域内
- (BOOL)isInRange:(NSArray *)totalArr annotation:(MMAnnotation *)annotation
{
    NSMutableArray *xinRet = [totalArr mutableCopy];
    [xinRet removeObject:annotation];
    if (self.type == MapTypeGaoDe) {
        //除了此点以外的点绘制区域
        CLLocationCoordinate2D rectPoints[xinRet.count];
        for (int i=0; i<xinRet.count; i++) {
            MMAnnotation *pointAnnotation = xinRet[i];
            CLLocationCoordinate2D Coordinate = pointAnnotation.coordinate;
            rectPoints[i] = Coordinate;
        }
        MAPolygon *rectangle = [MAPolygon polygonWithCoordinates:rectPoints count:xinRet.count];
        CLLocationCoordinate2D loc = annotation.coordinate;
        MAMapPoint point = MAMapPointForCoordinate(loc);
        if(MAPolygonContainsPoint(point, rectangle.points, xinRet.count)) {
            NSLog(@"在区域内");
            return YES;
        }else{
            NSLog(@"不在区域内");
            return NO;
        }
    }else{
        //除了此点意外的点绘制区域
        GMSMutablePath *rect = [GMSMutablePath path];
        [xinRet enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [rect addCoordinate:obj.coordinate];
        }];
        GMSPolygon *polygon = [GMSPolygon polygonWithPath:rect];
        DLog(@"检测点%@",annotation);
        DLog(@"其他点的区域%@",xinRet);
        if(GMSGeometryContainsLocation(annotation.coordinate, polygon.path, NO)){
            NSLog(@"在区域内");
            return YES;
        }else{
            NSLog(@"不在区域内");
            return NO;
        }
    }
}
#pragma mark 凹多边形边凸多边形
- (NSArray *)reorder:(NSArray *)annotations
{
    //鉴于最后点的顺序可能被打乱，所以在此重新找出1点然后排序
    __block NSInteger one = 0;
    __block NSInteger two = 0;
    [annotations enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.index == 1) {
            one = idx;
        }
        if (obj.index == 2) {
            two = idx;
        }
    }];
    NSMutableArray *chongPaiArr = [NSMutableArray array];
    //1在前还是2在前
    NSInteger cha = two - one;
    //1和2正序相距多远
    if (cha > 0) {
        //1在前、2在后
        //算出1和2倒序相距多远
        NSInteger oneDao = one + annotations.count - two;
        if (cha > oneDao) {
            //开始倒序排
            NSMutableArray *daoArr = [[[annotations reverseObjectEnumerator] allObjects] mutableCopy];
            //倒序之后1的位置变化
            NSInteger oneChange = daoArr.count-one-1;
            [chongPaiArr addObjectsFromArray:[daoArr subarrayWithRange:NSMakeRange(oneChange, annotations.count-oneChange)]];
            [chongPaiArr addObjectsFromArray:[daoArr subarrayWithRange:NSMakeRange(0, oneChange)]];
        }else{
            //开始顺序排
            [chongPaiArr addObjectsFromArray:[annotations subarrayWithRange:NSMakeRange(one, annotations.count-one)]];
            [chongPaiArr addObjectsFromArray:[annotations subarrayWithRange:NSMakeRange(0, one)]];
        }
    }else{
        //2在前、1在后
        NSInteger twoDao = two + annotations.count-one;
        if (labs(cha) > twoDao) {
            //开始顺序排
            [chongPaiArr addObjectsFromArray:[annotations subarrayWithRange:NSMakeRange(one, annotations.count-one)]];
            [chongPaiArr addObjectsFromArray:[annotations subarrayWithRange:NSMakeRange(0, one)]];
        }else{
            //开始倒序排
            NSMutableArray *daoArr = [[[annotations reverseObjectEnumerator] allObjects] mutableCopy];
            NSInteger oneChange = daoArr.count-one-1;
            [chongPaiArr addObjectsFromArray:[daoArr subarrayWithRange:NSMakeRange(oneChange, annotations.count-oneChange)]];
            [chongPaiArr addObjectsFromArray:[daoArr subarrayWithRange:NSMakeRange(0, oneChange)]];
        }
    }
    return chongPaiArr;
}
#pragma mark - 对外方法
- (void)clearDataArray
{
    [self.annotations removeAllObjects];
    [self.waiAnnotations removeAllObjects];
    [self.groupArray removeAllObjects];
    [self.middleArray removeAllObjects];
}
- (void)updateAnnotations:(MMAnnotation *)model
{
    [self.annotations enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
        [self.selectedAnnotations enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
            if ([obj1 isEqual:obj2]) {
                obj1.parameter.FK_height = model.parameter.FK_height;
                obj1.parameter.FK_speed = model.parameter.FK_speed;
                obj1.parameter.FK_standingTime = model.parameter.FK_standingTime;
                obj1.parameter.FK_headOrientation = model.parameter.FK_headOrientation;
                if (model.coordinate.latitude != 0) {
                    obj1.coordinate = model.coordinate;
                }
            }
        }];
    }];
}
- (BOOL)isOverFlightAtFlyCoordinate:(CLLocationCoordinate2D)flyCoordinate userCoordinate:(CLLocationCoordinate2D)userCoordinate;
{
    if (_type == MapTypeGaoDe) {
        MAMapPoint point1 = MAMapPointForCoordinate(userCoordinate);
        MAMapPoint point2 = MAMapPointForCoordinate(flyCoordinate);
        CLLocationDistance distance = MAMetersBetweenMapPoints(point1, point2);
        if (distance > 500) {
            return YES;
        }else{
            return NO;
        }
    }else{
        double distance = GMSGeometryDistance(userCoordinate, flyCoordinate);
        if (distance > 500) {
            return YES;
        }else{
            return NO;
        }
    }
}
- (void)addPopopView:(UIView *)view
{
    CGFloat y = view.y;
    view.y = ViewHight;
    [self.shadeView addSubview:view];
    [UIView animateWithDuration:0.3 animations:^{
        view.y = y;
    }];
}
- (void)clearShadeView
{
    [self.shadeView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    self.shadeView.hidden = YES;
}
@end
