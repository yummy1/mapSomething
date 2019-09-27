//
//  UIImage+MMExtension.h
//  SwellPro
//
//  Created by MM on 2018/6/20.
//  Copyright © 2018年 MM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MMExtension)
/**
 *  由颜色值生成图片
 *
 *  @param color 颜色
 *  @param size  图片大小
 *
 *  @return 生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  将图片压缩到指定大小 filesize
 *
 *  @param image       图片
 *  @param maxFileSize 指定大小
 *
 *  @return 压缩后的图片的二进制文件
 */
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;

/**
 *  裁剪图片指定区域
 *
 *  @param rect 指定区域
 *
 *  @return 裁剪后的图片
 */
- (instancetype)cutImageWithRect:(CGRect)rect;
/**
  *  剪切图片为正方形
  *
  *   image   原始图片比如size大小为(400x200)pixels
 *   newSize 正方形的size比如400pixels
  *
  *  @return 返回正方形图片(400x400)pixels
  */
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;
/**
 *  裁剪成圆形图片
 *
 *  @param margin     边框宽度
 *  @param boardColor 边框颜色
 *
 *  @return 裁剪后的圆形图片
 */
- (instancetype)circleWithBoardWidth:(CGFloat)margin boardColor:(UIColor *)boardColor;

/**
 *  根据文件名裁剪圆形图片
 *
 *  @param name       图片文件名
 *  @param boardWidth 边框宽度
 *  @param boardColor 边框颜色
 *
 *  @return 裁剪后的圆形图片
 */
+ (instancetype)circleWithImageName:(NSString *)name boardWidth:(CGFloat)boardWidth boardColor:(UIColor *)boardColor;

/**
 *   不改变图片边框的拉伸图片
 *
 *  @return 拉伸后的新图
 */
- (instancetype)resizeableImage;

/**
 *  以主色作为背景色，无拉伸增大图片；可以用来给图片加矩形相框
 *
 *  @param bgColor 新图片背景色
 *  @param size    新图片的大小
 *
 *  @return 返回增大处理后的图片
 */
- (instancetype)expansionWithBackground:(UIColor *)bgColor newSize:(CGSize)size;

/**
 *  截屏
 *
 *  @param view 需要截取的View
 *
 *  @return 截取获得的的图片
 */
+ (instancetype)captureWithView:(UIView *)view;

/**
 *  加水印（图片）
 *
 *   logo图片
 *  @param scale     logo图片的缩放比例
 *
 *  @return 加过水印之后的新图片
 */
- (instancetype)waterImage:(UIImage *)waterImage anGWPLogoScale:(CGFloat)scale;

/**
 *  加水印（文字）
 *
 *  @param bgImage   背景图片（就是衬在下面的图片）
 *  @param text       水印文字
 *  @param attributes 水印文字的属性
 *
 *  @return 加过水印之后的新图片
 *
 *  *****************************  示例代码  ***************************************
 *
 *  NSDictionary *attrs = @{
 *  NSFontAttributeName : [UIFont boldSystemFontOfSize:8],
 *  NSForegroundColorAttributeName : [UIColor whiteColor]
 *  };
 *  UIImage *lastImage = [UIImage waterImageWithBackgroundImage:[UIImage imageNamed:@"scene"] andText:@"大熊出品出品出品出品大熊出品出品出品出品大熊出品出品出品出品" andTextAttributes:attrs];
 *  // 输出到屏幕上
 *  _imgView.image = lastImage;
 *  *****************************  示例end  ***************************************
 */
+ (instancetype)waterImageWithBackgroundImage:(UIImage *)bgImage andText:(NSString *)text andTextAttributes:(NSDictionary *)attributes;

/**
 *  生成毛玻璃效果的图片
 *
 *  @param image      要模糊化的图片
 *  @param blurAmount 模糊化指数
 *
 *  @return 返回模糊化之后的图片
 */
+ (UIImage *)hd_blurredImageWithImage:(UIImage *)image andBlurAmount:(CGFloat)blurAmount;

/**
 *  生成了一个毛玻璃效果的图片
 *
 *  @return 返回模糊化好的图片
 */
- (UIImage *)hd_blurredImage:(CGFloat)blurAmount;

/**
 *  生成一个毛玻璃效果的图片
 *
 *  @param blurLevel 毛玻璃的模糊程度
 *
 *  @return 毛玻璃好的图片
 */
- (UIImage *)hd_blearImageWithBlurLevel:(CGFloat)blurLevel;

/**
 *  仿微信红包的模糊效果（最低适配iOS8）
 *
 *  @param imageView 要模糊的image视图
 *  @param isBlurry 是否模糊
 *
 *  毛玻璃好的图片
 */
- (void)hd_Image:(UIImageView *)imageView isBlurry:(BOOL)isBlurry alpha:(NSInteger)alpha;

/**
 *  字符串转图片
 */
-(UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr;
@end
