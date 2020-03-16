//
//  CameraPageViewModel.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/17.
//  Copyright © 2020 chenbb6. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>

@interface CameraPageViewModel : NSObject


+ (AVAuthorizationStatus)cameraAuthorizationStatusAuthorized;

+ (void)requestCameraAuthorizationWithCompletion:(void (^)(BOOL granted))completion;

@end
