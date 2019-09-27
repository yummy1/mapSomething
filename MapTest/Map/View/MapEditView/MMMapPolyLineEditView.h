//
//  MMMapPolyLineEditView.h
//  MapTest
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MMMapPolyLineEditView;
@protocol MMMapPolyLineEditViewDelegate <NSObject>
@optional
/** 选中航点 */
//index:若为一个时显示选中第几个
- (void)selctedMarkOnMapDuodianEditView:(MMMapPolyLineEditView *)editView selectedMarkArr:(NSArray *)markArr oneIndex:(NSInteger)index;
//全选
- (void)clickAllOnMapDuodianEditView:(MMMapPolyLineEditView *)editView isYes:(BOOL)yes;
//收藏
- (void)clickCollectOnMapDuodianEditView:(MMMapPolyLineEditView *)editView;
//编辑
- (void)clickEditOnMapDuodianEditView:(MMMapPolyLineEditView *)editView;
//添加航点
- (void)addHangdianOnMapDuodianEditView:(MMMapPolyLineEditView *)editView;
//航线规划时
- (void)clickGoOnMapDuodianEditView:(MMMapPolyLineEditView *)editView;
//区域航线时
- (void)clickDuiOnMapDuodianEditView:(MMMapPolyLineEditView *)editView;
- (void)clickCuoOnMapDuodianEditView:(MMMapPolyLineEditView *)editView;
@end
@interface MMMapPolyLineEditView : UIView

@property (nonatomic,strong) NSMutableArray *markArr;
@property (nonatomic,weak) id<MMMapPolyLineEditViewDelegate> delegate;
//全部标记
@property (nonatomic,strong) NSMutableArray *buttonArr;

- (void)setUpButton;
@end


