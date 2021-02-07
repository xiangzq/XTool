//
//  UIView+XTool.m
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/2/7.
//

#import "UIView+XTool.h"

@implementation UIView (XTool)

- (UIViewController *) x_viewController {
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) return (UIViewController *)responder;
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

@end
