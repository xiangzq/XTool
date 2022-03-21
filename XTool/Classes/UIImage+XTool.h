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

//MARK: 图片下采样，生成缩略图
@interface UIImage (XDownsample)
/**
 * 根据图片URL进行下采样生成缩略图
 * @Param url 图片url
 * @Param pointSize 图片大小
 * @Param scale 缩放比例
 */
+ (UIImage *) downsampleWithImageURL:(NSURL *) url PointSize:(CGSize) pointSize Scale:(CGFloat) scale;
@end

NS_ASSUME_NONNULL_END
