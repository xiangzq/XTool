//
//  NSString+XTool.m
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/2/7.
//

#import "NSString+XTool.h"

@implementation NSString (XTool)

- (BOOL) isChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)includeChinese {
    for (int i = 0; i < [self length]; i++) {
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff ) return YES;
    }
    return NO;
}

- (BOOL) hasHtmlLabel {
    if ([self containsString:@"<"] && [self containsString:@"</"] && [self containsString:@">"]) {
        return true;
    }
    return false;
}

@end
