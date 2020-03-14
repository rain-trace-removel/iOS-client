//
//  UserPageViewModel.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/10.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import "UserPageViewModel.h"
#import "RTRUserManager.h"
#import "RTRDefine.h"
#import "RLog.h"

static UserPageViewModel *userPageViewModel = nil;

@implementation UserPageViewModel

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userPageViewModel = [[self alloc] init];
    });
    return userPageViewModel;
}

- (void)requestGettingUserInfoWithBlockSuccess:(void (^)(NSURLSessionDataTask *, id))success
                                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    // 用户未登录
    if (rtr_isEmptyString([RTRUserManager rtr_shareManager].user.token)) {
        rtr_log(@"get user info failed because user didn't login!");
        return;
    }
    // 用户信息已完备
    if (!rtr_isEmptyString([RTRUserManager rtr_shareManager].user.avatar)) {
        rtr_log(@"get user info failed because user has got already!");
        return;
    }
    
    // 用户信息不完备且已登录则拉取
    [[RTRUserManager rtr_shareManager] rtr_getUserInfoWithUsername:[RTRUserManager rtr_shareManager].user.name
                                                           Token:[RTRUserManager rtr_shareManager].user.token
                                                         success:^(NSURLSessionDataTask *task, id responseObject)
    {
        // 成功回调
        NSDictionary *userInfoDic = responseObject[@"username"];
        NSString *avatar = (NSString *)[userInfoDic objectForKey:@"avatar"];
        if(rtr_isEmptyString(avatar)) {
            // 没有设置过头像
            [[RTRUserManager rtr_shareManager].user setAvatar: [NSString stringWithFormat:@"http://%@:%@%@/%@.png", server_ip, server_port, server_url_user_avatar, server_default_avatar]];
        } else {
            // 有设置过头像
            [[RTRUserManager rtr_shareManager].user setAvatar: [NSString stringWithFormat:@"http://%@:%@%@/%@.png", server_ip, server_port, server_url_user_avatar, [RTRUserManager rtr_shareManager].user.name]];
        }
        success(task, responseObject);
        rtr_log(@"get user info success!");
        rtr_log(responseObject);
    }
                                                         failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        failure(task, error);
        rtr_log(@"get user info failed!");
        rtr_log(error);
    }];
}

@end
