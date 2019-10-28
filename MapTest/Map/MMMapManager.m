//
//  MMMapManager.m
//  SwellPro
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 MM. All rights reserved.
//

#import "MMMapManager.h"
#import "QuyuMethods.h"
#import "LandPointArrayList.h"

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
    
    self.startIndex = 0;
    self.bianIndex = 0;
    
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
        obj.name = [NSString stringWithFormat:@"%lu",(unsigned long)idx+1];
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
- (NSArray *)groupArray
{
    NSMutableArray *fenzuArr = [NSMutableArray array];
    [self.annotations enumerateObjectsUsingBlock:^(MMAnnotation *point, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != self.annotations.count-1) {
            [fenzuArr addObject:@[point,_annotations[idx+1]]];
        }else{
            [fenzuArr addObject:@[point,_annotations[0]]];
        }
    }];
    NSArray *points = fenzuArr[_bianIndex];
    [points enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.index = idx+1;
        obj.name = [NSString stringWithFormat:@"%lu",(unsigned long)idx+1];
        if (_startIndex == idx) {
            obj.iconType = MAP_iconTypeRoundedRedNumbers;
        }else{
            obj.iconType = MAP_iconTypeRoundedBlueNumbers;
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
        middlePoint.index = idx+1;
        middlePoint.name = self.alphabetArr[idx];
        middlePoint.iconType = MAP_iconTypeRoundedGreyAlphabet;
        if (_bianIndex == idx) {
            middlePoint.iconType = MAP_iconTypeRoundedRedAlphabet;
        }
        [middleArr addObject:middlePoint];
    }];
    return [middleArr copy];
}
- (NSArray *)parallelLines
{
    //1、所有边上的所有点坐标转墨卡托坐标
    NSMutableArray *mapwaiArr = [NSMutableArray array];
    [self.annotations enumerateObjectsUsingBlock:^(MMAnnotation *point, NSUInteger idx, BOOL * _Nonnull stop) {
         float X = point.coordinate.latitude;
         float Y = point.coordinate.longitude;
        
         CGPoint jwd = CGPointMake(Y,X);
         CGPoint mkt = [QuyuMethods lonLat2Mercator:jwd];
         MMAnnotation *model = [[MMAnnotation alloc] init];
         model.coordinate = CLLocationCoordinate2DMake(mkt.x, mkt.y);
         [mapwaiArr addObject:model];
    }];
    NSMutableArray *fenzuArr = [NSMutableArray array];
    [mapwaiArr enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != mapwaiArr.count-1) {
            [fenzuArr addObject:@[obj,mapwaiArr[idx+1]]];
        }else{
            [fenzuArr addObject:@[obj,mapwaiArr[0]]];
        }
    }];
    //2、所有边转模型
    NSMutableArray *modelArr = [NSMutableArray array];
    [self.groupArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MMAnnotation *zero = obj[0];
        MMAnnotation *one = obj[1];
        double ax = zero.coordinate.latitude;
        double ay = zero.coordinate.longitude;
        double bx = one.coordinate.latitude;
        double by = one.coordinate.longitude;
        QuyuRoutesCalculateModel *bianModel = [QuyuMethods calculateSignleSlopeOne:CGPointMake(ax, ay) two:CGPointMake(bx, by)];
        [modelArr addObject:bianModel];
    }];
    //3、获取平行线与边相交的所有点
    int selectedEdge = (int)_bianIndex;
    NSArray *jiaoDianArr = [QuyuMethods getAllLinePoints:selectedEdge array:modelArr distance:_spacing];
    
    //判断点的个数，不能多于126个
    if (jiaoDianArr.count*2 > 126) {
        [SVProgressHUD showInfoWithStatus:Localized(@"TIP_mapMaxPoints")];
        [SVProgressHUD dismissWithDelay:2.0];
        return nil;
    }
    if (jiaoDianArr.count == 0) {
        return jiaoDianArr;
    }
    //找寻第一个点还是之前的第一个点吗
    MMAnnotation *qianOne = self.groupArray[selectedEdge][0];
    NSInteger yuanOne = qianOne.coordinate.latitude;
    LandPointArrayList *houModel = jiaoDianArr[0];
    NSInteger houOne = houModel.landPointStart.x;
    DLog(@"yuanOne:%ld、houOne:%ld、houTwo:%f",(long)yuanOne,(long)houOne,houModel.landPointEnd.x);
    //墨卡托转经纬度
    [jiaoDianArr enumerateObjectsUsingBlock:^(LandPointArrayList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.landPointStart = [QuyuMethods Mercator2lonLat:obj.landPointStart];
        obj.landPointEnd = [QuyuMethods Mercator2lonLat:obj.landPointEnd];
    }];
    
    //交点分组划线,xy和经纬度
    
    BOOL shuanghuan = YES;
    if (houOne == yuanOne) {
        if (self.startIndex == 1) {
            //双不换，单换
            shuanghuan = NO;
        }else{
            //双换，单不换
            shuanghuan = YES;
        }
    }else{
        if (self.startIndex == 1) {
            //双换，单不换
            shuanghuan = YES;
        }else{
            //双不换，单换
            shuanghuan = NO;
        }
    }
    
    [jiaoDianArr enumerateObjectsUsingBlock:^(LandPointArrayList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (shuanghuan) {
                //双数换，单数不换
                if (idx%2 == 0) {
                    CGPoint start = obj.landPointStart;
                    obj.landPointStart = CGPointMake(obj.landPointEnd.y, obj.landPointEnd.x);
                    obj.landPointEnd = CGPointMake(start.y, start.x);
                }else{
                    CGPoint start = obj.landPointStart;
                    CGPoint end = obj.landPointEnd;
                    obj.landPointStart = CGPointMake(start.y, start.x);
                    obj.landPointEnd = CGPointMake(end.y, end.x);
                }
            }else{
                //单数换，双数不换
                if (idx%2 == 1) {
                    CGPoint start = obj.landPointStart;
                    obj.landPointStart = CGPointMake(obj.landPointEnd.y, obj.landPointEnd.x);
                    obj.landPointEnd = CGPointMake(start.y, start.x);
                }else{
                    CGPoint start = obj.landPointStart;
                    CGPoint end = obj.landPointEnd;
                    obj.landPointStart = CGPointMake(start.y, start.x);
                    obj.landPointEnd = CGPointMake(end.y, end.x);
                }
            }
    }];
    return jiaoDianArr;
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
#pragma mark - 区域点重新排序
#pragma mark 升序
- (NSArray *)paixuX:(NSArray *)array
{
    NSLog(@"排序前%@",array);
    //升序
    NSMutableArray *paixuArr = [array mutableCopy];
    for (int i = 0; i < paixuArr.count; ++i) {
        //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
        for (int j = 0; j < paixuArr.count-1; ++j) {
            MMAnnotation *J = paixuArr[j];
            MMAnnotation *J1 = paixuArr[j+1];
            double X = J.coordinate.latitude;
            double X1 = J1.coordinate.latitude;
            //根据索引的`相邻两位`进行`比较`
            if (X > X1) {
                [paixuArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"%@",paixuArr);
    return [paixuArr copy];
}
- (NSArray *)fenZu:(NSArray *)array
{
    NSLog(@"排序后%@",array);
    //    定义：平面上的三点P1(x1,y1),P2(x2,y2),P3(x3,y3)的面积量：
    //    S(P1,P2,P3)=|y1 y2 y3|= (x1-x3)*(y2-y3)-(y1-y3)*(x2-x3)
    //    当P1P2P3逆时针时S为正的，当P1P2P3顺时针时S为负的。
    //    令矢量的起点为A，终点为B，判断的点为C，
    //    如果S（A，B，C）为正数，则C在矢量AB的左侧；
    //    如果S（A，B，C）为负数，则C在矢量AB的右侧；
    //    如果S（A，B，C）为0，则C在直线AB上。
    NSMutableArray *topArr = [NSMutableArray array];
    NSMutableArray *bottomArr = [NSMutableArray array];
    MMAnnotation *firstMark = array.firstObject;
    MMAnnotation *lastMark = array.lastObject;
    [array enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        double ji = (firstMark.coordinate.latitude-obj.coordinate.latitude)*(lastMark.coordinate.longitude-obj.coordinate.longitude)-(firstMark.coordinate.longitude-obj.coordinate.longitude)*(lastMark.coordinate.latitude-obj.coordinate.latitude);
        if (ji>0) {
            [topArr addObject:obj];
        }else if (ji<0){
            [bottomArr addObject:obj];
        }
    }];
    NSLog(@"top%@",topArr);
    NSLog(@"bottom%@",bottomArr);
    NSArray *paixuTopArr = [self paixuX:topArr];
    NSArray *paixuBottomArr = [[[self paixuX:bottomArr] reverseObjectEnumerator] allObjects];
    
    NSMutableArray *paixuTotalArr = [NSMutableArray array];
    [paixuTotalArr addObject:firstMark];
    [paixuTotalArr addObjectsFromArray:paixuTopArr];
    [paixuTotalArr addObject:lastMark];
    [paixuTotalArr addObjectsFromArray:paixuBottomArr];
    return [paixuTotalArr copy];
}
#pragma mark 凹多边形边凸多边形
- (void)changeConvexPolygon:(NSArray *)points
{
    if (points.count < 3) {
        return;
    }
    //新加入的点在区域内，则去除不显示
    NSMutableArray *beforeQuyu = [points mutableCopy];
    [beforeQuyu removeLastObject];
    if ([self isInRange:beforeQuyu annotation:points.lastObject]) {
        //在区域内
        [_annotations removeLastObject];
        return;
    }
    //去除区域内的点
    NSArray *shengArr = [self paixuX:points];
    //分两组排序
    NSArray *paixuArr = [self fenZu:shengArr];
    
    NSMutableArray *totalArr = [NSMutableArray arrayWithArray:paixuArr];
    __block NSArray *resultArr;
    [paixuArr enumerateObjectsUsingBlock:^(MMAnnotation * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *quyuArr = [NSMutableArray arrayWithArray:totalArr];
        [quyuArr removeObject:obj];
        if ([self isInRange:quyuArr annotation:obj]) {
            //在区域内
            [totalArr removeObject:obj];
        }
        if (idx == paixuArr.count-1) {
            if (totalArr.count != paixuArr.count) {
                [self changeConvexPolygon:totalArr];
            }else{
                resultArr = [self reorder:totalArr];
                _annotations = [resultArr mutableCopy];
            }
        }
    }];
}
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
    [_annotations removeAllObjects];
    [_groupArray removeAllObjects];
    [_middleArray removeAllObjects];
    _bianIndex = 0;
    _startIndex = 0;
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
