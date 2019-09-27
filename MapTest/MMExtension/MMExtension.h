//
//  MMExtension.h
//
//

#ifndef MMEXTENSION_h
#define MMEXTENSION_h
/*
 *不同机型分类
 */
#import "DeviceModel.h"
/*
 *用于直接修改继承自UIView的控件的x,y,width,height,size,origin,centerX,centerY,top,left,bottom,right等值，而不需要先获取frame在进行修改
 给UIView设置某种颜色的虚线边框，宽度1px
 */
#import "UIView+MMKit.h"
 /*
  *对MBProgressHUD的第二次封装
 */
#import "MBProgressHUD+MMExtension.h"
/*
 *各种加密
 */
#import "NSString+MMEncrypt.h"
/*
 *用正则表达式判断是否是数字、字母、QQ、手机号、邮箱、身份证号、汉字等其他项目中需要的验证
 */
#import "NSString+MMRegex.h"
/*
 *对image的各种处理
 */
#import "UIImage+MMExtension.h"
/*
 *对SDWebImage的二次封装，给UIImageView加图片时
 */
#import "UIImageView+MMExtension.h"
/*
 *
 */
#import "UITableViewCell+MMExtension.h"
/*
 *根据文字内容显示高度
 */
#import "NSString+size.h"
/*
 *输出系统的各种文件路径
 */
#import "NSString+Path.h"
/*
 *设置textField
 */
#import "UITextField+Extension.h"
/*
 *存储
 */
#import "NSArray+MMExtension.h"

//json字符串和数组、字典的相互转换
#import "NSString+MMJSON.h"

/** 格式化时间 */
#import "NSString+Date.h"

/** label内边距 */
#import "InsertLabel.h"

/** button内边距 */
#import "InsertButton.h"

/** 横竖屏 */
//#import "UIDevice+MMAdd.h"

#endif

#ifdef __OBJC__


/** 表情键盘的删除按钮点击通知 */
#define GWPEmotionDidDeleteNotification @"GWPEmotionDidDeleteNotification"

#define GWPSelectEmotionKey @"GWPSelectEmotionKey"

/** 表情被点击通知 */
#define GWPEmotionDidSelectNotification @"GWPEmotionDidSelectNotification"

#endif  // __OBJC__
