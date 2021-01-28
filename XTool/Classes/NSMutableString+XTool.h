//
//  NSMutableString+XTool.h
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/1/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSMutableString (XTool)
+ (NSMutableAttributedString *) attributeText1:(NSString *) text1
                                         text2:(NSString *) text2
                                         font1:(UIFont *) font1
                                         font2:(UIFont *) font2
                                        color1:(UIColor *) color1
                                        color2:(UIColor *) color2;
@end

NS_ASSUME_NONNULL_END
