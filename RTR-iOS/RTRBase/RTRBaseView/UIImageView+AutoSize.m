//
//  UIImageView+AutoSize.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/16.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import "UIImageView+AutoSize.h"

@implementation UIImageView (AutoSize)

- (CGSize)setImageViewByImage:(UIImage *)image WithLimitWidth:(CGFloat)width andLimitHeight:(CGFloat)height {
    [self setImage:image];
    CGFloat imgWidth = CGImageGetWidth(image.CGImage);
    CGFloat imgHeight = CGImageGetHeight(image.CGImage);
    NSLog(@"cbcbcbcbbcbcb");
    CGFloat resizeWidth;
    CGFloat resizeHeight;
    if (width/imgWidth > height/imgHeight) {
        resizeHeight = height;
        resizeWidth = imgWidth * height / imgHeight;
    } else {
        resizeWidth = width;
        resizeHeight = imgHeight * width / imgWidth;
    }
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, resizeWidth, resizeHeight)];
    return CGSizeMake(resizeWidth, resizeHeight);
}

- (CGSize)testss {
    return CGSizeMake(12, 12);
}

@end
