//
//  NSObject+XTool.h
//  Pods-XTool_Example
//
//  Created by 项正强 on 2022/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (XTool)
/// 方法交换函数
void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector);
@end

@interface NSObject (XProperty)
/// 获取当前对象所有属性和实例变量
- (NSArray<NSString *> *) getIvarArr;
/// 获取当前对象所有属性
- (NSArray<NSString *> *) getPropertyArr;
/// 获取当前方法列表
- (NSArray<NSString *> *) getMethodArr;
@end

@interface NSObject (XCrash)

@end

NS_ASSUME_NONNULL_END
