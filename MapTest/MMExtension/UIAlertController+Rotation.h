//
//  UIAlertController+Rotation.h
//  SwellPro
//
//  Created by MM on 2018/6/14.
//  Copyright © 2018年 MM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Rotation)
//解决横屏AlertController崩溃的问题
- (BOOL)shouldAutorotate;
@end
