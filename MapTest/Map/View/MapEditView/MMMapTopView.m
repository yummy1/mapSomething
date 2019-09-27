//
//  MMMapTopView.m
//  MapTest
//
//  Created by mac on 2019/9/17.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMMapTopView.h"
@interface MMMapTopView()
/** 我的位置 */
@property (nonatomic,strong) UIButton *myLocationBtn;
/** 无人机位置 */
@property (nonatomic,strong) UIButton *flyLocationBtn;
/** 指南针 */
@property (nonatomic,strong) UIButton *compassBtn;
/** 卫星图层还是地图层 */
@property (nonatomic,strong) UIButton *coverageBtn;
/** 谷歌和高德切换 */
@property (nonatomic,strong) UIButton *mapChangeBtn;
@property (nonatomic,assign) BOOL isChina;
@end
@implementation MMMapTopView

- (void)buttonClick:(UIButton *)button
{
    if (_setInedx) {
        _setInedx((MAP_function)button.tag);
    }
    //    if (button.tag == 4) {
    //        if (_isChina) {
    //            _isChina = NO;
    //            [_mapChangeBtn setBackgroundImage:[UIImage imageNamed:@"map_42"] forState:UIControlStateNormal];
    //        }else{
    //            _isChina = YES;
    //            [_mapChangeBtn setBackgroundImage:[UIImage imageNamed:@"map_4"] forState:UIControlStateNormal];
    //        }
    //    }
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
    /** 我的位置 */
    _myLocationBtn = [[UIButton alloc] init];
    _myLocationBtn.tag = 1;
    [_myLocationBtn setBackgroundImage:[UIImage imageNamed:@"map_1"] forState:UIControlStateNormal];
    [_myLocationBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_myLocationBtn];
    /** 无人机的位置 */
    _flyLocationBtn = [[UIButton alloc] init];
    _flyLocationBtn.tag = 5;
    [_flyLocationBtn setBackgroundImage:[UIImage imageNamed:@"map_8"] forState:UIControlStateNormal];
    [_flyLocationBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_flyLocationBtn];
    //    /** 指南针 */
    //    _compassBtn = [[UIButton alloc] init];
    //    _compassBtn.tag = 2;
    //    [_compassBtn setBackgroundImage:[UIImage imageNamed:@"map_2"] forState:UIControlStateNormal];
    //    [_compassBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [self addSubview:_compassBtn];
    //    /** 卫星图层还是地图层 */
    //    _coverageBtn = [[UIButton alloc] init];
    //    _coverageBtn.tag = 3;
    //    [_coverageBtn setBackgroundImage:[UIImage imageNamed:@"map_3"] forState:UIControlStateNormal];
    //    [_coverageBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [self addSubview:_coverageBtn];
    //    /** 谷歌和高德切换 */
    //    _mapChangeBtn = [[UIButton alloc] init];
    //    _mapChangeBtn.tag = 4;
    //    [_mapChangeBtn setBackgroundImage:[UIImage imageNamed:@"map_4"] forState:UIControlStateNormal];
    //    [_mapChangeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [self addSubview:_mapChangeBtn];
    _isChina = YES;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    /** 我的位置 */
    
    /** 指南针 */
    
    /** 卫星图层还是地图层 */
    
    /** 谷歌和高德切换 */
    /**
     *  确定间距等间距布局
     *
     *  @param axisType     布局方向
     *  @param fixedSpacing 两个item之间的间距(最左面的item和左边, 最右边item和右边都不是这个)
     *  @param leadSpacing  第一个item到父视图边距
     *  @param tailSpacing  最后一个item到父视图边距
     */
    //    [@[_myLocationBtn,_compassBtn,_coverageBtn,_mapChangeBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:40 tailSpacing:40];
    //    [@[_myLocationBtn,_compassBtn,_coverageBtn,_mapChangeBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(self).with.offset(10);
    //        make.bottom.mas_equalTo(self).with.offset(-10);
    //    }];
    [@[_myLocationBtn,_flyLocationBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:40 tailSpacing:40];
    [@[_myLocationBtn,_flyLocationBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).with.offset(10);
        make.bottom.mas_equalTo(self).with.offset(-10);
    }];
}

@end
