//
//  XViewController.m
//  XTool
//
//  Created by xiangzq on 01/28/2021.
//  Copyright (c) 2021 xiangzq. All rights reserved.
//

#import "XViewController.h"
//#import <XTool/XTool.h>
#import "XTool.h"
#import "XTest.h"
#import <objc/runtime.h>
@interface XViewController ()
@property (nonatomic,strong) NSArray *arr;
@end

@implementation XViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self performSelector:@selector(c)];
    [XViewController performSelector:@selector(m)];
    
}

- (void) interceptCrash {
    NSString *name = NSStringFromSelector(_cmd);
    NSLog(@"拦截到未实现的方法：%@",name);
}

//MARK: 动态方法解析

/// 对象方法解析
+ (BOOL) resolveInstanceMethod:(SEL)sel {
    NSString *name = NSStringFromSelector(sel);
    NSLog(@"name = %@",name);
    if ([name isEqualToString:@"c"]) {
        IMP imp = class_getMethodImplementation([self class], @selector(interceptCrash));
        class_addMethod([self class], sel, imp, "v@:");
        return true;
    }
    return [super resolveInstanceMethod:sel];
}

/// 类方法解析
+ (BOOL)resolveClassMethod:(SEL)sel {
    if ([NSStringFromSelector(sel) isEqualToString:@"m"]) {
        IMP imp = class_getMethodImplementation([XViewController class], @selector(interceptCrash));
        class_addMethod(objc_getMetaClass(object_getClassName(self)), sel, imp, "v@");
        return true;
    }
    return [super resolveClassMethod:sel];
}

/// 快速转发阶段
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSString *name = NSStringFromSelector(aSelector);
    if ([name isEqualToString:@"c"]) {
        // 将消息转给 XTest
        return [XTest new];
    }
    return [super forwardingTargetForSelector:aSelector];
}

/// 常规转发阶段
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    // 返回SEL方法的签名，是否为空
    NSMethodSignature *s = [super methodSignatureForSelector:aSelector];
    if (s == nil) {
        /*
         自动创建签名
         写法例子
         例子"v@:@"
         v@:@ v:返回值类型void;@ id类型,执行sel的对象;：SEL;@参数
         例子"@@:"
         @:返回值类型id;@id类型,执行sel的对象;：SEL
         */
        s = [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return s;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    // 创建备用对象
    XTest *t = [XTest new];
    SEL sel = anInvocation.selector;
    // 判断备用对象是否可以响应传递进来等待响应的SEL
    if ([t respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:t];
    } else{
        // 如果备用对象不能响应 则抛出异常
        [self doesNotRecognizeSelector:sel];
    }
}

@end
