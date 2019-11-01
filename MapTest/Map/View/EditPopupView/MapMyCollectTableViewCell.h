//
//  MapMyCollectTableViewCell.h
//  SwellPro
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 MM. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MapMyCollectTableViewCell;
@protocol MapMyCollectTableViewCellDelegate <NSObject>
- (void)editOnMapMyCollectTableViewCell:(MapMyCollectTableViewCell *)cell;
- (void)deleteOnMapMyCollectTableViewCell:(MapMyCollectTableViewCell *)cell;

@end
@interface MapMyCollectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *collectName;
@property(nonatomic, weak) id<MapMyCollectTableViewCellDelegate> delegate;
@end


