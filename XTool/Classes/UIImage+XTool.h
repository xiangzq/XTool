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
/// 图片压缩   maxSize单位为KB
- (UIImage *) compressImageByMaxSize:(NSInteger)maxSize;
/// 图片压缩   maxSize单位为KB
- (NSData *) compressImageDataByMaxSize:(NSInteger)maxSize;
@end

NS_ASSUME_NONNULL_END
