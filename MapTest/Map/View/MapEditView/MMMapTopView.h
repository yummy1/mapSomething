//
//  MMMapTopView.h
//  MapTest
//
//  Created by mac on 2019/9/17.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapStructure.h"

typedef void(^setBlock)(MAP_function setIndex);
@interface MMMapTopView : UIView
@property (nonatomic,copy) setBlock setInedx;
@end


