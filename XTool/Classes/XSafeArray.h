//
//  XSafeArray.h
//  Pods-XTool_Example
//
//  Created by 项正强 on 2022/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 请勿使用快捷方式创建数组，如：arr = @[]
 请使用 arrayWithCapacity
 */
@interface XSafeArray : NSMutableArray
+ (instancetype)arrayWithObject:(id)anObject __attribute__((unavailable("Use [[ZQSafeArray alloc] init]")));
+ (instancetype)arrayWithObjects:(id)firstObj, ... __attribute__((unavailable("Use [[ZQSafeArray alloc] init]")));
+ (instancetype)arrayWithArray:(NSArray *)array __attribute__((unavailable("Use [[ZQSafeArray alloc] init]")));
- (instancetype)initWithObjects:(id)firstObj, ... __attribute__((unavailable("Use [[ZQSafeArray alloc] init]")));
+ (instancetype) arrayWithCapacity:(NSUInteger)numItems;

/// 获取可变数组数量
- (NSUInteger)count;
/// 获取某一个对象的索引位置
- (NSUInteger) indexOfObject:(id)anObject;

//MARK: 增
/// 添加对象
- (void) addObject:(id)anObject;
/// 插入对象至指定位置
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;

//MARK: 删
/// 删除指定位置上的对象
- (void) removeObjectAtIndex:(NSUInteger)index;
/// 删除全部对象
- (void) removeAllObjects;
/// 删除最后一个对象
- (void) removeLastObject;

//MARK: 改
/// 替换指定位置的对象
- (void) replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
/// 交换两个对象的索引
- (void) exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;

//MARK: 查
/// 获取第N个位置的对象
- (id)objectAtIndex:(NSUInteger)index;
/// 获取第N个位置的对象(下标方式)
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
@end

NS_ASSUME_NONNULL_END
