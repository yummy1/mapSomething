//
//  UIView+MMKit.h
//


// 用于直接修改继承自UIView的控件的x,y,width,height,size,origin,centerX,centerY等值，而不需要先获取frame在进行修改


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HDAnimationType)
{
    HDAnimationOpen,// 动画开启
    HDAnimationClose// 动画关闭
};

@interface UIView (MMKit)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

#pragma mark - 常用方法（移动及放大缩小、加边框、设置背景图片）
/** 移动到指定位置 */
- (void) moveBy: (CGPoint) delta;
/** 放大缩小 */
- (void) scaleBy: (CGFloat) scaleFactor;
/** 适应某一大小 */
- (void) fitInSize: (CGSize) aSize;
/**
 *  给UIView设置某种颜色的虚线边框，宽度1px
 *
 */
- (void)dashedBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;
/**
 *  创建有背景图片的view
 *
 *  @param image 背景图片
 *
 *  @return 返回view
 */
+ (UIView *)setBackgroundImage:(UIImage *)image size:(CGSize)size;
#pragma mark - 动画相关
/**
 *  在某个点添加动画
 *
 *  @param point 动画开始的点
 */
- (void)hd_addAnimationAtPoint:(CGPoint)point;

/**
 *  在某个点添加动画
 *
 *  @param point 动画开始的点
 *  @param type  动画的类型
 *  @param color 动画的颜色
 */
- (void)hd_addAnimationAtPoint:(CGPoint)point WithType:(HDAnimationType)type withColor:(UIColor *)animationColor;

/**
 *  在某个点添加动画
 *
 *  @param point 动画开始的点
 *  @param type  动画的类型
 *  @param color 动画的颜色
 *  @param completion 动画结束后的代码快
 */
- (void)hd_addAnimationAtPoint:(CGPoint)point WithType:(HDAnimationType)type withColor:(UIColor *)animationColor completion:(void (^)(BOOL finished))completion;

/**
 *  在某个点添加动画
 *
 *  @param point      动画开始的点
 *  @param duration   动画时间
 *  @param type       动画的类型
 *  @param color      动画的颜色
 *  @param completion 动画结束后的代码快
 */
- (void)hd_addAnimationAtPoint:(CGPoint)point WithDuration:(NSTimeInterval)duration WithType:(HDAnimationType) type withColor:(UIColor *)animationColor completion:(void (^)(BOOL finished))completion;


@end
