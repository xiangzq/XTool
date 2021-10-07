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
             sureHandle:(nullable void(^)(void)) handle
           cancelHandle:(nullable void(^)(void)) cancel;

/**
 * 警告框 UIAlertControllerStyleActionSheet
 * @Param title 标题
 * @Param message 内容
 * @Param actions 确定类型数组集合 @[@{@"title":@"",@"tag":1}]
 * @Param cancelTitle 取消类型标题
 * @Param sourceView ipad专用
 * @Param sure 确定类型回调，返回参数为actions中的tag
 * @Param cancel 取消类型回调
 */
+ (void) sheetWithTitle:(NSString * _Nullable ) title
                Message:(NSString * _Nullable ) message
                Actions:(NSArray<NSDictionary *> *) actions
            CancelTitle:(NSString * _Nullable ) cancelTitle
             SourceView:(UIView * _Nullable) sourceView
             SureHandle:(nullable void(^)(NSInteger tag)) sure
           CancelHandle:(nullable void(^)(void)) cancel;
@end

NS_ASSUME_NONNULL_END
