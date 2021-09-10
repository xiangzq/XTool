//
//  UIAlertController+XTool.h
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/2/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (XTool)
+ (void) alertWithTitle:(NSString * _Nullable ) title
                message:(NSString * _Nullable ) message
              sureTitle:(NSString * _Nullable ) sureTitle
            cancelTitle:(NSString * _Nullable ) cancelTitle
             sureHandle:(nullable void(^)(void)) handle;
@end

NS_ASSUME_NONNULL_END
