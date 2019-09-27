//
//  MMMapEditSingleAnnotationView.m
//  MapTest
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMMapEditAnnotationsPopupView.h"

@interface MMMapEditAnnotationsPopupView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** 高度 */
@property (weak, nonatomic) IBOutlet UILabel *heightTittle;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
/** 速度 */
@property (weak, nonatomic) IBOutlet UILabel *speedTittle;
@property (weak, nonatomic) IBOutlet UITextField *speedTextField;
/** 停留时间 */
@property (weak, nonatomic) IBOutlet UILabel *standingTimeTittle;
@property (weak, nonatomic) IBOutlet UITextField *standingTimeTextField;
/** 机头朝向 */
@property (weak, nonatomic) IBOutlet UILabel *orientationTittle;
@property (weak, nonatomic) IBOutlet UITextField *orientationTextField;
/** 纬度 */
@property (weak, nonatomic) IBOutlet UILabel *latitudeTittle;
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
/** 经度 */
@property (weak, nonatomic) IBOutlet UILabel *longitudeTittle;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;
//单位
@property (weak, nonatomic) IBOutlet UILabel *meter;
@property (weak, nonatomic) IBOutlet UILabel *meter_sec;
@property (weak, nonatomic) IBOutlet UILabel *sec;


///** 绕圈 */
//@property (weak, nonatomic) IBOutlet UILabel *windTittle;
//@property (weak, nonatomic) IBOutlet UITextField *windTextField;
///** 悬停半径 */
//@property (weak, nonatomic) IBOutlet UILabel *radiusTittle;
//@property (weak, nonatomic) IBOutlet UITextField *radiusTextField;
///** 圈数 */
//@property (weak, nonatomic) IBOutlet UILabel *cylinderNumberTittle;
//@property (weak, nonatomic) IBOutlet UITextField *cylinderNumberTextField;

@end
@implementation MMMapEditAnnotationsPopupView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
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
        _latitudeTextField.text = [NSString stringWithFormat:@"%.6f",model.coordinate.latitude];
        _longitudeTextField.text = [NSString stringWithFormat:@"%.6f",model.coordinate.longitude];
    }
    _heightTextField.text = _model.parameter.FK_height;
    _speedTextField.text = _model.parameter.FK_speed;
    _standingTimeTextField.text = _model.parameter.FK_standingTime;
    _orientationTextField.text = _model.parameter.FK_headOrientation;
    
}
- (void)setupUI {
    //中英文
    _heightTittle.text = Localized(@"AroundHeight");
    _speedTittle.text = Localized(@"AroundSpeed");
    _standingTimeTittle.text = Localized(@"EditResidenceTime");
    _orientationTittle.text = Localized(@"EditNoseOrientation");
    _latitudeTittle.text = Localized(@"MineWeidu");
    _longitudeTittle.text = Localized(@"MineJingdu");
    _meter.text = Localized(@"AroundMeter");
    _meter_sec.text = Localized(@"AroundMeter/sec");
    _sec.text = Localized(@"EditSec");
}
- (IBAction)backAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(cancelOnMMMapEditAnnotationsPopupView:)]) {
        [_delegate cancelOnMMMapEditAnnotationsPopupView:self];
    }
}
- (IBAction)saveAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(editEndOnMMMapEditAnnotationsPopupView:editModel:)]) {
        CLLocationCoordinate2D addCoordinate;
        addCoordinate.latitude = [self.latitudeTextField.text doubleValue];
        addCoordinate.longitude = [self.longitudeTextField.text doubleValue];
        self.model.coordinate = addCoordinate;
        [_delegate editEndOnMMMapEditAnnotationsPopupView:self editModel:self.model];
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
    }else{
        if ([string isNumberStr] || [string isEqualToString:@""]) {
            return YES;
        }else{
            return NO;
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _heightTextField) {
        _model.parameter.FK_height = _heightTextField.text;
    }else if (textField == _speedTextField){
        _model.parameter.FK_speed = _speedTextField.text;
    }else if (textField == _standingTimeTextField){
        _model.parameter.FK_standingTime = _standingTimeTextField.text;
    }else if (textField == _orientationTextField){
        _model.parameter.FK_headOrientation = _orientationTextField.text;
    }
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([_latitudeTextField.text doubleValue], [_longitudeTextField.text doubleValue]);
    _model.coordinate = coordinate;
}

@end
