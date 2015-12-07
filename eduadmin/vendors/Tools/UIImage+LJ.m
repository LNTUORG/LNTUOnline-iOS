//
//  UIImage+LJ.m
//  eduadmin
//
//  Created by Li Jie on 12/7/15.
//  Copyright © 2015 PUPBOSS. All rights reserved.
//

#import "UIImage+LJ.h"

@implementation UIImage (LJ)

+ (instancetype)imageWithIcon:(UIImage *)image borderWidth:(NSInteger)borderWidth borderColor:(UIColor *)borderColor {

    
    CGSize size = CGSizeMake(image.size.width + borderWidth, image.size.height + borderWidth);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
    
    CGContextClip(context);
    
    [borderColor set];
    
    CGFloat iconX = borderWidth / 2;
    CGFloat iconY = borderWidth / 2;
    CGFloat iconW = image.size.width;
    CGFloat iconH = image.size.height;
    
    
    CGContextAddEllipseInRect(context, CGRectMake(iconX, iconY, iconW, iconH));
    
    CGContextClip(context);
    
    [image drawInRect:CGRectMake(iconX, iconY, iconW, iconH)];
    
    UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return iconImage;
}

@end
