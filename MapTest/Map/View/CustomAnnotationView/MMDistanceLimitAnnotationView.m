//
//  MMDistanceLimitAnnotationView.m
//  MapTest
//
//  Created by mac on 2019/9/12.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMDistanceLimitAnnotationView.h"

@interface MMDistanceLimitAnnotationView ()
@property (nonatomic,strong) UIImageView *imageIcon;
@end
@implementation MMDistanceLimitAnnotationView

#pragma mark - Life Cycle
- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        /* Create portrait image view and add to view hierarchy. */
        self.bounds = CGRectMake(0.f, 0.f, 200, 75);
        self.imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 75)];
        self.imageIcon.image = [UIImage imageNamed:@"distanceLimit"];
        [self addSubview:self.imageIcon];
    }
    return self;
}

@end
