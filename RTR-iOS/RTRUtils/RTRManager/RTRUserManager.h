//
//  RTRUserManager.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/10.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserInfoModel.h"

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

@end
