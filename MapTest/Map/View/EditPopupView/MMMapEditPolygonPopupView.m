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
    _regulationTittle.text = Localized(@"EditGeneratingRule");
    _spacingTittle.text = Localized(@"EditWaypointSpacing");
    _speedTittle.text = Localized(@"EditFlightSpeed");
    _heightTittle.text = Localized(@"EditFlightAltitude");
    
    _regulationTextField.placeholder = Localized(@"EditDefault");
    _spacingTextField.placeholder = [NSString stringWithFormat:@"20%@",Localized(@"AroundMeter")];
    _speedTextField.placeholder = [NSString stringWithFormat:@"5%@",Localized(@"AroundMeter/sec")];
    _heightTextField.placeholder = [NSString stringWithFormat:@"10%@",Localized(@"AroundMeter")];
}
- (IBAction)backAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(cancelOnMMMapEditPolygonPopupView:)]) {
        [_delegate cancelOnMMMapEditPolygonPopupView:self];
    }
}

- (IBAction)sureAction:(UIButton *)sender {
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isNumberStr] || [string isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
}


@end
