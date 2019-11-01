//
//  MapMyCollectTableViewCell.m
//  SwellPro
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 MM. All rights reserved.
//

#import "MapMyCollectTableViewCell.h"


@implementation MapMyCollectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _collectName.userInteractionEnabled = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected) {
        [_collectName setBackgroundColor:RGB(236, 170, 156)];
    }else{
        [_collectName setBackgroundColor:[UIColor whiteColor]];
    }
}

- (IBAction)editAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(editOnMapMyCollectTableViewCell:)]) {
        [_delegate editOnMapMyCollectTableViewCell:self];
    }
}
- (IBAction)deleteAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(deleteOnMapMyCollectTableViewCell:)]) {
        [_delegate deleteOnMapMyCollectTableViewCell:self];
    }
}

@end
