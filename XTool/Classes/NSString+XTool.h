//
//  NSString+XTool.h
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/2/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XTool)
/// 判断是否是纯汉字
- (BOOL)isChinese;
/// 判断是否含有汉字
- (BOOL)includeChinese;
/// 判断是否含有html标签
- (BOOL) hasHtmlLabel;
@end

NS_ASSUME_NONNULL_END
