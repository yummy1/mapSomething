//
//  MMMapSelectedAnnotationView.h
//  MapTest
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMMapSelectedAnnotationEditView;
@protocol MMMapSelectedAnnotationEditViewDelegate <NSObject>
@optional
- (void)deleteOnMMMapSelectedAnnotationEditView:(MMMapSelectedAnnotationEditView *)view;
@end

@interface MMMapSelectedAnnotationEditView : UIView
@property (nonatomic,strong) NSMutableArray *selectedArr;
@property (nonatomic,weak) id<MMMapSelectedAnnotationEditViewDelegate> delegate;

@end


