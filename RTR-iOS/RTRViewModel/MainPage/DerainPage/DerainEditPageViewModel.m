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
#import "RTRImgDerainNet.h"

@implementation DerainEditPageViewModel

- (instancetype)initWithOriginalImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.original_image = image;
    }
    return self;
}

- (void)requestImageDerainWithToken:(NSString *)token
                              Image:(UIImage *)image
                           progress:(void (^)(NSProgress *))processProgress
                            success:(void (^)(NSURLSessionDataTask *, id))success
                            failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [RTRImgDerainNet rtr_ImageDerainWithToken:token
                                        Image:image
                                     progress:^(NSProgress *progress)
    {
        processProgress(progress);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

@end
