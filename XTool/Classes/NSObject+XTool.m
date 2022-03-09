//
//  NSObject+XTool.m
//  Pods-XTool_Example
//
//  Created by 项正强 on 2022/3/8.
//

#import "NSObject+XTool.h"
#import <objc/runtime.h>

@implementation NSObject (XTool)

/// 方法交换函数
void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

@end

@interface NSObject (XProperty)

@end

@implementation NSObject (XProperty)

/// 获取当前对象所有属性和实例变量
- (NSArray<NSString *> *) getIvarArr {
    NSMutableArray<NSString *> *ps = @[].mutableCopy;
    unsigned count = 0;
    Ivar *ivars = class_copyIvarList(self.class, &count);
    for (int i = 0; i < count; i ++) {
        const char *s = ivar_getName(ivars[i]);
        NSString *p = [NSString stringWithCString:s encoding:NSUTF8StringEncoding];
        if (p != nil && ![p isKindOfClass:[NSNull class]]) [ps addObject:p];
    }
    return ps;
}

/// 获取当前对象所有属性
- (NSArray<NSString *> *) getPropertyArr {
    NSMutableArray<NSString *> *ps = @[].mutableCopy;
    unsigned count = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    for (int i = 0; i < count; i ++) {
        const char *s = property_getName(properties[i]);
        NSString *p = [NSString stringWithCString:s encoding:NSUTF8StringEncoding];
        if (p != nil && ![p isKindOfClass:[NSNull class]]) [ps addObject:p];
    }
    return ps;
}

/// 获取当前方法列表
- (NSArray<NSString *> *) getMethodArr {
    NSMutableArray<NSString *> *ms = @[].mutableCopy;
    unsigned count = 0;
    Method *methods = class_copyMethodList(self.class, &count);
    for (int i = 0; i < count; i ++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        if (name != nil && ![name isKindOfClass:[NSNull class]]) [ms addObject:name];
    }
    return ms;
}

@end

@implementation NSObject (XCrash)


@end
