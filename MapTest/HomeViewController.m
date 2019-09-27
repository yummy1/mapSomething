//
//  HomeViewController.m
//  MapTest
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "HomeViewController.h"
#import "VideoController.h"
#import "AppDelegate.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (IBAction)goAction:(UIButton *)sender {
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.allowRotation=YES;
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIDeviceOrientationLandscapeRight] forKey:@"orientation"];
    
    VideoController *vc = [[VideoController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
