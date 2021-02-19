//
//  UITextView+XTool.m
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/2/19.
//

#import "UITextView+XTool.h"
#import <objc/runtime.h>

@implementation UITextView (XTool)

@end

@implementation UITextView (XProperty)

- (NSString *)x_placeholder {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setX_placeholder:(NSString *)x_placeholder {
    objc_setAssociatedObject(self, @selector(x_placeholder), x_placeholder, OBJC_ASSOCIATION_COPY);
    [self x_placeholder:self.x_placeholder];
}

- (void) x_placeholder:(NSString *) placeholder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *objcName = [NSString stringWithUTF8String:name];
        if ([objcName isEqualToString:@"_placeholderLabel"]) {
            UILabel *placeHolderLabel = [[UILabel alloc] init];
            placeHolderLabel.text = placeholder;
            placeHolderLabel.numberOfLines = 0;
            placeHolderLabel.textColor = [UIColor lightGrayColor];
            [placeHolderLabel sizeToFit];
            [self addSubview:placeHolderLabel];
            placeHolderLabel.font = self.font;
            [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
            break;
        }
    }
    free(ivars);
}

@end
