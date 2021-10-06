//
//  UIAlertController+XTool.m
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/2/7.
//

#import "UIAlertController+XTool.h"
#import "UIViewController+XTool.h"
@implementation UIAlertController (XTool)

+ (void) alertWithTitle:(NSString * _Nullable ) title
                message:(NSString * _Nullable ) message
              sureTitle:(NSString * _Nullable ) sureTitle
            cancelTitle:(NSString * _Nullable ) cancelTitle
             sureHandle:(nullable void(^)(void)) sure
           cancelHandle:(nullable void(^)(void)) cancel {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancel ? cancel() : nil;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sure ? sure() : nil;
    }]];
    [[UIViewController x_viewController] presentViewController:alert animated:YES completion:nil];
}
@end
