//
//  NSMutableString+XTool.h
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/1/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSMutableString (XTool)

@end

@interface NSMutableString (XStyle)
/// 自定义文字样式
+ (NSMutableAttributedString *) customAttributeTextByContents:(NSArray<NSString *> *) contents
                                                        fonts:(NSArray<UIFont *> *) fonts
                                                       colors:(NSArray<UIColor *> *) colors;
@end

NS_ASSUME_NONNULL_END
