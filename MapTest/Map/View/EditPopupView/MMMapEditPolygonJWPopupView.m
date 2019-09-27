//
//  MMMapEditPolygonJWView.m
//  MapTest
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMMapEditPolygonJWPopupView.h"

@interface MMMapEditPolygonJWPopupView()
/** 经度 */
@property (weak, nonatomic) IBOutlet UILabel *latTittle;
@property (weak, nonatomic) IBOutlet UITextField *latTextField;
/** 纬度 */
@property (weak, nonatomic) IBOutlet UILabel *logTittle;
@property (weak, nonatomic) IBOutlet UITextField *logTextField;
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
    _latTittle.text = Localized(@"MineWeidu");
    _logTittle.text = Localized(@"MineJingdu");
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



@end
