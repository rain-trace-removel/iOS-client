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
#import "RTRDefine.h"
#import "RLog.h"
#import "YBImageBrowserTipView.h"

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
        self.userProfile = [[UserProfileModel alloc] init];
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
        failure(task, error);
    }];
}

- (void)rtr_registerWithUsername:(NSString *)username
                        Password:(NSString *)password
                         success:(void (^)(NSURLSessionDataTask *, id))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"http://%@:%@%@", server_ip, server_port, server_url_user_register];
    NSDictionary *parameters = @{@"username": username,
                                 @"password": password,
                                 @"telephone": @"123"
    };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求体为JSON
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置响应体为JSON
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:url
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        failure(task, error);
    }];
}

- (void)rtr_getUserInfoWithUsername:(NSString *)username
                            Token:(NSString *)token
                          success:(void (^)(NSURLSessionDataTask *, id))success
                          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"http://%@:%@%@/%@", server_ip, server_port, server_url_user_info, username];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求体和响应体为JSON
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 添加cookie-token
    NSString *cookieStr = [NSString stringWithFormat:@"Bearer %@", token];
    [manager.requestSerializer setValue: cookieStr forHTTPHeaderField:@"Authorization"];
    
    [manager GET:url
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        success(task, responseObject);
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        failure(task, error);
    }];
}

- (void)rtr_checkToken {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if(token != nil) {
        NSString *str = [NSString stringWithFormat:@"Get Local TOKEN: %@", token];
        [self verifyToken:token];
        rtr_log(str);
    }
    else {
        rtr_log(@"Get Local Token Failed");
    }
}

- (void)verifyToken:(NSString *)token {
    NSString *url = [NSString stringWithFormat:@"http://%@:%@%@", server_ip, server_port, server_url_token_check];
    NSDictionary *parameters = @{@"token": token};
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    // 设置请求体为JSON
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置响应体为JSON
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    [manage POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.user.name = responseObject[@"username"];
        self.user.token = token;
        self.user.hasLogin = YES;
        rtr_log(responseObject);
        [[UIApplication sharedApplication].keyWindow yb_showHookTipView:[NSString stringWithFormat:@"欢迎回来, %@", self.user.name]];
    } failure:nil];
}

@end
