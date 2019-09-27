//
//  MMGDPolygon.h
//  SwellPro
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 MM. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMGDPolygon : MAPolygon
//1实线、2虚线
@property (nonatomic,assign) MAPLineType lineType;
@end

NS_ASSUME_NONNULL_END
