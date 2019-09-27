//
//  MapMyCollectViewController.m
//  SwellPro
//
//  Created by MM on 2018/6/12.
//  Copyright © 2018年 MM. All rights reserved.
//

#import "MMMapMyCollectViewController.h"


@interface MMMapMyCollectViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *collectedArr;
@end

@implementation MMMapMyCollectViewController
- (NSArray *)collectedArr
{
    if (!_collectedArr) {
        _collectedArr = [NSArray arrayWithArray:[NSArray getHangxian]];
    }
    return _collectedArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self orientationToPortrait:UIInterfaceOrientationLandscapeRight];
}
//强制旋转屏幕
//- (void)orientationToPortrait:(UIInterfaceOrientation)orientation {
//    SEL selector = NSSelectorFromString(@"setOrientation:");
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//    [invocation setSelector:selector];
//    [invocation setTarget:[UIDevice currentDevice]];
//    int val = orientation;
//    [invocation setArgument:&val atIndex:2];//前两个参数已被target和selector占用
//    [invocation invoke];
//}
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UITableViewDataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.collectedArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.collectedArr[indexPath.row][@"name"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_collectedAction) {
        _collectedAction(self.collectedArr[indexPath.row]);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
