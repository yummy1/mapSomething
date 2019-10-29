//
//  MMMapPolyLineEditView.m
//  MapTest
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMMapPolyLineEditView.h"

@interface MMMapPolyLineEditView()
/** 收藏 */
@property (nonatomic,strong) UIButton *collectBtn;
/** 编辑 */
@property (nonatomic,strong) UIButton *editBtn;
/** 标记点们 */
@property (nonatomic,strong) UIScrollView *scrollView;
/** 全选 */
@property (nonatomic,strong) UIButton *allBtn;
/** GO */
@property (nonatomic,strong) UIButton *goBtn;
/** 对 */
@property (nonatomic,strong) UIButton *duiBtn;
/** 错 */
@property (nonatomic,strong) UIButton *cuoBtn;
/** 记录先前选中的点 */
@property (nonatomic,strong) UIButton *beforeBtn;
@end
@implementation MMMapPolyLineEditView
- (NSMutableArray *)buttonArr
{
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}
- (void)setMarkArr:(NSMutableArray *)markArr
{
    _markArr = markArr;
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.buttonArr removeAllObjects];
    if (markArr.count != 0) {
        [self layoutMarks];
    }else{
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(25, 15, 35, 35)];
        [button setBackgroundImage:[UIImage imageNamed:@"map_16"] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [button addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        _allBtn.selected = NO;
    }
}
- (void)layoutMarks
{
    [_markArr enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat Y = 8;
        CGFloat X = 25;
        CGFloat MarginX = 20;
        CGFloat w = 50;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(X+(MarginX+w)*idx, Y, w, w)];
        button.tag = idx;
        if ([MMMapManager manager].mapFunction == MAP_pointTypeRoutePlanning) {
            //航线规划
            if (idx == 0) {
                [button setBackgroundImage:[UIImage imageNamed:@"map_location_red"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"map_location_red"] forState:UIControlStateSelected];
            }else{
                [button setBackgroundImage:[UIImage imageNamed:@"map_location_blue"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"map_location_yellow"] forState:UIControlStateSelected];
            }
        }else{
            //区域航线
            [button setBackgroundImage:[UIImage imageNamed:@"map_location_blue"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"map_location_yellow"] forState:UIControlStateSelected];
        }
        [button setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)idx+1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(-11, 0, 0, 0)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:10 weight:UIFontWeightThin]];
        [button addTarget:self action:@selector(clickSelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 25;
        button.clipsToBounds = YES;
        [self.buttonArr addObject:button];
        [self.scrollView addSubview:button];
        if (idx == [MMMapManager manager].annotations.count-1) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(X+(MarginX+w)*(idx+1), Y+5, w-10, w-10)];
            [button setBackgroundImage:[UIImage imageNamed:@"map_16"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:10]];
            [button addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:button];
            if (idx > 3) {
                [_scrollView setContentOffset:CGPointMake(X+(MarginX+w)*(idx+1)-self.scrollView.width+w, 0) animated:NO];
            }else{
                [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            }
        }
        [self.scrollView setContentSize:CGSizeMake(X+(MarginX+w)*(idx+2), 70.5)];
    }];
}
#pragma mark - 点击事件
#pragma mark 航点按钮点击事件
- (void)clickSelectedBtn:(UIButton *)button
{
    //2航线规划、3区域航线
    if ([MMMapManager manager].mapFunction == MAP_pointTypeRoutePlanning) {
        if (button.selected) {
            button.selected = NO;
            button.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            _allBtn.selected = NO;
        }else{
            button.selected = YES;
            button.layer.borderColor = [UIColor blackColor].CGColor;
        }
        MMAnnotation *annotation = [MMMapManager manager].annotations[button.tag];
        annotation.isSelected = button.selected;
        //所有选中点
        __block NSInteger index;
        __block NSMutableArray *selctedArr = [NSMutableArray array];
        [self.buttonArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.selected) {
                [selctedArr addObject:self.markArr[idx]];
                index = idx+1;
            }
        }];
        if ([_delegate respondsToSelector:@selector(selctedMarkOnMapDuodianEditView:selectedMarkArr:oneIndex:)]) {
            [_delegate selctedMarkOnMapDuodianEditView:self selectedMarkArr:selctedArr oneIndex:index];
        }
        //全选按钮是否呈现选中状态
        [self.buttonArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.selected == NO) {
                *stop = YES;
                return ;
            }
            if (idx == self.buttonArr.count-1) {
                _allBtn.selected = YES;
            }
        }];
    }else{
        if (button.selected) {
            //上次点击的按钮和这次点击的按钮是同一个按钮
            button.selected = NO;
            button.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            _beforeBtn = nil;
            if ([_delegate respondsToSelector:@selector(selctedMarkOnMapDuodianEditView:selectedMarkArr:oneIndex:)]) {
                [_delegate selctedMarkOnMapDuodianEditView:self selectedMarkArr:[NSArray array] oneIndex:0];
            }
        }else{
            //上次点击的按钮和这次点击的按钮不是同一个按钮
            button.selected = YES;
            button.layer.borderColor = [UIColor blackColor].CGColor;
            if (_beforeBtn) {
                _beforeBtn.selected = NO;
                _beforeBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            }
            _beforeBtn = button;
            //所有选中点
            __block NSInteger index;
            __block NSMutableArray *selctedArr = [NSMutableArray array];
            [self.buttonArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.selected) {
                    [selctedArr addObject:self.markArr[idx]];
                    index = idx+1;
                }
            }];
            if ([_delegate respondsToSelector:@selector(selctedMarkOnMapDuodianEditView:selectedMarkArr:oneIndex:)]) {
                [_delegate selctedMarkOnMapDuodianEditView:self selectedMarkArr:selctedArr oneIndex:index];
            }
        }
    }
}
#pragma mark 全选按钮点击事件
- (void)clickAllAction
{
    if (self.buttonArr.count == 0) {
        [SVProgressHUD showInfoWithStatus:@"请您先选择线路点"];
        return;
    }
    [self.buttonArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (_allBtn.selected) {
            obj.selected = NO;
            obj.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        }else{
            obj.selected = YES;
            obj.layer.borderColor = [UIColor blackColor].CGColor;
        }
    }];
    if (_allBtn.selected) {
        _allBtn.selected = NO;
        [[MMMapManager manager].annotations enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelected = NO;
        }];
    }else{
        _allBtn.selected = YES;
        [[MMMapManager manager].annotations enumerateObjectsUsingBlock:^(MMAnnotation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelected = YES;
        }];
    }
    if ([_delegate respondsToSelector:@selector(clickAllOnMapDuodianEditView:isYes:)]) {
        [_delegate clickAllOnMapDuodianEditView:self isYes:_allBtn.selected];
    }
}
#pragma mark 添加航点按钮点击事件
- (void)addAction
{
    if ([_delegate respondsToSelector:@selector(addHangdianOnMapDuodianEditView:)]) {
        [_delegate addHangdianOnMapDuodianEditView:self];
    }
}
#pragma mark go按钮点击事件
- (void)clickGoAction
{
    if ([_delegate respondsToSelector:@selector(clickGoOnMapDuodianEditView:)]) {
        [_delegate clickGoOnMapDuodianEditView:self];
    }
}
#pragma mark 区域航线确定或者取消按钮点击事件
- (void)clickDuiOrCuoAction:(UIButton *)button
{
    if (button.tag == 11) {
        if ([_delegate respondsToSelector:@selector(clickDuiOnMapDuodianEditView:)]) {
            [_delegate clickDuiOnMapDuodianEditView:self];
        }
    }else{
        if ([_delegate respondsToSelector:@selector(clickCuoOnMapDuodianEditView:)]) {
            [_delegate clickCuoOnMapDuodianEditView:self];
        }
    }
}
#pragma mark 收藏航线按钮点击事件
- (void)clickCollectAction
{
    if ([_delegate respondsToSelector:@selector(clickCollectOnMapDuodianEditView:)]) {
        [_delegate clickCollectOnMapDuodianEditView:self];
    }
}
#pragma mark 编辑航线按钮点击事件
- (void)clickEditAction
{
    if ([_delegate respondsToSelector:@selector(clickEditOnMapDuodianEditView:)]) {
        [_delegate clickEditOnMapDuodianEditView:self];
    }
}
#pragma mark - 布局
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
    self.backgroundColor = [UIColor lightGrayColor];
    _collectBtn = [[UIButton alloc] init];
    [_collectBtn setImage:[UIImage imageNamed:@"map_15"] forState:UIControlStateNormal];
    [_collectBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [_collectBtn addTarget:self action:@selector(clickCollectAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_collectBtn];
    
    _editBtn = [[UIButton alloc] init];
    [_editBtn setImage:[UIImage imageNamed:@"map_edit"] forState:UIControlStateNormal];
    [_editBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [_editBtn addTarget:self action:@selector(clickEditAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_editBtn];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:_scrollView];
    
    _allBtn = [[UIButton alloc] init];
    [_allBtn setImage:[UIImage imageNamed:@"map_13"] forState:UIControlStateNormal];
    [_allBtn setImage:[UIImage imageNamed:@"map_17"] forState:UIControlStateSelected];
    [_allBtn setTitle:Localized(@"EditAll") forState:UIControlStateNormal];
    [_allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_allBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [_allBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [_allBtn addTarget:self action:@selector(clickAllAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_allBtn];
    
    _goBtn = [[UIButton alloc] init];
    [_goBtn setTitle:@"GO" forState:UIControlStateNormal];
    [_goBtn setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateNormal];
    [_goBtn setBackgroundColor:ThemeColor];
    [_goBtn addTarget:self action:@selector(clickGoAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_goBtn];
    
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
    
}
- (void)setUpButton
{
    if ([MMMapManager manager].mapFunction == MAP_pointTypeRoutePlanning) {
        _allBtn.hidden = NO;
        _goBtn.hidden = NO;
        _duiBtn.hidden = YES;
        _cuoBtn.hidden = YES;
    }else{
        _allBtn.hidden = YES;
        _goBtn.hidden = YES;
        _duiBtn.hidden = NO;
        _cuoBtn.hidden = NO;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(90, 35));
    }];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(90, 35));
    }];
    [_allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(90, 35));
    }];
    [_goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self);
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
        make.left.mas_equalTo(_collectBtn.mas_right).with.offset(0.5);
        make.right.mas_equalTo(_allBtn.mas_left).with.offset(-0.5);
    }];
}


@end
