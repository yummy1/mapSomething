//
//  MMMapEditSingleTapPopupView.m
//  MapTest
//
//  Created by mac on 2019/10/29.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMMapEditSingleTapPopupView.h"


@interface MMMapEditSingleTapPopupView()
/** 高度 */
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
/** 速度 */
@property (weak, nonatomic) IBOutlet UITextField *speedTextField;
/** 纬度 */
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
/** 经度 */
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@end
@implementation MMMapEditSingleTapPopupView
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}
- (void)setModel:(MMAnnotation *)model
{
    _model = model;
    if (_model == nil) {
        _model = [[MMAnnotation alloc] init];
        _latitudeTextField.text = @"不可编辑";
        _longitudeTextField.text = @"不可编辑";
        _latitudeTextField.enabled = NO;
        _longitudeTextField.enabled = NO;
    }else{
        _latitudeTextField.text = [NSString stringWithFormat:@"%.7f",model.coordinate.latitude];
        _longitudeTextField.text = [NSString stringWithFormat:@"%.7f",model.coordinate.longitude];
        _latitudeTextField.enabled = YES;
        _longitudeTextField.enabled = YES;
    }
    _heightTextField.text = _model.parameter.FK_height;
    _speedTextField.text = _model.parameter.FK_speed;
    
}
- (void)setupUI {
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    
    _sureBtn.layer.cornerRadius = 3;
    _sureBtn.clipsToBounds = YES;
    _cancelBtn.layer.cornerRadius = 3;
    _cancelBtn.clipsToBounds = YES;
    //中英文

}
- (IBAction)backAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(cancelOnMMMapEditSingleTapPopupView:)]) {
        [_delegate cancelOnMMMapEditSingleTapPopupView:self];
    }
}
- (IBAction)saveAction:(UIButton *)sender {
    BOOL height = [self validationRange:_heightTextField.text sim:10 max:500];
    BOOL speed = [self validationRange:_speedTextField.text sim:2 max:10];
    if (!(height && speed)) {
        [SVProgressHUD showInfoWithStatus:Localized(@"EditEnterReasonableRange")];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    _model.parameter.FK_height = _heightTextField.text;
    _model.parameter.FK_speed = _speedTextField.text;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([_latitudeTextField.text doubleValue], [_longitudeTextField.text doubleValue]);
    _model.coordinate = coordinate;
    if ([_delegate respondsToSelector:@selector(editEndOnMMMapEditSingleTapPopupView:editModel:)]) {
        [_delegate editEndOnMMMapEditSingleTapPopupView:self editModel:self.model];
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
    
    if (textField == _latitudeTextField || textField == _longitudeTextField) {
        if ([string isNumberStr] || [string isEqualToString:@""] || [string isEqualToString:@"."]) {
            if ([string isEqualToString:@"."] && [textField.text containsString:@"."]) {
                return NO;
            }
            //还未输入小数点时
            if (![textField.text containsString:@"."] && [string isNumberStr]) {
                if (textField == _latitudeTextField) {
                    //纬度的话小数点前最多两位，并且绝对值小于90
                    if (textField.text.length == 2) {
                        return NO;
                    }
                    int willStr = [[NSString stringWithFormat:@"%@%@",textField.text,string] intValue];
                    if (abs(willStr) > 89) {
                        return NO;
                    }
                }else{
                    //纬度的话小数点前最多三位，并且绝对值小于180
                    if (textField.text.length == 3) {
                        return NO;
                    }
                    int willStr = [[NSString stringWithFormat:@"%@%@",textField.text,string] intValue];
                    if (abs(willStr) > 179) {
                        return NO;
                    }
                }
            }
            return YES;
        }else{
            return NO;
        }
    }else if (textField == _heightTextField){
        //10~500米
        int willStr = [[NSString stringWithFormat:@"%@%@",textField.text,string] intValue];
        if (abs(willStr) <= 500) {
            return YES;
        }else{
            return NO;
        }
    }else if (textField == _speedTextField){
        //2~10米/秒
        int willStr = [[NSString stringWithFormat:@"%@%@",textField.text,string] intValue];
        if (abs(willStr) <= 10) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return YES;
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    int willStr = [textField.text intValue];
    if (textField == _heightTextField) {
        if (abs(willStr) < 10) {
            [SVProgressHUD showInfoWithStatus:Localized(@"EditEnterReasonableRange")];
            [SVProgressHUD dismissWithDelay:1.5];
            return NO;
        }
    }else if(textField == _speedTextField){
        if (abs(willStr) < 2) {
            [SVProgressHUD showInfoWithStatus:Localized(@"EditEnterReasonableRange")];
            [SVProgressHUD dismissWithDelay:1.5];
            return NO;
        }
    }
    return YES;
}

@end
