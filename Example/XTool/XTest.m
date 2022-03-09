//
//  XTest.m
//  XTool_Example
//
//  Created by 项正强 on 2022/3/9.
//  Copyright © 2022 xiangzq. All rights reserved.
//

#import "XTest.h"

@implementation XTest

- (void) c {
    NSLog(@"执行了对象【%@】的【%@】方法",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}
@end
