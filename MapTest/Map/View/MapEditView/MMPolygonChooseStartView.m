//
//  MMPolygonChooseStartView.m
//  MapTest
//
//  Created by mac on 2019/9/26.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMPolygonChooseStartView.h"

@interface MMPolygonChooseStartView()
/** tittle */
@property (nonatomic,strong) UILabel *tittleLabel;
/** 分割 */
@property (nonatomic,strong) UIView *fenge;
/** 1 */
@property (nonatomic,strong) UIButton *oneBtn;
/** 2 */
@property (nonatomic,strong) UIButton *twoBtn;

@end
@implementation MMPolygonChooseStartView
- (void)setDefault
{
    [_oneBtn setBackgroundColor:ThemeColor];
    [_oneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_twoBtn setBackgroundColor:[UIColor whiteColor]];
    [_twoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
- (void)clickButton:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(selectedOnMMPolygonChooseStartView:index:)]) {
        [_delegate selectedOnMMPolygonChooseStartView:self index:button.tag];
    }
    if (button == _oneBtn) {
        [_oneBtn setBackgroundColor:ThemeColor];
        [_oneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_twoBtn setBackgroundColor:[UIColor whiteColor]];
        [_twoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [_twoBtn setBackgroundColor:ThemeColor];
        [_twoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_oneBtn setBackgroundColor:[UIColor whiteColor]];
        [_oneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    
    
    _tittleLabel = [[UILabel alloc] init];
    _tittleLabel.text = Localized(@"EditChooseTheStartingPoint");
    _tittleLabel.font = [UIFont systemFontOfSize:15];
    _tittleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_tittleLabel];
    
    _fenge = [[UIView alloc] init];
    _fenge.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_fenge];
    
    _oneBtn = [[UIButton alloc] init];
    _oneBtn.tag = 1;
    [_oneBtn setTitle:@"1" forState:UIControlStateNormal];
    [_oneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_oneBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_oneBtn setBackgroundColor:ThemeColor];
    [_oneBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    _oneBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _oneBtn.layer.borderWidth = 0.5;
    _oneBtn.layer.cornerRadius = 6;
    _oneBtn.clipsToBounds = YES;
    [self addSubview:_oneBtn];
    
    _twoBtn = [[UIButton alloc] init];
    _twoBtn.tag = 2;
    [_twoBtn setTitle:@"2" forState:UIControlStateNormal];
    [_twoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_twoBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_twoBtn setBackgroundColor:[UIColor whiteColor]];
    [_twoBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    _twoBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _twoBtn.layer.borderWidth = 0.5;
    _twoBtn.layer.cornerRadius = 6;
    _twoBtn.clipsToBounds = YES;
    [self addSubview:_twoBtn];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_tittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    [_fenge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(_tittleLabel.mas_bottom);
    }];
    
    [_oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(12);
        make.top.mas_equalTo(_fenge.mas_bottom).with.offset(4);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [_twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).with.offset(-12);
        make.top.mas_equalTo(_fenge.mas_bottom).with.offset(4);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
}


@end
