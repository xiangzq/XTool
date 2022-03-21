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

@implementation UIImage (XDownsample)

+ (UIImage *) downsampleWithImageURL:(NSURL *) url PointSize:(CGSize) pointSize Scale:(CGFloat) scale {
    // 配置图片数据源信息
    CFStringRef imageSourceOptionKeys[1];
    CFTypeRef imageSourceOptionValues[1];
    // 避免下次产生缩略图时大小不同，但被缓存了，取出来是缓存图片，所以要把kCGImageSourceShouldCache设为false
    imageSourceOptionKeys[0] = kCGImageSourceShouldCache;
    imageSourceOptionValues[0] = (CFTypeRef)kCFBooleanFalse;
    CFDictionaryRef imageSourceOptions = CFDictionaryCreate(NULL,
                                                            (const void **)imageSourceOptionKeys,
                                                            (const void **)imageSourceOptionValues, 1,
                                                            &kCFTypeDictionaryKeyCallBacks,
                                                            &kCFTypeDictionaryValueCallBacks);
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)url,
                                                              imageSourceOptions);
    
    // 取出图片的宽高最大值按比例缩放
    CGFloat maxDimension = MAX(pointSize.width, pointSize.height) *scale;
    NSNumber *maxDismensionNum = @(maxDimension);
    
    // 配置下采样信息
    CFStringRef downsampleOptionKeys[4];
    CFTypeRef downsampleOptionValues[4];
    // kCGImageSourceCreateThumbnailFromImageAlways：这个选项控制是否生成缩略图（没有设为true的话 kCGImageSourceThumbnailMaxPixelSize 以及 CGImageSourceCreateThumbnailAtIndex不会起作用）默认为false，所以需要设置为true
    downsampleOptionKeys[0] = kCGImageSourceCreateThumbnailFromImageAlways;
    downsampleOptionValues[0] = (CFTypeRef)kCFBooleanTrue;
    // kCGImageSourceShouldCacheImmediately：是否在创建图片时就进行解码（当然要这么做，避免在渲染时解码占用cpu）并缓存，
    downsampleOptionKeys[1] = kCGImageSourceShouldCacheImmediately;
    downsampleOptionValues[1] = (CFTypeRef)kCFBooleanTrue;
    // kCGImageSourceCreateThumbnailWithTransform：指定是否应根据完整图像的方向和像素纵横比旋转和缩放缩略图；设为true，因为我们要缩小他！
    downsampleOptionKeys[2] = kCGImageSourceCreateThumbnailWithTransform;
    downsampleOptionValues[2] = (CFTypeRef)kCFBooleanTrue;
    // kCGImageSourceThumbnailMaxPixelSize：指定缩略图的宽（如果缩略图的高大于宽，那就是高，哪个更大填哪个）
    downsampleOptionKeys[3] = kCGImageSourceThumbnailMaxPixelSize;
    downsampleOptionValues[3] = (__bridge CFNumberRef)maxDismensionNum;
    
    CFDictionaryRef dowsamplingOption = CFDictionaryCreate(NULL,
                                                           (const void **)downsampleOptionKeys,
                                                           (const void **)downsampleOptionValues,
                                                           4,
                                                           &kCFTypeDictionaryKeyCallBacks,
                                                           &kCFTypeDictionaryValueCallBacks);
    
    // 生成缩略图
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, dowsamplingOption);
    return [UIImage imageWithCGImage:imageRef];
}

@end
