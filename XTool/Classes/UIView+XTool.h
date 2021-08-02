//
//  UIView+XTool.h
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/2/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XTool)

@end

@interface UIView (XViewController)
- (UIViewController *) x_viewController;
@end

@interface UIView (XIndexPath)
@property (nonatomic,strong) NSIndexPath *indexPath;
@end

NS_ASSUME_NONNULL_END
