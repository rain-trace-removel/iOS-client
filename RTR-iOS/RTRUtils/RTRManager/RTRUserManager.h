//
//  RTRUserManager.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/10.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

#define server_ip @"203.195.222.224"
#define server_port @"3000"
#define server_url_user_login @"/user/login"
#define server_url_user_register @"/user/signup"
#define server_url_user_info @"/user/info"
#define server_url_user_avatar @"/image/avatar"
#define server_default_avatar @"MTc2MjI0NjU3MTIwMDE4MDIxMDU="
#define default_fullpath_avatar @"http://203.195.222.224:3000/image/avatar/MTc2MjI0NjU3MTIwMDE4MDIxMDU=.png"
#define server_url_token_check @"/user/verification"


@interface RTRUserManager : NSObject

@property(nonatomic, strong) UserInfoModel *user;

+ (instancetype)rtr_shareManager;

- (BOOL)rtr_isLogin;

- (void)rtr_loginWithUsername:(NSString *)username
                     Password:(NSString *)password
                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)rtr_registerWithUsername:(NSString *)username
                     Password:(NSString *)password
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)rtr_getUserInfoWithUsername:(NSString *)username
                        Token:(NSString *)token
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)rtr_checkToken;

@end
