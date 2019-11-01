//
//  MMMapMyCollectView.h
//  MapTest
//
//  Created by mac on 2019/11/1.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MMMapMyCollectView;
@protocol MMMapMyCollectViewDelegate <NSObject>
- (void)MMMapMyCollectViewClickIndex:(NSDictionary *)dic;
- (void)MMMapMyCollectViewCancel;
@end
@interface MMMapMyCollectView : UIView
@property(nonatomic, weak) id<MMMapMyCollectViewDelegate> delegate;
@end


