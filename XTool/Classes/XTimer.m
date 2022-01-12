//
//  XTimer.m
//  Pods-XTool_Example
//
//  Created by 项正强 on 2022/1/12.
//

#import "XTimer.h"

@interface XTimer ()
@property (nonatomic,strong) NSMutableDictionary<NSString *,dispatch_source_t> *cacheTimerInfo;
@end

@implementation XTimer

/// 初期化 AGOASBluetoothManager 单例对象
static XTimer *manager = nil;
+ (instancetype) instance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XTimer alloc] init];
        manager.cacheTimerInfo = @{}.mutableCopy;
    });
    return manager;
}

/**
 * 创建一个名字为name的定时器
 * @Param name 定时器的名字
 * @Param delay 延迟执行时间
 * @Param actionBlock 执行的操作
 */
- (void) scheduledDispatchTimerWithName:(NSString *) name
                                  Delay:(double) delay
                            ActionBlock:(XActionBlock) actionBlock {
    [self scheduledDispatchTimerWithName:name
                            TimeInterval:1.0
                                   Delay:delay
                                 Repeats:false
                             ActionBlock:actionBlock];
}

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
                            ActionBlock:(XActionBlock) actionBlock {
    [self scheduledDispatchTimerWithName:name
                            TimeInterval:timeInterval
                                   Delay:delay
                                   Queue:dispatch_get_main_queue()
                                 Repeats:repeats
                             ActionBlock:actionBlock];
}

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
                            ActionBlock:(XActionBlock) actionBlock {
    __weak __typeof(self)weakSelf = self;
    if (name == nil || [name isEqualToString:@""] || name.length <= 0) return;
    dispatch_source_t timer = self.cacheTimerInfo[name];
    if (timer == nil) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        [self.cacheTimerInfo setObject:timer forKey:name];
    }
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW+delay, timeInterval * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        actionBlock ? actionBlock() : nil;
        if (!repeats) [weakSelf destoryTimerWithName:name];
    });
    // 启动任务，GCD计时器创建后需要手动启动
    dispatch_resume(timer);
}

/**
 * 销毁计时器
 * @Param name 定时器的名字
 */
- (void) destoryTimerWithName:(NSString *) name {
    dispatch_source_t timer = self.cacheTimerInfo[name];
    if (timer == nil) return;
    [self.cacheTimerInfo removeObjectForKey:name];
    dispatch_source_cancel(timer);
}

/**
 * 检测是否已经存在计时器
 * @Param name 定时器的名字
 */
- (BOOL) isExistTimerWithName:(NSString *) name {
    return self.cacheTimerInfo[name] != nil;
}
@end
