//
//  MMMapEditPolygonView.h
//  MapTest
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMMapEditPolygonPopupView;
@protocol MMMapEditPolygonPopupViewDelegate<NSObject>
- (void)editEndOnMMMapEditPolygonPopupView:(MMMapEditPolygonPopupView *)view regulation:(NSInteger)regulation spacing:(NSInteger)spacing speed:(NSString *)speed height:(NSString *)height;
- (void)cancelOnMMMapEditPolygonPopupView:(MMMapEditPolygonPopupView *)view;
@end
@interface MMMapEditPolygonPopupView : UIView
@property(nonatomic, weak) id<MMMapEditPolygonPopupViewDelegate> delegate;
@end


