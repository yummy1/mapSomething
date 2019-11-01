//
//  MMMapMyCollectView.m
//  MapTest
//
//  Created by mac on 2019/11/1.
//  Copyright © 2019 LCHK. All rights reserved.
//

#import "MMMapMyCollectView.h"
#import "MMAnnotation.h"
#import "MapMyCollectTableViewCell.h"

@interface MMMapMyCollectView()<UITableViewDelegate, UITableViewDataSource,MapMyCollectTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *collectedArr;
@property (nonatomic,strong) MapMyCollectTableViewCell *selectedCell;
@end
@implementation MMMapMyCollectView
- (NSArray *)collectedArr
{
    if (!_collectedArr) {
        _collectedArr = [NSArray arrayWithArray:[NSArray getHangxian]];
    }
    return _collectedArr;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)setupUI
{
    
}
- (IBAction)sureAction:(id)sender {
    if (_selectedCell == nil) {
        [SVProgressHUD showInfoWithStatus:Localized(@"TIP_selectedShare")];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    if ([_delegate respondsToSelector:@selector(MMMapMyCollectViewClickIndex:)]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:_selectedCell];
        [_delegate MMMapMyCollectViewClickIndex:self.collectedArr[indexPath.row]];
    }
}
- (IBAction)cancelAction:(id)sender {
    if ([_delegate respondsToSelector:@selector(MMMapMyCollectViewCancel)]) {
        [_delegate MMMapMyCollectViewCancel];
    }
}
#pragma mark - UITableViewDataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.collectedArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MapMyCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MapMyCollectTableViewCell class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MapMyCollectTableViewCell class]) owner:self options:nil][0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.collectName setTitle:self.collectedArr[indexPath.row][@"name"] forState:UIControlStateNormal];
    cell.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_selectedCell setSelected:NO animated:YES];
    MapMyCollectTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES animated:YES];
    _selectedCell = cell;
}
#pragma mark - MapMyCollectTableViewCellDelegate
- (void)editOnMapMyCollectTableViewCell:(MapMyCollectTableViewCell *)cell
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:Localized(@"EditCollectedWaypointName") message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:Localized(@"YUNTAICancel") style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:Localized(@"YUNTAISure") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alertController.textFields[0];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        _collectedArr = [NSArray arrayWithArray:[NSArray editHangxian:indexPath.row name:textField.text]];
        [self.tableView reloadData];
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = cell.collectName.titleLabel.text;
    }];
    [alertController addAction:cancel];
    [alertController addAction:ok];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
- (void)deleteOnMapMyCollectTableViewCell:(MapMyCollectTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    _collectedArr = [NSArray arrayWithArray:[NSArray deleteHangxian:indexPath.row]];
    [self.tableView reloadData];
}

@end
