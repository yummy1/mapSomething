//
//  MMMapEditSingleAnnotationView.h
//  MapTest
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMMapEditAnnotationsPopupView;
@protocol MMMapEditAnnotationsPopupViewDelegate <NSObject>
- (void)editEndOnMMMapEditAnnotationsPopupView:(MMMapEditAnnotationsPopupView *)view editModel:(MMAnnotation *)model;
- (void)cancelOnMMMapEditAnnotationsPopupView:(MMMapEditAnnotationsPopupView *)view;

@end

@interface MMMapEditAnnotationsPopupView : UIView
@property (nonatomic,strong) MMAnnotation *model;
@property(nonatomic, weak) id<MMMapEditAnnotationsPopupViewDelegate> delegate;

@property (nonatomic,strong) NSString *tittleText;
@end


