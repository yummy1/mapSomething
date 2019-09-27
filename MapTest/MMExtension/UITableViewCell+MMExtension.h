//
//  UITableViewCell+MMExtension.h
//  EbangService
//

#import <UIKit/UIKit.h>

#define DIYCell_interface \
+ (NSString *)identifier;\
+ (instancetype)cellWithTableView:(UITableView *)tableView;




#define DIYCell_implementation(Class)\
+ (NSString *)identifier{\
    return NSStringFromClass([self class]);\
}\
\
+ (instancetype)cellWithTableView:(UITableView *)tableView{\
    Class *cell = [tableView dequeueReusableCellWithIdentifier:[self identifier]];\
    if (!cell) {\
        cell = [[Class alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[self identifier]];\
    }\
    return cell;\
}


@interface UITableViewCell (MMExtension)

@end
