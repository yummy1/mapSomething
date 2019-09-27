//
//  MMMapEditPolygonJWView.h
//  MapTest
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MMMapEditPolygonJWPopupView;
@protocol MMMapEditPolygonJWPopupViewDelegate <NSObject>
- (void)editEndOnMMMapEditPolygonJWView:(MMMapEditPolygonJWPopupView *)view editModel:(MMAnnotation *)model;
- (void)cancelOnMMMapEditPolygonJWView:(MMMapEditPolygonJWPopupView *)view;

@end

@interface MMMapEditPolygonJWPopupView : UIView
@property (nonatomic,strong) MMAnnotation *model;
@property(nonatomic, weak) id<MMMapEditPolygonJWPopupViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
