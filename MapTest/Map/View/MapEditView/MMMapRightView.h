//
//  MMMapRightView.h
//  MapTest
//
//  Created by mac on 2019/9/17.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapStructure.h"

@class MMMapRightView;
@protocol MMMapRightViewDelegate<NSObject>
@optional
- (void)mapRightView:(MMMapRightView *)rightView index:(MAP_pointType)index;
@end
@interface MMMapRightView : UIView
@property (nonatomic,weak) id<MMMapRightViewDelegate> delegate;
- (void)defaultUI;
/** 1指点飞行、2航线规划、3区域航线、4收藏航线 */
@property (nonatomic,assign) MAP_pointType mapIndex;
@end


