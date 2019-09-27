//
//  AppDelegate.h
//  MapTest
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/** 横竖屏 */
@property(nonatomic, assign) UIInterfaceOrientationMask allowRotation;

@end

