//
//  DerainEditPageViewModel.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/16.
//  Copyright © 2020 chenbb6. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface DerainEditPageViewModel : NSObject

@property(nonatomic, strong) UIImage *original_image;
@property(nonatomic, strong) UIImage *derain_image;

/// 向Derain Net请求去雨
/// @param token 用户登录态的token
/// @param image 待处理去雨的uiimage
/// @param processProgress 处理进度回调区块
/// @param success 成功回调区块
/// @param failure 失败回调区块
- (void)requestImageDerainWithToken:(NSString *)token
                              Image:(UIImage *)image
                           progress:(nullable void (^)(NSProgress *progress))processProgress
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
