//
//  UIImage+XTool.h
//  Pods-XTool_Example
//
//  Created by 项正强 on 2021/1/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (XTool)

@end

@interface UIImage (XCompression)
/// 图片压缩   
- (UIImage *) compressImageByMaxKB:(NSUInteger) kb;
/// 图片压缩
- (NSData *) compressImageDataByMaxKB:(NSUInteger) kb;

@end

@interface UIImage (XSize)
///// 根据图片名称获取图片大小
//+ (CGSize) getImageSizeByName:(NSString *) name;
///// 根据图片获取图片大小
//+ (CGSize) getImageSizeByImage:(UIImage *) image;
@end

NS_ASSUME_NONNULL_END
