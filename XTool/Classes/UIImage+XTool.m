//
//  UIImage+XTool.m
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/1/28.
//

#import "UIImage+XTool.h"

@implementation UIImage (XTool)

@end

//MARK: 腿片压缩
@implementation UIImage (XCompression)

- (UIImage *) compressImageByMaxKB:(NSUInteger) kb {
    return [UIImage imageWithData:[self compressImageDataByMaxKB:kb]];
}

- (NSData *) compressImageDataByMaxKB:(NSUInteger) kb {
    NSUInteger maxLength = kb * 1024;
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; i++) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    
    if (data.length < maxLength) return data;
    NSUInteger lastDataLength = 0;
    UIImage *resultImage = [UIImage imageWithData:data];
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    NSLog(@"压缩后图片大小为：%.2f",data.length/1000.0);
    return data;
}

@end

//MARK: 图片尺寸
@implementation UIImage (XSize)

///// 根据图片名称获取图片大小
//+ (CGSize) getImageSizeByName:(NSString *) name {
//    
//}
///// 根据图片获取图片大小
//+ (CGSize) getImageSizeByImage:(UIImage *) image {
//    
//}

@end
