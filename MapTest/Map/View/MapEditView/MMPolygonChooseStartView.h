//
//  MMPolygonChooseStartView.h
//  MapTest
//
//  Created by mac on 2019/9/26.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MMPolygonChooseStartView;
@protocol MMPolygonChooseStartViewDelegate<NSObject>
@optional
- (void)selectedOnMMPolygonChooseStartView:(MMPolygonChooseStartView *)view index:(NSInteger)index;
@end
@interface MMPolygonChooseStartView : UIView
@property (nonatomic,weak) id<MMPolygonChooseStartViewDelegate> delegate;
//恢复默认
- (void)setDefault;

@end

NS_ASSUME_NONNULL_END
