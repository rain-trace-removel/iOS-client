//
//  RTRImgDerainNet.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/12.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define derain_net_server_ip @"203.195.222.224"
#define derain_net_server_port @"5000"
#define derain_net_url_derain @"/image/derain"

@interface RTRImgDerainNet : NSObject

/// 网络请求图片去雨
/// @param token 用户登录态的token
/// @param image 待处理去雨的uiimage
/// @param processProgress 处理进度回调区块
/// @param success 成功回调区块
/// @param failure 失败回调区块
+ (void)rtr_ImageDerainWithToken:(NSString *)token
                           Image:(UIImage *)image
                        progress:(nullable void (^)(NSProgress *progress))processProgress
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
