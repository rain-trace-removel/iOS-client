//
//  RTRImgDerainNet.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/12.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RTRImgDerainNetDelegate <NSObject>

@required
- (void)didFinishedImageDerain:(BOOL)success withDerainedImage:(UIImage *)image;

@end

@interface RTRImgDerainNet : NSObject

@property (nonatomic, weak) id<RTRImgDerainNetDelegate> delegate;

- (void)rtr_ImageDerainProcess;

@end
