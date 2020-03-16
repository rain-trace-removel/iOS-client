//
//  CameraPageViewModel.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/17.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CameraPageViewModel.h"

@implementation CameraPageViewModel

+ (AVAuthorizationStatus)cameraAuthorizationStatusAuthorized {
    return [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
}

+ (void)requestCameraAuthorizationWithCompletion:(void (^)(BOOL granted))completion {
    void (^callCompletionBlock)(BOOL) = ^(BOOL granted){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(granted);
            }
        });
    };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            callCompletionBlock(granted);
        }];
    });
}

@end
