//
//  NSArray+XTool.m
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/2/7.
//

#import "NSArray+XTool.h"

@implementation NSArray (XTool)

@end

@implementation NSArray (XImageData)
- (NSArray<NSData *> *)x_datas {
    NSMutableArray<NSData *> *datas = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIImage class]]) {
            NSData *data = UIImagePNGRepresentation((UIImage *)obj);
            [datas addObject:data];
        }
    }];
    return datas;
}

- (NSArray<UIImage *> *)x_images {
    NSMutableArray<UIImage *> *images = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSData class]]) {
            UIImage *image = [UIImage imageWithData:(NSData *)obj];
            [images addObject:image];
        }
    }];
    return images;
}
@end
