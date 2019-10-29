//
//  MMMapEditSingleTapPopupView.h
//  MapTest
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMMapEditSingleTapPopupView;
@protocol MMMapEditSingleTapPopupViewDelegate <NSObject>
- (void)editEndOnMMMapEditSingleTapPopupView:(MMMapEditSingleTapPopupView *)view editModel:(MMAnnotation *)model;
- (void)cancelOnMMMapEditSingleTapPopupView:(MMMapEditSingleTapPopupView *)view;

@end

@interface MMMapEditSingleTapPopupView : UIView
@property (nonatomic,strong) MMAnnotation *model;
@property(nonatomic, weak) id<MMMapEditSingleTapPopupViewDelegate> delegate;
@end


