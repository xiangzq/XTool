//
//  UIViewController+XTool.m
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/2/7.
//

#import "UIViewController+XTool.h"

@implementation UIViewController (XTool)
+ (UIViewController *) x_viewController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    if ([result isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)result;
        UINavigationController *nav = tab.selectedViewController;
        return nav.childViewControllers.lastObject;
    }
    return result;

}
@end
