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

/// 图片压缩
- (UIImage *) compressImageByMaxSize:(NSInteger)maxSize {
    return [UIImage imageWithData:[self compressImageDataByMaxSize:maxSize]];
}

/// 图片压缩
- (NSData *) compressImageDataByMaxSize:(NSInteger)maxSize {
    NSData *imageData          = UIImagePNGRepresentation(self);
    NSUInteger originalSize    = imageData.length;
    NSUInteger originalSizeKB  = originalSize / 1000;
    NSLog(@"当前原图片大小：%ld KB",originalSizeKB);
    /// 判断图片大小是否超过限制
    if (originalSizeKB <= maxSize) return imageData;
    
    CGFloat sourceImageAspectRatio = self.size.width/self.size.height;
    CGSize defaultSize             = CGSizeMake(1024, 1024/sourceImageAspectRatio);
    UIImage *newImage              = [self __newSizeImage:defaultSize image:self];
    imageData                      = UIImagePNGRepresentation(newImage);
    
    /// 保存压缩系数
    NSMutableArray *compressionQualities = [NSMutableArray array];
    CGFloat avg   = 1.0/250;
    CGFloat value = avg;
    for (int i = 250; i >= 1; i--) {
        value = i*avg;
        [compressionQualities addObject:@(value)];
    }
    /// 使用二分法搜索 调整大小 说明：压缩系数数组compressionQualities是从大到小存储。
    imageData = [self __dichotomy:compressionQualities image:newImage imageData:imageData maxSize:maxSize];
    // 如果还是未能压缩到指定大小，则进行降分辨率
    while (imageData.length == 0) {
        //每次降100分辨率
        CGFloat reduceWidth = 100.0;
        CGFloat reduceHeight = 100.0/sourceImageAspectRatio;
        if (defaultSize.width-reduceWidth <= 0 || defaultSize.height-reduceHeight <= 0) break;
        defaultSize = CGSizeMake(defaultSize.width-reduceWidth, defaultSize.height-reduceHeight);
        UIImage *image = [self __newSizeImage:defaultSize image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage,[[compressionQualities lastObject] floatValue])]];
        imageData = [self __dichotomy:compressionQualities image:image imageData:UIImagePNGRepresentation(image) maxSize:maxSize];
    }
    NSLog(@"压缩后图片大小：%ld",imageData.length);
    return imageData;
}

/// 调整图片分辨率/尺寸（等比例缩放）
- (UIImage *) __newSizeImage:(CGSize)size
                       image:(UIImage *)sourceImage {
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    CGFloat tempHeight = newSize.height / size.height;
    CGFloat tempWidth = newSize.width / size.width;
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/// 二分法
- (NSData *) __dichotomy:(NSArray *) compressionQualities
                   image:(UIImage *) image
               imageData:(NSData *) imageData
                 maxSize:(NSInteger) maxSize {
    NSData *tempData      = [NSData data];
    NSUInteger start      = 0;
    NSUInteger end        = compressionQualities.count - 1;
    NSUInteger index      = 0;
    NSUInteger difference = NSIntegerMax;
    while(start <= end) {
        index     = start + (end - start)/2;
        imageData = UIImageJPEGRepresentation(image,[compressionQualities[index] floatValue]);
        NSUInteger originalSize   = imageData.length;
        NSUInteger originalSizeKB = originalSize / 1024;
        NSLog(@"当前降到的质量：%ld", (unsigned long)originalSize);
        NSLog(@"\nstart：%zd\nend：%zd\nindex：%zd\n压缩系数：%lf", start, end, (unsigned long)index, [compressionQualities[index] floatValue]);
        if (originalSizeKB > maxSize) {
            start = index + 1;
        } else if (originalSizeKB < maxSize) {
            if (maxSize - originalSizeKB < difference) {
                difference = maxSize - originalSizeKB;
                tempData = imageData;
            }
            if (index <= 0) break;
            end = index - 1;
        } else {
            break;
        }
    }
    return tempData;
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
