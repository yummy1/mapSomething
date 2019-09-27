//
//  MapStructure.h
//  SwellPro
//
//  Created by MM on 2018/6/1.
//  Copyright © 2018年 MM. All rights reserved.
//

#ifndef MapStructure_h
#define MapStructure_h

typedef NS_ENUM(NSInteger, MapShowType) {
    MapShowTypePreview = 1, //预览模式
    MapShowTypeUsing        //正常使用模式
};

typedef NS_ENUM(NSInteger, MapType) {
    MapTypeGaoDe = 1,
    MapTypeGoogle
};
//1我的位置、2指南针、3图层、4地图切换、5无人机位置
typedef NS_ENUM(NSInteger,MAP_function){
    MAP_functionMyLocation = 1,
    MAP_functionCompass = 2,
    MAP_functionLayer = 3,
    MAP_functionMapSwitch = 4,
    MAP_functionFlyLocation = 5,
};
/** 1指点飞行、2航线规划、3区域航线、4收藏航线、5不显示 */
typedef NS_ENUM(NSInteger,MAP_pointType){
    MAP_pointTypePointingFlight = 1,
    MAP_pointTypeRoutePlanning = 2,
    MAP_pointTypeRegionalRoute = 3,
    MAP_pointTypeCollectionRoute = 4,
    MAP_pointTypeHidden = 5,
};
//针对高德:1:普通红色，2普通蓝色，3圆形红色数字，4圆形蓝色数字，5圆形红色字母，6圆形灰色字母
typedef NS_ENUM(NSInteger,MAP_iconType){
    MAP_iconTypeCommonRed = 1,
    MAP_iconTypeCommonBlue = 2,
    MAP_iconTypeRoundedRedNumbers = 3,
    MAP_iconTypeRoundedBlueNumbers = 4,
    MAP_iconTypeRoundedRedAlphabet = 5,
    MAP_iconTypeRoundedGreyAlphabet = 6,
};
//线的颜色
typedef NS_ENUM(NSInteger, MAPLineColor){
    MAPLineBlueColor = 1,
    MAPLineYellowColor = 2,
};
//区域边框 1实线，2虚线
typedef NS_ENUM(NSInteger, MAPLineType){
    MAPLineTypeSolid = 1,
    MAPLineTypeDashed = 2,
};






#endif /* MapStructure_h */
