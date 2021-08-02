//
//  UIView+XTool.m
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/2/7.
//

#import "UIView+XTool.h"
#import <objc/runtime.h>

static NSString *Key_IndexPath = @"Key_IndexPath";

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


@implementation UIView (XIndexPath)

- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self, &Key_IndexPath, indexPath, OBJC_ASSOCIATION_COPY);
}


- (NSString *) indexPath {
    return objc_getAssociatedObject(self, &Key_IndexPath);
}

@end
