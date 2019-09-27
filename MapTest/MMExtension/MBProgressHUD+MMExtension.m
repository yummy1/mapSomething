//
//  MBProgressHUD+MMExtension.m
//

//#import "MBProgressHUD+MMExtension.h"
//
//@implementation MBProgressHUD (MMExtension)
//#pragma mark - 执行显示（success、error）
//+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view completion:(MBProgressHUDCompletionBlock)completion{
//    if (view == nil) view = [[[UIApplication sharedApplication] delegate] window];
//    // 快速显示一个提示信息
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.bezelView.layer.cornerRadius = 10;
//    hud.bezelView.color = RGBA(68, 68, 68, 0.8);
//    hud.label.text = text;
//    hud.contentColor = [UIColor whiteColor];
//    // 设置图片
//    if (icon) {
//        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
//    }
//    // 再设置模式
//    hud.mode = MBProgressHUDModeCustomView;
//    // 完成回调
//    hud.completionBlock = completion;
//    // 隐藏时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
//    // 1秒之后再消失
//    [hud hideAnimated:YES afterDelay:1];
//}
//
//#pragma mark - 显示错误信息
//+ (void)showError:(NSString *)error{
//    [self showError:error toView:nil];
//}
//+ (void)showError:(NSString *)error completion:(MBProgressHUDCompletionBlock)completion{
//    [self showError:error toView:nil completion:completion];
//}
//+ (void)showError:(NSString *)error toView:(UIView *)view{
//    [self showError:error toView:view completion:nil];
//}
//+ (void)showError:(NSString *)error toView:(UIView *)view completion:(MBProgressHUDCompletionBlock)completion{
//    [self show:error icon:@"touming-cuo" view:view completion:completion];
//}
//
//
//#pragma mark - 显示成功信息
//+ (void)showSuccess:(NSString *)success{
//    [self showSuccess:success toView:nil];
//}
//+ (void)showSuccess:(NSString *)success completion:(MBProgressHUDCompletionBlock)completion{
//    [self showSuccess:success toView:nil completion:completion];
//}
//+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
//    [self showSuccess:success toView:view completion:nil];
//}
//+ (void)showSuccess:(NSString *)success toView:(UIView *)view completion:(MBProgressHUDCompletionBlock)completion{
//    [self show:success icon:@"touming-dui" view:view completion:completion];
//}
//
//
//#pragma mark - 显示一些正在加载的信息
//+ (MBProgressHUD *)showLoadingMessage:(NSString *)message{
//    return [self showLoadingMessage:message toView:nil];
//}
//+ (MBProgressHUD *)showLoadingMessage:(NSString *)message withCover:(BOOL)cover{
//    return [self showLoadingMessage:message toView:nil withCover:cover];
//}
//+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view {
//    return [self showLoadingMessage:message toView:view withCover:YES];
//}
//+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view withCover:(BOOL)cover{
//    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
//    // 快速显示一个提示信息
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.label.text = message;
//    // 隐藏时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
//    // YES代表需要蒙版效果
//    hud.hidden = cover;
//    return hud;
//}
//
//
//#pragma mark - 显示一些正在加载的信息
//+ (void)showMessage:(NSString *)message{
//    [self showMessage:message toView:nil];
//}
//+ (void)showMessage:(NSString *)message withCover:(BOOL)cover{
//    [self showMessage:message toView:nil withCover:cover];
//}
//+ (void)showMessage:(NSString *)message toView:(UIView *)view {
//    [self showMessage:message toView:view withCover:NO];
//}
//+ (void)showMessage:(NSString *)message toView:(UIView *)view withCover:(BOOL)cover{
//    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
//
//    [self show:message icon:nil view:view completion:nil];
//}
//
//
//#pragma mark - 隐藏HUD
//+ (void)hideHUD{
//    [self hideHUDForView:nil];
//}
//+ (void)hideHUDForView:(UIView *)view{
//    [self hideHUDForView:view animated:YES];
//}

//@end
