//
//  MMSingleTapAnnotationView.m
//  MapTest
//
//  Created by mac on 2019/9/12.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMSingleTapAnnotationView.h"


#define kCalloutWidth      280.0
#define kCalloutHeight      80.0

@interface  MMSingleTapAnnotationView()<MMSingleTapIconViewDelegate>


@end
@implementation MMSingleTapAnnotationView
//复写父类init方法
- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])
    {
        //创建大头针视图
        [self setUpClloutView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建大头针视图
        [self setUpClloutView];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    if (selected)
    {
        [self setUpClloutView];
    }else
    {
    }
    [super setSelected:selected animated:animated];
}

- (void)setUpClloutView {
    if (self.calloutView == nil)
    {
        self.calloutView = [[MMSingleTapIconView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
        self.calloutView.delegate=self;
        [self addSubview:self.calloutView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    /*坐标不合适再此设置即可*/
    //Code ...
    self.calloutView.frame = CGRectMake(-(kCalloutWidth-self.frame.size.width)*0.5, -kCalloutHeight, kCalloutWidth, kCalloutHeight);
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint tempoint = [self.calloutView.goBtn convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.calloutView.goBtn.bounds, tempoint))
        {
            view = self.calloutView.goBtn;
        }
        
        CGPoint tempoint2 = [self.calloutView.editBtn convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.calloutView.editBtn.bounds, tempoint2))
        {
            view = self.calloutView.editBtn;
        }
    }
    return view;
}
#pragma mark - MMSingleTapIconViewDelegate
- (void)MMSingleTapIconViewClickEdit:(MMSingleTapIconView *)iconView
{
    if ([_delegate respondsToSelector:@selector(MMSingleTapAnnotationViewSingleTapEdit:)]) {
        [_delegate MMSingleTapAnnotationViewSingleTapEdit:self];
    }
}

- (void)MMSingleTapIconViewClickGo:(MMSingleTapIconView *)iconView
{
    if ([_delegate respondsToSelector:@selector(MMSingleTapAnnotationViewSingleTapGo:)]) {
        [_delegate MMSingleTapAnnotationViewSingleTapGo:self];
    }
}


@end
