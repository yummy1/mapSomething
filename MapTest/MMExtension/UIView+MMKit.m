//
//  UIView+GWPKit.m

//

#import "UIView+MMKit.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (MMKit)
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

#pragma mark - 常用方法（移动及放大缩小、加边框、设置背景图片）
// Move via offset
- (void) moveBy: (CGPoint) delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}

- (void)dashedBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth{
    CGFloat radius = self.layer.cornerRadius;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointZero];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[color CGColor]];
    
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:borderWidth];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:5],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    if (radius==0) {
        CGPathAddRect(path, NULL, CGRectMake(0, 0, self.width, self.height));
    } else {
        CGPathMoveToPoint(path, NULL, radius, 0);
        CGPathAddLineToPoint(path, NULL, self.width-radius, 0);
        CGPathAddArc(path, NULL, self.width-radius, radius, radius, M_PI_2*3, 0, NO);
        CGPathAddLineToPoint(path, NULL, self.width, self.height-radius);
        CGPathAddArc(path, NULL, self.width-radius, self.height-radius, radius, 0, M_PI_2, NO);
        CGPathAddLineToPoint(path, NULL, radius, self.height);
        CGPathAddArc(path, NULL, radius, self.height-radius, radius, M_PI_2, -M_PI, NO);
        CGPathAddLineToPoint(path, NULL, 0, radius);
        CGPathAddArc(path, NULL, radius, radius, radius, M_PI, M_PI_2*3, NO);
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);

    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    [[self layer] addSublayer:shapeLayer];
}

+(UIView *)setBackgroundImage:(UIImage *)image size:(CGSize)size
{
    UIView *view = [[UIView alloc] init];
    view.size = size;
    view.layer.contents = (__bridge id _Nullable)(image.CGImage);
    view.layer.contentsGravity = kCAGravityResizeAspect;
//    显示图片大小不受限制，
    view.layer.contentsGravity = kCAGravityCenter;
    view.layer.contentsScale = image.scale;
//    超出视图让显示
    view.clipsToBounds = YES;
    return view;
}
#pragma mark - 动画相关
- (void)hd_addAnimationAtPoint:(CGPoint)point;
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat diameter = [self hd_mdShapeDiameterForPoint:point];
    shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0.0, diameter, diameter)].CGPath;
    [self.layer addSublayer:shapeLayer];
    shapeLayer.fillColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0].CGColor;
    // animate
    CGFloat scale = 100.0 / shapeLayer.frame.size.width;
    NSString *timingFunctionName = kCAMediaTimingFunctionDefault; //inflating ? kCAMediaTimingFunctionDefault : kCAMediaTimingFunctionDefault;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    animation.removedOnCompletion = YES;
    animation.duration = 3.0;
    shapeLayer.transform = [animation.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
    }];
    [shapeLayer addAnimation:animation forKey:@"shapeBackgroundAnimation"];
    [CATransaction commit];
}

- (void)hd_addAnimationAtPoint:(CGPoint)point WithType:(HDAnimationType) type withColor:(UIColor *)animationColor completion:(void (^)(BOOL))completion
{
    [self hd_addAnimationAtPoint:point WithDuration:1.0 WithType:type withColor:animationColor  completion:completion];
}

- (void)hd_addAnimationAtPoint:(CGPoint)point WithDuration:(NSTimeInterval)duration WithType:(HDAnimationType) type withColor:(UIColor *)animationColor completion:(void (^)(BOOL finished))completion
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat diameter = [self hd_mdShapeDiameterForPoint:point];
    shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0.0, diameter, diameter)].CGPath;
    
    shapeLayer.fillColor = animationColor.CGColor;
    // animate
    CGFloat scale = 1.0 / shapeLayer.frame.size.width;
    NSString *timingFunctionName = kCAMediaTimingFunctionDefault; //inflating ? kCAMediaTimingFunctionDefault : kCAMediaTimingFunctionDefault;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    switch (type) {
        case HDAnimationOpen:
        {
            [self.layer addSublayer:shapeLayer];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            break;
        }
        case HDAnimationClose:
        {
            [self.layer insertSublayer:shapeLayer atIndex:0];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            break;
        }
        default:
            break;
    }
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    animation.removedOnCompletion = YES;
    animation.duration = duration;
    shapeLayer.transform = [animation.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
        completion(true);
    }];
    [shapeLayer addAnimation:animation forKey:@"shapeBackgroundAnimation"];
    [CATransaction commit];
    
}

- (void)hd_addAnimationAtPoint:(CGPoint)point WithType:(HDAnimationType) type withColor:(UIColor *)animationColor;
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat diameter = [self hd_mdShapeDiameterForPoint:point];
    shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0.0, diameter, diameter)].CGPath;
    
    shapeLayer.fillColor = animationColor.CGColor;
    // animate
    CGFloat scale = 100.0 / shapeLayer.frame.size.width;
    NSString *timingFunctionName = kCAMediaTimingFunctionDefault; //inflating ? kCAMediaTimingFunctionDefault : kCAMediaTimingFunctionDefault;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    switch (type) {
        case HDAnimationOpen:
        {
            [self.layer addSublayer:shapeLayer];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            break;
        }
        case HDAnimationClose:
        {
            [self.layer insertSublayer:shapeLayer atIndex:0];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            break;
        }
        default:
            break;
    }
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    animation.removedOnCompletion = YES;
    animation.duration = 3.0;
    shapeLayer.transform = [animation.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
    }];
    [shapeLayer addAnimation:animation forKey:@"shapeBackgroundAnimation"];
    [CATransaction commit];
}

// 计算离屏幕的边框最大的距离
- (CGFloat)hd_mdShapeDiameterForPoint:(CGPoint)point
{
    CGPoint cornerPoints[] = {
        {0.0, 0.0},
        {0.0, self.bounds.size.height},
        {self.bounds.size.width, self.bounds.size.height},
        {self.bounds.size.width, 0.0}
    };
    
    CGFloat radius = 0.0;
    for (int i = 0; i < 4; i++)
    {
        CGPoint p = cornerPoints[i];
        CGFloat d = sqrt( pow(p.x - point.x, 2.0) + pow(p.y - point.y, 2.0));
        if (d > radius)
        {
            radius = d;
        }
    }
    
    return radius * 2.0;
}

@end
