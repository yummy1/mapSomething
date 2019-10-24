//
//  MMMapManager.h
//  SwellPro
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 MM. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MMMapManager : NSObject
/** 地图的可交互模式 默认为正常可交互的模式 */
@property(nonatomic, assign) MapShowType showType;
/** 地图类型：默认会按照语言判断是使用高德还是google */
@property(nonatomic, assign) MapType type;
/** 是否是英文 */
@property(nonatomic, assign) BOOL isEnglish;

/** 1指点飞行、2航线规划、3区域航线、4收藏航线 */
@property (nonatomic,assign) MAP_pointType mapFunction;

/** 地图上是否可点击增加航点（主要针对区域航线，是否进入飞行编辑状态）(默认YES) */
@property(nonatomic, assign) BOOL tapEnable;

/** 地图上的点 */
@property (nonatomic,strong) NSMutableArray<MMAnnotation *> * annotations;
/** 选中编辑的点 */
@property (nonatomic,strong) NSMutableArray<MMAnnotation *> *selectedAnnotations;
/** 区域航线时,计算区域边上的点（出掉区域内的点） */
//@property (nonatomic,strong) NSMutableArray<MMAnnotation *> *waiAnnotations;
/** 区域边点（两点为一条边进行分组） */
@property (nonatomic,strong) NSMutableArray *groupArray;
/** 区域所有边的中点数组 */
@property (nonatomic,strong) NSMutableArray <MMAnnotation *> *middleArray;
/** 弹出视图的遮罩 */
@property (nonatomic,strong) UIView *shadeView;

+ (instancetype) manager;

/**
   清空所有数组
*/
- (void)clearDataArray;
/**
    编辑点之后更新点数据parameter
 */
- (void)updateAnnotations:(MMAnnotation *)model;
/**
   新添加或者删除航点后，重新查看是否凹多边形、凸多边形
*/
- (void)changeConvexPolygon:(NSArray *)points;
/**
    是否超出飞行范围
 */
- (BOOL)isOverFlightAtFlyCoordinate:(CLLocationCoordinate2D)flyCoordinate userCoordinate:(CLLocationCoordinate2D)userCoordinate;
/**
    往遮罩上加东西
 */
- (void)addPopopView:(UIView *)view;
/**
   清除遮罩
*/
- (void)clearShadeView;

@end


