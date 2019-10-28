//
//  MMMapPolygonEditView.h
//  MapTest
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MMMapPolygonEditView;
@protocol MMMapPolygonEditViewDelegate<NSObject>
@optional
//收藏
- (void)clickCollectOnQuyuChooseView:(MMMapPolygonEditView *)quyuView;
//重新规划
- (void)clickReplanningOnQuyuChooseView:(MMMapPolygonEditView *)quyuView;
//对
- (void)clickDuiOnQuyuChooseView:(MMMapPolygonEditView *)quyuView;
//错
- (void)clickCuoOnQuyuChooseView:(MMMapPolygonEditView *)quyuView;
//选中某个
- (void)selctedOnQuyuChooseView:(MMMapPolygonEditView *)quyuView index:(NSInteger)index;
@end
@interface MMMapPolygonEditView : UIView
/** 1显示ABCD时、2显示来回航线时 */
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,weak) id<MMMapPolygonEditViewDelegate> delegate;
//对所有的标记外圈点进行两两分组
@property (nonatomic,strong) NSArray *fenzuArr;
//中点数组
@property (nonatomic,strong) NSArray *middleArr;
//显示收藏和重新规划按钮
- (void)showCollectAndReplaning:(BOOL)isShow;
//区域来回航线
- (void)quyuRoundtripFlightPoint:(NSArray *)array;
@end


