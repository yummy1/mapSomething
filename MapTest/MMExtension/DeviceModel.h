//
//  DeviceModel.h

#import <Foundation/Foundation.h>

#define DeviceSize          ([UIScreen mainScreen].bounds.size)
#define iPhone4_Size        CGSizeMake(320, 480)
#define iPhone5_Size        CGSizeMake(320, 568)
#define iPhone6_Size        CGSizeMake(375, 667)
#define iPhone6Plsu_Size    CGSizeMake(414, 736)
#define iPhoneXOrXS_Size    CGSizeMake(375, 812)
#define iPhoneXROrXSMax_Size    CGSizeMake(414, 896)
#define iPad_Size           CGSizeMake(768, 1024)
#define iPadPro_Size        CGSizeMake(1024, 1336)

@interface DeviceModel : NSObject

/** All iPhone */
+ (BOOL)is_iPhone;

/** iPhone4、iPhone4S */
+ (BOOL)is_iPhone4;

/** iPhone5、iPhone5s、iPhoneSE */
+ (BOOL)is_iPhone5;

/** iPhone6、iPhone6s、iPhone7 */
+ (BOOL)is_iPhone6;

/** iPhone6 plus、iPhone6s plus、iPhone7 plus */
+ (BOOL)is_iPhone6Plus;

/** iPhoneX、iPhoneRs */
+ (BOOL)is_iPhoneX;

/** iPhoneXr、iPhoneXs Max */
+ (BOOL)is_iPhoneXr;

+ (BOOL)is_FullScreen;

/** iPad */
+ (BOOL)is_iPad;

/** ipadPro */
+ (BOOL)is_iPadPro;

@end
