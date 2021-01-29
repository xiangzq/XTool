//
//  NSMutableString+XTool.m
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/1/28.
//

#import "NSMutableString+XTool.h"

@implementation NSMutableString (XTool)



@end

@implementation NSMutableString (XStyle)

+ (NSMutableAttributedString *) customAttributeTextByContents:(NSArray<NSString *> *) contents
                                                        fonts:(NSArray<UIFont *> *) fonts
                                                       colors:(NSArray<UIColor *> *) colors {
    NSString *text = [contents componentsJoinedByString:@""];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:text];
    [contents enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIFont *font           = [fonts objectAtIndex:idx];
        UIColor *color         = [colors objectAtIndex:idx];
        NSDictionary *dict     = @{NSFontAttributeName:font,NSForegroundColorAttributeName:color};
        NSString *cycleContent = [self __cycleContents:contents count:idx];
        [attStr addAttributes:dict range:NSMakeRange(cycleContent.length, obj.length)];
    }];
    return attStr;
}

+ (NSString *) __cycleContents:(NSArray<NSString *> *) contents count:(NSInteger) count {
    if (contents == nil || contents.count == 0) return @"";
    if (count > contents.count) count = contents.count;
    NSMutableString *content = @"".mutableCopy;
    for (int i = 0; i < count; i ++) [content appendString:contents[i]];
    return content.copy;
}

@end
