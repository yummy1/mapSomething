//
//  MMMapEditPolygonJWView.m
//  MapTest
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMMapEditPolygonJWPopupView.h"

@interface MMMapEditPolygonJWPopupView()<UITextFieldDelegate>
/** 经度 */
@property (weak, nonatomic) IBOutlet UILabel *latTittle;
@property (weak, nonatomic) IBOutlet UITextField *latTextField;
/** 纬度 */
@property (weak, nonatomic) IBOutlet UILabel *logTittle;
@property (weak, nonatomic) IBOutlet UITextField *logTextField;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end
@implementation MMMapEditPolygonJWPopupView
- (void)setModel:(MMAnnotation *)model
{
    _model = model;
    _latTextField.text = [NSString stringWithFormat:@"%.7f",model.coordinate.latitude];
    _logTextField.text = [NSString stringWithFormat:@"%.7f",model.coordinate.longitude];
}
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
    
//    _latTittle.text = Localized(@"MineWeidu");
//    _logTittle.text = Localized(@"MineJingdu");
}
- (IBAction)backAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(cancelOnMMMapEditPolygonJWView:)]) {
        [_delegate cancelOnMMMapEditPolygonJWView:self];
    }
}
- (IBAction)sureAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(editEndOnMMMapEditPolygonJWView:editModel:)]) {
        CLLocationCoordinate2D addCoordinate;
        addCoordinate.latitude = [_latTextField.text doubleValue];
        addCoordinate.longitude = [_logTextField.text doubleValue];
        _model.coordinate = addCoordinate;
        [_delegate editEndOnMMMapEditPolygonJWView:self editModel:_model];
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isNumberStr] || [string isEqualToString:@""] || [string isEqualToString:@"."]) {
        if ([string isEqualToString:@"."] && [textField.text containsString:@"."]) {
            return NO;
        }
        //还未输入小数点时
        if (![textField.text containsString:@"."] && [string isNumberStr]) {
            if (textField == _latTextField) {
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
}


@end
