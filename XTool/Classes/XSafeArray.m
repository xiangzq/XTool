//
//  XSafeArray.m
//  Pods-XTool_Example
//
//  Created by 项正强 on 2022/3/8.
//

#import "XSafeArray.h"

//--------------------------生成 weak automatic 变量------------------------
#ifndef weakify
#if __has_feature(objc_arc)
#define weakify(x) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")
#else
#define weakify(x) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")
#endif  // end arc
#endif  // end weakify

//-------------------------生成 strong automatic 变量------------------------------
#ifndef strongify
#if __has_feature(objc_arc)
#define strongify(x) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")
#else
#define strongify(x) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")
#endif  // end arc
#endif  // end strongify

@interface XSafeArray () {
    CFMutableArrayRef _array;
}
@property (nonatomic,strong) dispatch_queue_t syncQueue;
@end

@implementation XSafeArray

- (instancetype) init {
    self = [super init];
    if (self) {
        self = [self _initWithCapacity:0];
    }
    return self;
}

- (instancetype) _initWithCapacity:(NSUInteger)numItems {
    self = [super init];
    if (self) {
        _array = CFArrayCreateMutable(kCFAllocatorDefault, numItems, &kCFTypeArrayCallBacks);
    }
    return self;
}

+ (instancetype) arrayWithCapacity:(NSUInteger)numItems {
    return [[XSafeArray alloc] _initWithCapacity:numItems];
}

/// 获取可变数组数量
- (NSUInteger)count {
    __block NSUInteger count = 0;
    dispatch_sync(self.syncQueue, ^{
        count = [self arrayCount];
    });
    return count;
}

/// 获取某一个对象的索引位置
- (NSUInteger) indexOfObject:(id)anObject {
    __block NSUInteger result;
    @weakify(self)
    dispatch_sync(self.syncQueue, ^{
        @strongify(self)
        result = [self getIndexAtValue:anObject];
    });
    return result;
}

//MARK: 增
/// 添加对象
- (void) addObject:(id)anObject {
    @weakify(self)
    dispatch_barrier_async(self.syncQueue, ^{
        @strongify(self)
        [self appendValue:anObject];
    });
}

/// 插入对象至指定位置
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    __block NSUInteger __index = index;
    @weakify(self)
    dispatch_barrier_async(self.syncQueue, ^{
        @strongify(self)
        [self inserValue:anObject AtIndex:__index];
    });
}

//MARK: 删
/// 删除指定位置上的对象
- (void) removeObjectAtIndex:(NSUInteger)index {
    @weakify(self)
    dispatch_barrier_async(self.syncQueue, ^{
        @strongify(self)
        [self removeValueAtIndex:index];
    });
}

/// 删除全部对象
- (void) removeAllObjects {
    @weakify(self)
    dispatch_barrier_async(self.syncQueue, ^{
        @strongify(self)
        [self clearAllValue];
    });
}

/// 删除最后一个对象
- (void) removeLastObject {
    @weakify(self)
    dispatch_barrier_async(self.syncQueue, ^{
        @strongify(self)
        NSUInteger count = [self arrayCount];
        if (count > 0) [self removeValueAtIndex:count-1];
    });
}

//MARK: 改
/// 替换指定位置的对象
- (void) replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    @weakify(self)
    dispatch_barrier_async(self.syncQueue, ^{
        @strongify(self)
        [self setValue:anObject AtIndex:index];
    });
}

/// 交换两个对象的索引
- (void) exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    @weakify(self)
    dispatch_barrier_async(self.syncQueue, ^{
        @strongify(self)
        [self exchangeIndex1:idx1 Index2:idx2];
    });
}


//MARK: 查
/// 获取第N个位置的对象
- (id)objectAtIndex:(NSUInteger)index {
    __block id result;
    @weakify(self)
    dispatch_sync(self.syncQueue, ^{
        @strongify(self)
        result = [self getArrayValueAtIndex:index];
    });
    return result;
}

/// 获取第N个位置的对象(下标方式)
- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    __block id result;
    @weakify(self)
    dispatch_sync(self.syncQueue, ^{
        @strongify(self)
        result = [self getArrayValueAtIndex:idx];
    });
    return result;
}



//MARK: 私有
- (dispatch_queue_t)syncQueue {
    if (!_syncQueue) {
        static dispatch_queue_t queue;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            queue = dispatch_queue_create("come.safe.array", DISPATCH_QUEUE_CONCURRENT);
            _syncQueue = queue;
        });
    }
    return _syncQueue;
}

/// 数组元素的数量
- (NSUInteger) arrayCount {
    NSUInteger count = CFArrayGetCount(_array);
    return count;
}

/// 获取元素索引位置
- (NSUInteger) getIndexAtValue:(id) value {
    if (!value) return NSNotFound;
    NSUInteger count = [self arrayCount];
    return CFArrayGetFirstIndexOfValue(_array, CFRangeMake(0, count), (__bridge const void *)(value));
}

/// 添加元素
- (void) appendValue:(id) value {
    if (!value) return;
    CFArrayAppendValue(_array, (__bridge const void *)value);
}

/// 插入元素到数组中
- (void) inserValue:(id) value AtIndex:(NSUInteger) index {
    if (!value) return;
    NSUInteger count = [self arrayCount];
    index = index > count ? count : index;
    CFArrayInsertValueAtIndex(self->_array, index, (__bridge const void *)value);
}

/// 替换指定索引上的元素
- (void) setValue:(id) value AtIndex:(NSUInteger) index {
    if (!value) return;
    NSUInteger count = CFArrayGetCount(_array);
    if (index >= count) return;
    CFArraySetValueAtIndex(_array, index, (__bridge const void *)value);
}

/// 交换元素索引
- (void) exchangeIndex1:(NSUInteger) index1 Index2:(NSUInteger) index2 {
    NSUInteger count = CFArrayGetCount(_array);
    if (index1 >= count || index2 >= count) return;
    CFArrayExchangeValuesAtIndices(_array, index1, index2);
}

/// 根据索引删除数组中元素
- (void) removeValueAtIndex:(NSUInteger) index {
    NSUInteger count = [self arrayCount];
    if (index < count) CFArrayRemoveValueAtIndex(_array, index);
}

/// 清空数组
- (void) clearAllValue {
    CFArrayRemoveAllValues(_array);
}

/// 根据索引获取数组的元素
- (id) getArrayValueAtIndex:(NSUInteger) index {
    NSUInteger count = [self arrayCount];
    return count > index ? CFArrayGetValueAtIndex(_array, index) : nil;
}

@end
