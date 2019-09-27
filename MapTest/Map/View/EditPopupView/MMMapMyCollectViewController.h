//
//  MapMyCollectViewController.h
//  SwellPro
//
//  Created by MM on 2018/6/12.
//  Copyright © 2018年 MM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^collectedBlock)(NSDictionary *dic);
@interface MMMapMyCollectViewController : UIViewController
@property (nonatomic,copy) collectedBlock collectedAction;
@end
