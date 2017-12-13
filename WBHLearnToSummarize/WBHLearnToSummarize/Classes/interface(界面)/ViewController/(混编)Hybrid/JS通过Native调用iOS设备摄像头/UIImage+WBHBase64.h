//
//  UIImage+WBHBase64.h
//  WBHLearnToSummarize
//
//  Created by hjy on 2017/12/13.
//  Copyright © 2017年 baohong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WBHBase64)

- (NSData *)compressDatatoMaxPicSize:(NSInteger)maxPicSize;
- (NSString *)getBase64DataStr;

+ (UIImage *)getImageFromBase64:(NSString *)imgBase64;
+ (UIImage *)getImageWithView:(UIView *)view;

@end
