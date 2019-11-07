//
//  ViewController.m
//  MapTest
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "VideoController.h"
#import "AppDelegate.h"


@interface VideoController ()<MMMapViewDelegate,MMLocationManagerDelegate>
@property (nonatomic,strong) UIView *videoView;
@property (nonatomic,strong) MMMapView *mapView;
@property (nonatomic,strong) UITapGestureRecognizer *dituTap;
@property (nonatomic,strong) UITapGestureRecognizer *hangpaiTap;
@property(nonatomic, strong) MMLocationManager *lcManager;

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
        _mapView.frame = CGRectMake(0, ViewHight*0.66, ViewWidth*0.34, ViewHight*0.34);
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

    self.lcManager = [MMLocationManager manager];
    self.lcManager.delegate = self;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    //2、开始定位
    [self.lcManager startUpdatingLocation];
    [self.lcManager startUpdatingHeading];
}

- (void)changeMapViewBig
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.5 animations:^{
        weakSelf.mapView.frame = CGRectMake(0, 0, ViewWidth, ViewHight);
        weakSelf.videoView.frame = CGRectMake(0, ViewHight*0.66, ViewWidth*0.34, ViewHight*0.34);
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
        weakSelf.mapView.frame = CGRectMake(0, ViewHight*0.66, ViewWidth*0.34, ViewHight*0.34);
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
#pragma mark - MMLocationManagerDelegate
-(void)MMLocationManager:(MMLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    DLog(@"原始位置%f-%f",location.coordinate.latitude,location.coordinate.longitude);
    CLLocationCoordinate2D coo = [CLLocation transformFromWGSToGCJ:location.coordinate];
    DLog(@"转国标%f-%f",coo.latitude,coo.longitude);
    CLLocationCoordinate2D ccc  = [CLLocation transformFromGCJToWGS:coo];
    DLog(@"转原始%f-%f",ccc.latitude,ccc.longitude);
    
//    _curCoordinate2D = coo;
//    _curAltitude = location.altitude;
//    _speed = location.speed;
//
    [TheNotificationCenter postNotificationName:@"kMMMapViewLocationUpdateNotification"
                                         object:nil userInfo:@{@"kMMMapViewLocationUpdateNotification":location}];
//    self.mapView.centerCoordinate = self.curCoordinate2D;
//    DLog(@"location:%f - %f",
//          coo.latitude,
//          coo.longitude);
}

-(void)MMLocationManager:(MMLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
//    self.heading = newHeading;
//    DLog(@"%f",newHeading.magneticHeading);
//    [TheNotificationCenter postNotificationName:kMMMapViewLocationHeadingUpdateNotification
//                                         object:nil userInfo:@{kMMMapViewLocationHeadingUpdateNotification:newHeading}];
}
@end
