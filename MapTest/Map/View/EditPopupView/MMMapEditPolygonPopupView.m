//
//  MMMapEditPolygonView.m
//  MapTest
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMMapEditPolygonPopupView.h"

@interface MMMapEditPolygonPopupView ()<UITextFieldDelegate>
//生成规则
@property (weak, nonatomic) IBOutlet UILabel *regulationTittle;
@property (weak, nonatomic) IBOutlet UITextField *regulationTextField;
//航点间距
@property (weak, nonatomic) IBOutlet UILabel *spacingTittle;
@property (weak, nonatomic) IBOutlet UITextField *spacingTextField;
//飞行速度
@property (weak, nonatomic) IBOutlet UILabel *speedTittle;
@property (weak, nonatomic) IBOutlet UITextField *speedTextField;
//飞行高度
@property (weak, nonatomic) IBOutlet UILabel *heightTittle;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end
@implementation MMMapEditPolygonPopupView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    _sureBtn.layer.cornerRadius = 3;
    _sureBtn.clipsToBounds = YES;
    _cancelBtn.layer.cornerRadius = 3;
    _cancelBtn.clipsToBounds = YES;
    
//    _regulationTittle.text = Localized(@"EditGeneratingRule");
//    _spacingTittle.text = Localized(@"EditWaypointSpacing");
//    _speedTittle.text = Localized(@"EditFlightSpeed");
//    _heightTittle.text = Localized(@"EditFlightAltitude");
//    
//    _regulationTextField.placeholder = Localized(@"EditDefault");
//    _spacingTextField.placeholder = [NSString stringWithFormat:@"20%@",Localized(@"AroundMeter")];
//    _speedTextField.placeholder = [NSString stringWithFormat:@"5%@",Localized(@"AroundMeter/sec")];
//    _heightTextField.placeholder = [NSString stringWithFormat:@"10%@",Localized(@"AroundMeter")];
}
- (IBAction)backAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(cancelOnMMMapEditPolygonPopupView:)]) {
        [_delegate cancelOnMMMapEditPolygonPopupView:self];
    }
}

- (IBAction)sureAction:(UIButton *)sender {
    BOOL height = [self validationRange:_heightTextField.text sim:10 max:500];
    BOOL speed = [self validationRange:_speedTextField.text sim:2 max:10];
    BOOL spacing = [self validationRange:_spacingTextField.text sim:1 max:100];
    if (!(height && speed && spacing)) {
        [SVProgressHUD showInfoWithStatus:Localized(@"EditEnterReasonableRange")];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    if ([_delegate respondsToSelector:@selector(editEndOnMMMapEditPolygonPopupView:regulation:spacing:speed:height:)]) {
        NSInteger regulation = 1;//默认
        NSInteger spacing = 30;
        NSString *speed = @"5";
        NSString *height = @"10";
        if (![_spacingTextField.text isEqualToString:@""] && _spacingTextField.text != nil) {
            spacing = [_spacingTextField.text integerValue];
        }
        if (![_speedTextField.text isEqualToString:@""] && _speedTextField.text != nil) {
            speed = _speedTextField.text;
        }
        if (![_heightTextField.text isEqualToString:@""] && _heightTextField.text != nil) {
            height = _heightTextField.text;
        }
        [_delegate editEndOnMMMapEditPolygonPopupView:self regulation:regulation spacing:spacing speed:speed height:height];
    }
}
- (BOOL)validationRange:(NSString *)text sim:(NSInteger)sim max:(NSInteger)max
{
    int willStr = [text intValue];
    if (abs(willStr) >= sim && abs(willStr) <= max) {
        return YES;
    }else{
        return NO;
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    int willStr = [[NSString stringWithFormat:@"%@%@",textField.text,string] intValue];
    DLog(@"===%d===",willStr);
    if (textField == _heightTextField){
        //10~500米
        if (abs(willStr) <= 500) {
            return YES;
        }else{
            return NO;
        }
    }else if (textField == _speedTextField){
        //2~10米/秒
        if (abs(willStr) <= 10) {
            return YES;
        }else{
            return NO;
        }
    }else if (textField == _spacingTextField){
        //1~100米
        if (abs(willStr) <= 100) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return YES;
    }
}


@end
