//
//  MMSingleTapIconView.m
//  MapTest
//
//  Created by mac on 2019/9/12.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMSingleTapIconView.h"
#import "MMAnnotation.h"

@interface MMSingleTapIconView()
//左边
@property (nonatomic,strong) UIView *leftView;
//高度
@property (nonatomic,strong) UILabel *heightLabel;
//速度
@property (nonatomic,strong) UILabel *speedLabel;
//经纬度
@property (nonatomic,strong) UILabel *jwLabel;
//上边
@property (nonatomic,strong) UIView *topView;
//下边
@property (nonatomic,strong) UIView *bottom;
@property (nonatomic,strong) UIImageView *btIcon;
@end
@implementation MMSingleTapIconView

- (void)setModel:(MMAnnotation *)model
{
    _model = model;
    self.heightLabel.text = [NSString stringWithFormat:@"%@%@%@",Localized(@"AroundHeight"),model.parameter.FK_height,Localized(@"AroundMeter")];
    self.speedLabel.text = [NSString stringWithFormat:@"%@%@%@",Localized(@"AroundSpeed"),model.parameter.FK_speed,Localized(@"AroundMeter/sec")];
    self.jwLabel.text = [NSString stringWithFormat:@"%@：%f   %@：%f",Localized(@"MineJingdu"),model.coordinate.longitude,Localized(@"MineWeidu"),model.coordinate.latitude];
}
- (void)goAction
{
    DLog(@"去");
    if ([_delegate respondsToSelector:@selector(MMSingleTapIconViewClickGo:)]) {
        [_delegate MMSingleTapIconViewClickGo:self];
    }
}
- (void)editAction
{
    DLog(@"编辑");
    if ([_delegate respondsToSelector:@selector(MMSingleTapIconViewClickEdit:)]) {
        [_delegate MMSingleTapIconViewClickEdit:self];
    }
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint tempoint = [self.goBtn convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.goBtn.bounds, tempoint))
        {
            view = self.goBtn;
        }
        
        CGPoint tempoint2 = [self.editBtn convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.editBtn.bounds, tempoint2))
        {
            view = self.editBtn;
        }
    }
    return view;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{
    //上边
    _topView = [[UIView alloc] init];
    _topView.layer.cornerRadius = 5;
    _topView.clipsToBounds = YES;
    _topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topView];
    //左边
    _leftView = [[UIView alloc] init];
    _leftView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"map_markbg"]];
    [_topView addSubview:_leftView];
    //高度
    _heightLabel = [[UILabel alloc] init];
    _heightLabel.text = @"高度20米";
    _heightLabel.font = [UIFont systemFontOfSize:14];
    [_leftView addSubview:_heightLabel];
    //速度
    _speedLabel = [[UILabel alloc] init];
    _speedLabel.text = @"速度5米/秒";
    _speedLabel.font = [UIFont systemFontOfSize:14];
    [_leftView addSubview:_speedLabel];
    //经纬度
    _jwLabel = [[UILabel alloc] init];
    _jwLabel.text = @"经度：113.3456789   纬度：34.3456789";
    _jwLabel.textColor = [UIColor darkGrayColor];
    _jwLabel.font = [UIFont systemFontOfSize:12];
    [_leftView addSubview:_jwLabel];
    //编辑
    _editBtn = [[UIButton alloc] init];
    [_editBtn setImage:[UIImage imageNamed:@"map_edit"] forState:UIControlStateNormal];
    [_editBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    [_leftView addSubview:_editBtn];
    //go按钮
    _goBtn = [[UIButton alloc] init];
    [_goBtn setBackgroundColor:ThemeColor];
    [_goBtn setTitle:@"GO" forState:UIControlStateNormal];
    [_goBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_goBtn addTarget:self action:@selector(goAction) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_goBtn];
    //下边
    _bottom = [[UIView alloc] init];
    [self addSubview:_bottom];
    _btIcon = [[UIImageView alloc] init];
    _btIcon.image = [UIImage imageNamed:@"location_blue"];
    [_bottom addSubview:_btIcon];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //上部
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).with.offset(-33);
    }];
    //左边
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(_topView);
        make.right.mas_equalTo(_topView).with.offset(-40);
    }];
    //高度
    [_heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(8);
    }];
    //速度
    [_speedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_heightLabel.mas_right).with.offset(12);
        make.top.mas_equalTo(_heightLabel);
    }];
    //经纬度
    [_jwLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_heightLabel.mas_bottom).with.offset(4);
        make.left.mas_equalTo(_heightLabel);
    }];
    //编辑
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_leftView).with.offset(-10);
        make.top.mas_equalTo(_topView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    //go按钮
    [_goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(_topView);
        make.left.mas_equalTo(_leftView.mas_right);
    }];
    //底部
    [_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(_topView.mas_bottom);
    }];
    [_btIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_bottom);
        //        make.size.mas_equalTo(CGSizeMake(23, 28));
        make.size.mas_equalTo(CGSizeMake(21.5, 32.5));
    }];
}

@end
