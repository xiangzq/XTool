//
//  NSArray+XTool.h
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/2/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (XTool)

@end

@interface NSArray (XImageData)
/// 将UIImage类型的数组转为NSData类型的数组
- (NSArray<NSData *> *) x_datas;
/// 将NSData类型的数组转为UIImage类型的数组
- (NSArray<UIImage *> *) x_images;
@end

NS_ASSUME_NONNULL_END
