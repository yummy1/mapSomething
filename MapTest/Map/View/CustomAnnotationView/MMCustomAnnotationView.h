//
//  MMCustomAnnotationView.h
//  MapTest
//
//  Created by mac on 2019/9/12.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMCustomAnnotationView : MAAnnotationView
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIImage *portrait;

@property (nonatomic, strong) UIView *calloutView;
@end

NS_ASSUME_NONNULL_END
