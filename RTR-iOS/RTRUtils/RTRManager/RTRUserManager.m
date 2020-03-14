//
//  RTRUserManager.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/10.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import "RTRUserManager.h"
#import "UserInfoModel.h"
#import <AFNetworking.h>

#define server_ip @"203.195.222.224"
#define server_port @"3000"
#define server_url_user_login @"/user/login"

static RTRUserManager *userManager = nil;

@interface RTRUserManager()

@end

@implementation RTRUserManager

+ (instancetype)rtr_shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [[self alloc] init];
    });
    return userManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.user = [[UserInfoModel alloc] init];
    }
    return self;
}

- (BOOL)rtr_isLogin {
    return self.user.hasLogin;
}


- (void)rtr_loginWithUsername:(NSString *)username
                     Password:(NSString *)password
                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"http://%@:%@%@", server_ip, server_port, server_url_user_login];
    NSDictionary *parameters = @{@"username": username,
                                 @"password": password};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求体为JSON
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置响应体为JSON
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id responseObject = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
        failure(task, responseObject);
    }];
}

@end
