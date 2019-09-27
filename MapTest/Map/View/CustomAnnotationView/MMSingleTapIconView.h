//
//  MMSingleTapIconView.h
//  MapTest
//
//  Created by mac on 2019/9/12.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MMAnnotation;
@class MMSingleTapIconView;
@protocol MMSingleTapIconViewDelegate<NSObject>
@optional
/**
 点击编辑
 */
- (void)MMSingleTapIconViewClickEdit:(MMSingleTapIconView *)iconView;
/**
 点击GO
 */
- (void)MMSingleTapIconViewClickGo:(MMSingleTapIconView *)iconView;
@end
@interface MMSingleTapIconView : UIView
@property (nonatomic,strong) MMAnnotation *model;
@property (nonatomic,weak) id<MMSingleTapIconViewDelegate> delegate;

//编辑
@property (nonatomic,strong) UIButton *editBtn;
//go按钮
@property (nonatomic,strong) UIButton *goBtn;
@end


