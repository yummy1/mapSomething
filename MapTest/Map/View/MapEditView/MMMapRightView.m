//
//  MMMapRightView.m
//  MapTest
//
//  Created by mac on 2019/9/17.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMMapRightView.h"

@interface MMMapRightView()
/** 指点飞行 */
@property (nonatomic,strong) UIButton *zdfxBtn;
/** 航线规划 */
@property (nonatomic,strong) UIButton *hxghBtn;
/** 区域航线 */
@property (nonatomic,strong) UIButton *qyhxBtn;
/** 收藏航线 */
@property (nonatomic,strong) UIButton *schxBtn;
/** 选中者 */
@property (nonatomic,strong) UIButton *selectedBtn;
/** 隐藏时显示,显示时隐藏 */
@property (nonatomic,strong) UIButton *showBtn;
@end
@implementation MMMapRightView
- (void)defaultUI
{
    _zdfxBtn.selected = YES;
    _selectedBtn.selected = NO;
    _selectedBtn = _zdfxBtn;
}
- (void)clickBtn:(UIButton *)button
{
    if (button.tag != 4) {
        _selectedBtn.selected = NO;
        button.selected = YES;
        _selectedBtn = button;
    }
    
    if ([_delegate respondsToSelector:@selector(mapRightView:index:)]) {
        [_delegate mapRightView:self index:(MAP_pointType)button.tag];
    }
    _showBtn.hidden = NO;
    _zdfxBtn.hidden = YES;
    _hxghBtn.hidden = YES;
    _qyhxBtn.hidden = YES;
    _schxBtn.hidden = YES;
    
}
- (void)showAction:(UIButton *)button
{
    _showBtn.hidden = YES;
    _zdfxBtn.hidden = NO;
    _hxghBtn.hidden = NO;
    _qyhxBtn.hidden = NO;
    _schxBtn.hidden = NO;
    if ([_delegate respondsToSelector:@selector(mapRightView:index:)]) {
        [_delegate mapRightView:self index:(MAP_pointType)button.tag];
    }
}
- (void)setMapIndex:(MAP_pointType)mapIndex
{
    _mapIndex = mapIndex;
    if (mapIndex == MAP_pointTypeRoutePlanning) {
        _selectedBtn.selected = NO;
        _hxghBtn.selected = YES;
        _selectedBtn = _hxghBtn;
    }
    if (mapIndex == MAP_pointTypeRegionalRoute) {
        _selectedBtn.selected = NO;
        _qyhxBtn.selected = YES;
        _selectedBtn = _qyhxBtn;
    }
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
    self.backgroundColor = [UIColor clearColor];
    /** 指点飞行 */
    _zdfxBtn = [[UIButton alloc] init];
    _zdfxBtn.tag = 1;
    [_zdfxBtn setBackgroundImage:[UIImage imageNamed:@"map_right_11"] forState:UIControlStateNormal];
    [_zdfxBtn setTitle:@"指点飞行" forState:UIControlStateNormal];
    [_zdfxBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_zdfxBtn setBackgroundImage:[UIImage imageNamed:@"map_right_12"] forState:UIControlStateSelected];
    [_zdfxBtn setTitle:@"指点飞行" forState:UIControlStateSelected];
    [_zdfxBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_zdfxBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [_zdfxBtn setTitleEdgeInsets:UIEdgeInsetsMake(28, 0, 0, 0)];
    _zdfxBtn.selected = YES;
    _selectedBtn = _zdfxBtn;
    [_zdfxBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_zdfxBtn];
    /** 航线规划 */
    _hxghBtn = [[UIButton alloc] init];
    _hxghBtn.tag = 2;
    [_hxghBtn setBackgroundImage:[UIImage imageNamed:@"map_right_21"] forState:UIControlStateNormal];
    [_hxghBtn setTitle:@"航线规划" forState:UIControlStateNormal];
    [_hxghBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_hxghBtn setBackgroundImage:[UIImage imageNamed:@"map_right_22"] forState:UIControlStateSelected];
    [_hxghBtn setTitle:@"航线规划" forState:UIControlStateSelected];
    [_hxghBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_hxghBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [_hxghBtn setTitleEdgeInsets:UIEdgeInsetsMake(28, 0, 0, 0)];
    [_hxghBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_hxghBtn];
    /** 区域航线 */
    _qyhxBtn = [[UIButton alloc] init];
    _qyhxBtn.tag = 3;
    [_qyhxBtn setBackgroundImage:[UIImage imageNamed:@"map_right_31"] forState:UIControlStateNormal];
    [_qyhxBtn setTitle:@"区域航线" forState:UIControlStateNormal];
    [_qyhxBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_qyhxBtn setBackgroundImage:[UIImage imageNamed:@"map_right_32"] forState:UIControlStateSelected];
    [_qyhxBtn setTitle:@"区域航线" forState:UIControlStateSelected];
    [_qyhxBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_qyhxBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [_qyhxBtn setTitleEdgeInsets:UIEdgeInsetsMake(28, 0, 0, 0)];
    [_qyhxBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_qyhxBtn];
    /** 收藏航线 */
    _schxBtn = [[UIButton alloc] init];
    _schxBtn.tag = 4;
    [_schxBtn setBackgroundImage:[UIImage imageNamed:@"map_right_41"] forState:UIControlStateNormal];
    [_schxBtn setTitle:@"收藏航线" forState:UIControlStateNormal];
    [_schxBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_schxBtn setBackgroundImage:[UIImage imageNamed:@"map_right_42"] forState:UIControlStateSelected];
    [_schxBtn setTitle:@"收藏航线" forState:UIControlStateSelected];
    [_schxBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_schxBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [_schxBtn setTitleEdgeInsets:UIEdgeInsetsMake(28, 0, 0, 0)];
    [_schxBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_schxBtn];
    /** 隐藏时显示,显示时隐藏 */
    _showBtn = [[UIButton alloc] init];
    _showBtn.tag = 5;
    [_showBtn setBackgroundImage:[UIImage imageNamed:@"map_7"] forState:UIControlStateNormal];
    [_showBtn addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    _showBtn.hidden = YES;
    [self addSubview:_showBtn];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    /** 指点飞行 */
    
    /** 航线规划 */
    
    /** 区域航线 */
    
    /** 收藏航线 */
    /**
     *  确定间距等间距布局
     *
     *  @param axisType     布局方向
     *  @param fixedSpacing 两个item之间的间距(最左面的item和左边, 最右边item和右边都不是这个)
     *  @param leadSpacing  第一个item到父视图边距
     *  @param tailSpacing  最后一个item到父视图边距
     */
    [@[_zdfxBtn,_hxghBtn,_qyhxBtn,_schxBtn] mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0 leadSpacing:0 tailSpacing:30];
    [@[_zdfxBtn,_hxghBtn,_qyhxBtn,_schxBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
    }];
    
    [_showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20, 80));
    }];
}


@end
