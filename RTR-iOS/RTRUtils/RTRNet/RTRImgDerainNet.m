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

- (void)rtr_ImageDerainProcess {
    UIImage *image = [UIImage imageNamed:@"test1"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSString *url = @"http://203.195.222.224:5000/image/derain";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求体和响应体为JSON
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
//    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json", @"text/json", @"text/javascript",@"text/html", "image/jpg", nil]];
    NSSet *set = [[NSSet alloc] initWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"image/jpg", nil];
    [manager.responseSerializer setAcceptableContentTypes:set];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", "image/jpg", nil];
    
    // 添加cookie
//    NSString *cookieStr = [NSString stringWithFormat:@"Bearer %@", [[User getInstance] getToken]];
//    [manager.requestSerializer setValue: cookieStr forHTTPHeaderField:@"Authorization"];
    // 使用表单提交
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    // 发起post请求
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"uploadfile" fileName:@"test1.jpg" mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"[cbb] rtr_ImageDerainProcess success");
        if ([_delegate respondsToSelector:@selector(didFinishedImageDerain:withDerainedImage:)]) {
            [_delegate didFinishedImageDerain:YES withDerainedImage:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[cbb] rtr_ImageDerainProcess failed");
        if ([_delegate respondsToSelector:@selector(didFinishedImageDerain:withDerainedImage:)]) {
            [_delegate didFinishedImageDerain:NO withDerainedImage:nil];
        }
    }];
//    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:iconData name:@"file" fileName:@"jmf.png" mimeType:@"image/png"];
//        NSData *username = [name dataUsingEncoding:NSUTF8StringEncoding];
//        [formData appendPartWithFormData:username name:@"username"];
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        // 修改头像成功
//        NSString *avatar = responseObject[@"avatar"];
//        self.userIconUrl = [[@"http://localhost:3000/image/avatar/" stringByAppendingString:avatar] stringByAppendingString:@".png"];
//        NSLog(@"[LOG] change icon url to :%@", self.userIconUrl);
//        [[UIApplication sharedApplication].keyWindow yb_showHookTipView:@"头像修改成功"];
//        return image;
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [[UIApplication sharedApplication].keyWindow yb_showHookTipView:@"头像修改失败"];
//        return nil;
//    }];
    
}

@end

