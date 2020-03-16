//
//  RTRImgDerainNet.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/12.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import "RTRImgDerainNet.h"
#import <AFNetworking.h>

@interface RTRImgDerainNet()

@end

@implementation RTRImgDerainNet

+ (void)rtr_ImageDerainWithToken:(NSString *)token
                           Image:(UIImage *)image
                        progress:(void (^)(NSProgress *))processProgress
                         success:(void (^)(NSURLSessionDataTask *, id))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSString *url = [NSString stringWithFormat:@"http://%@:%@%@", derain_net_server_ip, derain_net_server_port, derain_net_url_derain];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求体和响应体为JSON
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    NSSet *set = [[NSSet alloc] initWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"image/jpg", nil];
    [manager.responseSerializer setAcceptableContentTypes:set];
    
    // 添加cookie
    NSString *cookieStr = [NSString stringWithFormat:@"Bearer %@", token];
    [manager.requestSerializer setValue: cookieStr forHTTPHeaderField:@"Authorization"];
    // 使用表单提交
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    // 发起post请求
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"uploadfile" fileName:@"test1.jpg" mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        processProgress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
    }];
}

@end

