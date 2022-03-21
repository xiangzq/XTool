//
//  XCatonMonitoring.h
//  XTool
//
//  Created by 项正强 on 2022/3/21.
//  界面卡顿监测

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCatonMonitoring : NSObject 
+ (instancetype) instance;
/**
 * 开启卡顿监控
 * @Param timeOut 卡顿超时时间（毫秒）
 */
- (void) beginMonitorWithTimeOut:(NSInteger) timeOut;
/// 结束卡顿监控
- (void) endMonitor;
@end

NS_ASSUME_NONNULL_END

/*!
 *  @brief  线程堆栈上下文输出
 */
@interface LXDBacktraceLogger : NSObject
/// 所有线程堆栈上下文输出
+ (NSString *_Nonnull)lxd_backtraceOfAllThread;
/// 主线程堆栈上下文输出
+ (NSString *_Nonnull)lxd_backtraceOfMainThread;
/// 当前线程堆栈上下文输出
+ (NSString *_Nonnull)lxd_backtraceOfCurrentThread;
/// 指定线程堆栈上下文输出
+ (NSString *_Nonnull)lxd_backtraceOfNSThread:(NSThread *_Nonnull)thread;

+ (void)lxd_logMain;
+ (void)lxd_logCurrent;
+ (void)lxd_logAllThread;

@end
