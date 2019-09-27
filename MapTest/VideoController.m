//
//  ViewController.m
//  MapTest
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "VideoController.h"
#import "AppDelegate.h"


@interface VideoController ()<MMMapViewDelegate>
@property (nonatomic,strong) UIView *videoView;
@property (nonatomic,strong) MMMapView *mapView;
@property (nonatomic,strong) UITapGestureRecognizer *dituTap;
@property (nonatomic,strong) UITapGestureRecognizer *hangpaiTap;
@end

@implementation VideoController
- (UIView *)videoView
{
    if (!_videoView) {
        _videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHight)];
        _videoView.backgroundColor = [UIColor grayColor];
    }
    return _videoView;
}
- (MMMapView *)mapView
{
    if (!_mapView) {
        _mapView = [MMMapView mapView];
        _mapView.frame = CGRectMake(0, ViewHight*0.67, ViewWidth*0.33, ViewHight*0.33);
//        _dituTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeMapViewBig)];
//        [_mapView addGestureRecognizer:_dituTap];
        _mapView.delegate = self;
    }
    return _mapView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.videoView];
    [self.view addSubview:self.mapView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)changeMapViewBig
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.5 animations:^{
        weakSelf.mapView.frame = CGRectMake(0, 0, ViewWidth, ViewHight);
        weakSelf.videoView.frame = CGRectMake(0, ViewHight*0.67, ViewWidth*0.33, ViewHight*0.33);
    } completion:^(BOOL finished) {
        [self.view bringSubviewToFront:weakSelf.videoView];
        weakSelf.hangpaiTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeVideoViewBig)];
        [weakSelf.videoView addGestureRecognizer:weakSelf.hangpaiTap];
        [weakSelf.mapView mapChangeSmall:NO];
        [MMMapManager manager].showType = MapShowTypeUsing;
    }];
    
}
- (void)changeVideoViewBig
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.5 animations:^{
        weakSelf.videoView.frame = CGRectMake(0, 0, ViewWidth, ViewHight);
        weakSelf.mapView.frame = CGRectMake(0, ViewHight*0.67, ViewWidth*0.33, ViewHight*0.33);
    } completion:^(BOOL finished) {
        [self.view bringSubviewToFront:weakSelf.mapView];
        weakSelf.hangpaiTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeVideoViewBig)];
        [weakSelf.videoView addGestureRecognizer:weakSelf.hangpaiTap];
        [weakSelf.mapView mapChangeSmall:YES];
        [MMMapManager manager].showType = MapShowTypePreview;
    }];
}
#pragma mark - MMMapViewDelegate
- (void)MMMapViewPreviewClick:(MMMapView *)mapView
{
    [self changeMapViewBig];
}
@end
