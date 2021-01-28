//
//  NSMutableString+XTool.m
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/1/28.
//

#import "NSMutableString+XTool.h"

@implementation NSMutableString (XTool)

+ (NSMutableAttributedString *) attributeText1:(NSString *) text1
                                         text2:(NSString *) text2
                                         font1:(UIFont *) font1
                                         font2:(UIFont *) font2
                                        color1:(UIColor *) color1
                                        color2:(UIColor *) color2 {
    NSString *text = [NSString stringWithFormat:@"%@%@",text1,text2];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attStr addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(0, text1.length)];
    [attStr addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(0, text1.length)];
    [attStr addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(text1.length, text.length - text1.length)];
    [attStr addAttribute:NSForegroundColorAttributeName value:color2 range:NSMakeRange(text1.length, text.length - text1.length)];
    return attStr;
}

@end
