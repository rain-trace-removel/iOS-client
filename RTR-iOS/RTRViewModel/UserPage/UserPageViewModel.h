//
//  UserPageViewModel.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/10.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface UserPageViewModel : NSObject

@property(nonatomic, strong) UserInfoModel *userInfoModel;

+ (instancetype)shareInstance;


/// 向RTRUserManager请求请求获取用户头像
/// @param username 用户名
/// @param token 用户token
/// @param success 成功回调区块
/// @param failure 失败回调区块
- (void)requestGettingUserInfoWithBlockSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
