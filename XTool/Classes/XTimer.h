//
//  XTimer.h
//  Pods-XTool_Example
//
//  Created by 项正强 on 2022/1/12.
//  快捷定时器

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^XActionBlock)(void);

@interface XTimer : NSObject
+ (instancetype) instance;
/**
 * 创建一个名字为name的定时器
 * @Param name 定时器的名字
 * @Param delay 延迟执行时间
 * @Param actionBlock 执行的操作
 */
- (void) scheduledDispatchTimerWithName:(NSString *) name
                                  Delay:(double) delay
                            ActionBlock:(XActionBlock) actionBlock;
/**
 * 创建一个名字为name的定时器
 * @Param name 定时器的名字
 * @Param timeInterval 时间间隔
 * @Param delay 延迟执行时间
 * @Param repeats 是否重复
 * @Param actionBlock 执行的操作
 */
- (void) scheduledDispatchTimerWithName:(NSString *) name
                           TimeInterval:(double) timeInterval
                                  Delay:(double) delay
                                Repeats:(BOOL) repeats
                            ActionBlock:(XActionBlock) actionBlock;
/**
 * 创建一个名字为name的定时器
 * @Param name 定时器的名字
 * @Param timeInterval 时间间隔
 * @Param delay 延迟执行时间
 * @Param queue 线程
 * @Param repeats 是否重复
 * @Param actionBlock 执行的操作
 */
- (void) scheduledDispatchTimerWithName:(NSString *) name
                           TimeInterval:(double) timeInterval
                                  Delay:(double) delay
                                  Queue:(dispatch_queue_t) queue
                                Repeats:(BOOL) repeats
                            ActionBlock:(XActionBlock) actionBlock;
/**
 * 销毁计时器
 * @Param name 定时器的名字
 */
- (void) destoryTimerWithName:(NSString *) name;
/**
 * 检测是否已经存在计时器
 * @Param name 定时器的名字
 */
- (BOOL) isExistTimerWithName:(NSString *) name;
@end

NS_ASSUME_NONNULL_END
