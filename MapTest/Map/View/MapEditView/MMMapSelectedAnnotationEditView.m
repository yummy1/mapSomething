//
//  MMMapSelectedAnnotationView.m
//  MapTest
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMMapSelectedAnnotationEditView.h"


@interface MMMapSelectedAnnotationEditView()
/** tittle */
@property (nonatomic,strong) UILabel *tittleLabel;
/** 分割 */
@property (nonatomic,strong) UIView *fenge;
/** 详细信息 */
@property (nonatomic,strong) UILabel *detailLabel;
/** 经纬度 */
@property (nonatomic,strong) UILabel *jwLabel;
/** 删除 */
@property (nonatomic,strong) UIButton *deleteBtn;
@end
@implementation MMMapSelectedAnnotationEditView

- (void)setSelectedArr:(NSMutableArray *)selectedArr
{
    _selectedArr = selectedArr;
    if (selectedArr.count == 1) {
        MMAnnotation *model = selectedArr[0];
        _tittleLabel.text = [NSString stringWithFormat:@"%@%@%ld",Localized(@"EditSelected"),Localized(@"EditPoints"),(long)model.index];
        if ([MMMapManager manager].mapFunction == MAP_pointTypeRegionalRoute) {
            _detailLabel.text = [NSString stringWithFormat:@"%@%@%@  %@%@%@",Localized(@"AroundHeight"),model.parameter.FK_height,Localized(@"AroundMeter"),Localized(@"AroundSpeed"),model.parameter.FK_speed,Localized(@"AroundMeter/sec")];
        }else{
            _detailLabel.text = [NSString stringWithFormat:@"%@%@%@  %@%@%@  %@%@%@  %@%@° | %@%@%@",Localized(@"AroundHeight"),model.parameter.FK_height,Localized(@"AroundMeter"),Localized(@"AroundSpeed"),model.parameter.FK_speed,Localized(@"AroundMeter/sec"),Localized(@"EditResidenceTime"),model.parameter.FK_standingTime,Localized(@"EditSec"),Localized(@"EditNoseOrientation"),model.parameter.FK_headOrientation,Localized(@"EditHoveringRadius"),model.parameter.FK_hoveringRadius,Localized(@"AroundMeter")];
        }
        _jwLabel.text = [NSString stringWithFormat:@"%@：%.7f   %@：%.7f",Localized(@"MineJingdu"),model.coordinate.longitude,Localized(@"MineWeidu"),model.coordinate.latitude];
    }else{
        _tittleLabel.text = [NSString stringWithFormat:@"%@%ld%@",Localized(@"EditSelected"),(long)selectedArr.count,Localized(@"EditPoints")];
        _jwLabel.text = @"";
        NSMutableString *detail = [NSMutableString string];
        //需要计较所有的选中的点这些参数是否一样，如果一样显示出来，不一样不显示
        [selectedArr enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            __block BOOL isSameHeight = YES;
            __block BOOL isSameSpeed = YES;
            __block BOOL isSameStandingTime = YES;
            __block BOOL isSameHeadOrientation = YES;
            __block BOOL isSameHoveringRadius = YES;
            __block BOOL isSameCircleNumber = YES;
            [selectedArr enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                if (![obj.parameter.FK_height isEqualToString:obj1.parameter.FK_height]) {
                    isSameHeight = NO;
                }
                if (![obj.parameter.FK_speed isEqualToString:obj1.parameter.FK_speed]) {
                    isSameSpeed = NO;
                }
                if (![obj.parameter.FK_standingTime isEqualToString:obj1.parameter.FK_standingTime]) {
                    isSameStandingTime = NO;
                }
                if (![obj.parameter.FK_headOrientation isEqualToString:obj1.parameter.FK_headOrientation]) {
                    isSameHeadOrientation = NO;
                }
                if (![obj.parameter.FK_hoveringRadius isEqualToString:obj1.parameter.FK_hoveringRadius]) {
                    isSameHoveringRadius = NO;
                }
                if (![obj.parameter.FK_circleNumber isEqualToString:obj1.parameter.FK_circleNumber]) {
                    isSameCircleNumber = NO;
                }
            }];
            if (idx == selectedArr.count-1) {
                if (isSameHeight) {
                    [detail appendFormat:@"%@%@%@",Localized(@"AroundHeight"),obj.parameter.FK_height,Localized(@"AroundMeter")];
                }
                if (isSameSpeed) {
                    [detail appendFormat:@"  %@%@%@",Localized(@"AroundSpeed"),obj.parameter.FK_speed,Localized(@"AroundMeter/sec")];
                }
                if (isSameStandingTime) {
                    [detail appendFormat:@"  %@%@%@",Localized(@"EditResidenceTime"),obj.parameter.FK_standingTime,Localized(@"EditSec")];
                }
                if (isSameHeadOrientation) {
                    [detail appendFormat:@"  %@%@°",Localized(@"EditNoseOrientation"),obj.parameter.FK_headOrientation];
                }
                //                if (isSameHoveringRadius) {
                //                    [detail appendFormat:@"  悬停半径%@米",obj.FK_hoveringRadius];
                //                }
                //                if (isSameCircleNumber) {
                //                    [detail appendFormat:@"  圈数%@圈",obj.FK_circleNumber];
                //                }
                _detailLabel.text = detail;
            }
        }];
        
    }
}
- (void)deleteAction
{
    if ([_delegate respondsToSelector:@selector(deleteOnMMMapSelectedAnnotationEditView:)]) {
        [_delegate deleteOnMMMapSelectedAnnotationEditView:self];
    }
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    /** tittle */
    _tittleLabel = [[UILabel alloc] init];
    _tittleLabel.text = @"选中航点1";
    _tittleLabel.textColor = ThemeBlueColor;
    [self addSubview:_tittleLabel];
    /** 分割 */
    _fenge = [[UIView alloc] init];
    _fenge.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:_fenge];
    /** 详细信息 */
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.text = @"高度20米  速度5米/秒  停留时间0秒  机头朝向0  悬停半径10米  圈数1圈";
    _detailLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:_detailLabel];
    /** 经纬度 */
    _jwLabel = [[UILabel alloc] init];
    _jwLabel.text = @"经度：113.456778   纬度：22.567890";
    _jwLabel.textColor = [UIColor darkTextColor];
    _jwLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:_jwLabel];
    /** 删除 */
    _deleteBtn = [[UIButton alloc] init];
    [_deleteBtn setImage:[UIImage imageNamed:@"map_14"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_deleteBtn];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    /** tittle */
    [_tittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).with.offset(5);
    }];
    /** 分割 */
    [_fenge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(_tittleLabel.mas_bottom).with.offset(5);
        make.height.mas_equalTo(0.5);
    }];
    /** 详细信息 */
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_tittleLabel);
        make.top.mas_equalTo(_fenge.mas_bottom).with.offset(5);
    }];
    /** 经纬度 */
    [_jwLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_tittleLabel);
        make.top.mas_equalTo(_detailLabel.mas_bottom).with.offset(5);
    }];
    /** 删除 */
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).with.offset(-5);
        make.top.mas_equalTo(self).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

@end
