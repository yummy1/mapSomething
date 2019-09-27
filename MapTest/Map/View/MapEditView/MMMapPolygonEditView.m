//
//  MMMapPolygonEditView.m
//  MapTest
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMMapPolygonEditView.h"
@interface MMMapPolygonEditView()
/** 标记点的中点们 */
@property (nonatomic,strong) UIScrollView *scrollView;
//标记上次选中的点
@property (nonatomic,strong) NSMutableArray *buttonArr;
/** 收藏 */
@property (nonatomic,strong) UIButton *collectBtn;
/** 编辑 */
@property (nonatomic,strong) UIButton *replanningBtn;
/** 对 */
@property (nonatomic,strong) UIButton *duiBtn;
/** 错 */
@property (nonatomic,strong) UIButton *cuoBtn;
/**根据优先级修改x*/
@property(nonatomic, assign)NSInteger scale;

@property (nonatomic,assign) BOOL isShow;
@end
@implementation MMMapPolygonEditView
- (NSMutableArray *)buttonArr
{
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}
- (void)setMiddleArr:(NSArray *)middleArr
{
    _middleArr = middleArr;
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.buttonArr removeAllObjects];
    if (middleArr) {
        [self layoutMarks];
    }
}
- (void)layoutMarks
{
    [_middleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat Y = 20;
        CGFloat X = 25;
        CGFloat MarginX = 20;
        CGFloat w = 35;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(X+(MarginX+w)*idx, Y, w, w)];
        button.tag = idx;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self showLetterBtn:button idx:idx];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button addTarget:self action:@selector(clickSelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        button.layer.borderWidth = 2;
        button.layer.cornerRadius = 17.5;
        button.clipsToBounds = YES;
        if (idx == 0) {
            _selectedIndex = 0;
            [button setBackgroundColor:ThemeColor];
        }else{
            [button setBackgroundColor:ThemeBlueColor];
        }
        [self.buttonArr addObject:button];
        [self.scrollView addSubview:button];
        [self.scrollView setContentSize:CGSizeMake(X+(MarginX+w)*(idx+1), 70.5)];
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }];
}
- (UIButton *)showLetterBtn:(UIButton *)icon idx:(NSInteger)idx
{
    switch (idx) {
        case 0:
            [icon setTitle:@"A" forState:UIControlStateNormal];
            break;
        case 1:
            [icon setTitle:@"B" forState:UIControlStateNormal];
            break;
        case 2:
            [icon setTitle:@"C" forState:UIControlStateNormal];
            break;
        case 3:
            [icon setTitle:@"D" forState:UIControlStateNormal];
            break;
        case 4:
            [icon setTitle:@"E" forState:UIControlStateNormal];
            break;
        case 5:
            [icon setTitle:@"F" forState:UIControlStateNormal];
            break;
        case 6:
            [icon setTitle:@"G" forState:UIControlStateNormal];
            break;
        case 7:
            [icon setTitle:@"H" forState:UIControlStateNormal];
            break;
        case 8:
            [icon setTitle:@"I" forState:UIControlStateNormal];
            break;
        case 9:
            [icon setTitle:@"J" forState:UIControlStateNormal];
            break;
        case 10:
            [icon setTitle:@"K" forState:UIControlStateNormal];
            break;
        case 11:
            [icon setTitle:@"L" forState:UIControlStateNormal];
            break;
        case 12:
            [icon setTitle:@"M" forState:UIControlStateNormal];
            break;
        case 13:
            [icon setTitle:@"N" forState:UIControlStateNormal];
            break;
        case 14:
            [icon setTitle:@"O" forState:UIControlStateNormal];
            break;
        case 15:
            [icon setTitle:@"P" forState:UIControlStateNormal];
            break;
        case 16:
            [icon setTitle:@"Q" forState:UIControlStateNormal];
            break;
        case 17:
            [icon setTitle:@"R" forState:UIControlStateNormal];
            break;
        case 18:
            [icon setTitle:@"S" forState:UIControlStateNormal];
            break;
        case 19:
            [icon setTitle:@"T" forState:UIControlStateNormal];
            break;
        case 20:
            [icon setTitle:@"U" forState:UIControlStateNormal];
            break;
        case 21:
            [icon setTitle:@"V" forState:UIControlStateNormal];
            break;
        case 22:
            [icon setTitle:@"W" forState:UIControlStateNormal];
            break;
        case 23:
            [icon setTitle:@"X" forState:UIControlStateNormal];
            break;
        case 24:
            [icon setTitle:@"Y" forState:UIControlStateNormal];
            break;
        case 25:
            [icon setTitle:@"Z" forState:UIControlStateNormal];
            break;
        default:
        {
            [self showLetterBtn:icon idx:idx%26];
        }
            break;
    }
    return icon;
}
//区域来回航线
- (void)quyuRoundtripFlightPoint:(NSArray *)array
{
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.buttonArr removeAllObjects];
    if (array) {
        [self layoutLHMarks:array];
    }
}
//显示最后的来回飞行航点
- (void)layoutLHMarks:(NSArray *)array
{
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat Y = 10;
        CGFloat X = 25;
        CGFloat MarginX = 20;
        CGFloat w = 45;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(X+(MarginX+w)*idx, Y, w, w)];
        if (idx == 0) {
            [button setBackgroundImage:[UIImage imageNamed:@"map_location_red"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"map_location_red"] forState:UIControlStateSelected];
        }else{
            [button setBackgroundImage:[UIImage imageNamed:@"map_location_blue"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"map_location_yellow"] forState:UIControlStateSelected];
        }
        [button setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)idx+1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, 0)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:10 weight:UIFontWeightThin]];
        [button addTarget:self action:@selector(clickSelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 22.5;
        button.clipsToBounds = YES;
        [self.buttonArr addObject:button];
        [self.scrollView addSubview:button];
        [self.scrollView setContentSize:CGSizeMake(X+(MarginX+w)*(idx+1), 70.5)];
        if (idx > 4) {
            [_scrollView setContentOffset:CGPointMake(X+(MarginX+w)*(idx-4), 0) animated:NO];
        }
    }];
}
- (void)clickSelectedBtn:(UIButton *)button
{
    if (_type == 2) {
        return;
    }
    if ([_delegate respondsToSelector:@selector(selctedOnQuyuChooseView:index:)]) {
        [_delegate selctedOnQuyuChooseView:self index:button.tag];
        _selectedIndex = button.tag;
        //更改背景色
        [self.buttonArr enumerateObjectsUsingBlock:^(UIButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.tag == button.tag) {
                [obj setBackgroundColor:ThemeColor];
            }else{
                [obj setBackgroundColor:ThemeBlueColor];
            }
        }];
    }
}
- (void)showCollectAndReplaning:(BOOL)isShow
{
    self.scale += 1;
    _isShow = isShow;
    if (isShow) {
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).with.offset(90.5).with.priority(self.scale);
        }];
    }else{
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).with.priority(self.scale);
        }];
    }
    
    // 告诉self.view约束需要更新
    [self setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self updateConstraintsIfNeeded];
    //更新约束
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
    
    
}
- (void)updateConstraints
{
    if (_isShow) {
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).with.offset(90.5).with.priority(self.scale);
        }];
    }else{
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).with.priority(self.scale);
        }];
    }
    [super updateConstraints];
}
#pragma mark 区域航线确定或者取消按钮点击事件
- (void)clickDuiOrCuoAction:(UIButton *)button
{
    if (button.tag == 11) {
        //对
        if ([_delegate respondsToSelector:@selector(clickDuiOnQuyuChooseView:)]) {
            [_delegate clickDuiOnQuyuChooseView:self];
        }
    }else{
        //错
        if ([_delegate respondsToSelector:@selector(clickCuoOnQuyuChooseView:)]) {
            [_delegate clickCuoOnQuyuChooseView:self];
        }
    }
}
#pragma mark 收藏航线按钮点击事件
- (void)clickCollectAction
{
    if ([_delegate respondsToSelector:@selector(clickCollectOnQuyuChooseView:)]) {
        [_delegate clickCollectOnQuyuChooseView:self];
    }
}
#pragma mark 重新规划
- (void)clickReplanningAction
{
    if ([_delegate respondsToSelector:@selector(clickReplanningOnQuyuChooseView:)]) {
        [_delegate clickReplanningOnQuyuChooseView:self];
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
    self.scale = 1;
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    _collectBtn = [[UIButton alloc] init];
    _collectBtn.enabled = NO;
    [_collectBtn setImage:[UIImage imageNamed:@"map_15"] forState:UIControlStateNormal];
    [_collectBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [_collectBtn addTarget:self action:@selector(clickCollectAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_collectBtn];
    
    _replanningBtn = [[UIButton alloc] init];
    [_replanningBtn setTitle:@"重新规划" forState:UIControlStateNormal];
    [_replanningBtn setTitleColor:ThemeBlueColor forState:UIControlStateNormal];
    [_replanningBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_replanningBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [_replanningBtn addTarget:self action:@selector(clickReplanningAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_replanningBtn];
    
    _duiBtn = [[UIButton alloc] init];
    _duiBtn.tag = 11;
    [_duiBtn setImage:[UIImage imageNamed:@"map_17"] forState:UIControlStateNormal];
    [_duiBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [_duiBtn addTarget:self action:@selector(clickDuiOrCuoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_duiBtn];
    
    _cuoBtn = [[UIButton alloc] init];
    _cuoBtn.tag = 12;
    [_cuoBtn setImage:[UIImage imageNamed:@"map_12"] forState:UIControlStateNormal];
    [_cuoBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [_cuoBtn addTarget:self action:@selector(clickDuiOrCuoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cuoBtn];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:_scrollView];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(90, 35));
    }];
    [_replanningBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(90, 35));
    }];
    [_duiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(90, 35));
    }];
    [_cuoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(90, 35));
    }];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        //        make.left.mas_equalTo(_collectBtn.mas_right).with.offset(0.5);
        make.left.mas_equalTo(self).with.priority(self.scale);
        make.right.mas_equalTo(_duiBtn.mas_left).with.offset(-0.5);
    }];
}


@end
