//
//  MMSingleTapAnnotationView.h
//  MapTest
//
//  Created by mac on 2019/9/12.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "MMSingleTapIconView.h"

@class MMSingleTapAnnotationView;
@protocol MMSingleTapAnnotationViewDelegate <NSObject>
@optional
/**
    点击编辑
 */
- (void)MMSingleTapAnnotationViewSingleTapEdit:(MMSingleTapAnnotationView *)annotationView;
/**
    点击GO
 */
- (void)MMSingleTapAnnotationViewSingleTapGo:(MMSingleTapAnnotationView *)annotationView;
@end



@interface MMSingleTapAnnotationView : MAAnnotationView
@property(nonatomic, weak)id<MMSingleTapAnnotationViewDelegate>delegate;
@property(nonatomic,strong)MMSingleTapIconView *calloutView;
- (instancetype)initWithFrame:(CGRect)frame;

@end


