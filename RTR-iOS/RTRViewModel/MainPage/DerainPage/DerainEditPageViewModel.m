//
//  DerainEditPageViewModel.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/16.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DerainEditPageViewModel.h"

@implementation DerainEditPageViewModel

- (instancetype)initWithOriginalImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.original_image = image;
    }
    return self;
}

@end
