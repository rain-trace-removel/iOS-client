//
//  LoginPageViewModel.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/12.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginPageViewModel.h"
#import "RTRDefine.h"
#import "RTRUserManager.h"
#import "RLog.h"

@implementation LoginPageViewModel

- (void)loginStyleChange:(RTRLoginStyle)chageStyle {
    self.loginStyle = chageStyle;
}

- (RTRResponseTypeCode)responseWhenClickedLoginButtonWithUserName:(NSString *)username
                                                                        password:(NSString *)password
                                                                 confirmPassword:(NSString *)confirmPassword
                                                          success:(void (^)(NSURLSessionDataTask *, id))success
                                                          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    if (rtr_isEmptyString(username)) {
        return RTRResponseTypeUsernameEmpty;
    }
    else if (rtr_isEmptyString(password)) {
        return RTRResponseTypePasswordEmpty;
    }
    else if (self.loginStyle == RTRLoginStyleRegister && confirmPassword != password) {
        return RTRResponseTypeConfirmPasswordNotMatch;
    }
    else if (self.loginStyle == RTRLoginStyleLogin) {
        [self requestLoginWithUserName:username
                              password:password
                       confirmPassword:confirmPassword
                               success:success
                               failure:failure
         ];
        return RTRResponseTypeRequesting;
    }
    else {
        [self requestRegisterWithUserName:username password:password confirmPassword:confirmPassword];
        return RTRResponseTypeRequesting;
    }
    return RTRResponseTypeRequesting;
}

- (void)requestLoginWithUserName:(NSString *)username
                        password:(NSString *)password
                 confirmPassword:(NSString *)confirmPassword
                         success:(void (^)(NSURLSessionDataTask *, id))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [[RTRUserManager rtr_shareManager] rtr_loginWithUsername:username
                                                    Password:password
                                                    progress:nil
                                                     success:^(NSURLSessionDataTask *task, id responseObject)
    {
        // user 单例修改状态
        [[RTRUserManager rtr_shareManager].user setName:username];
        [[RTRUserManager rtr_shareManager].user setToken:responseObject[@"token"]];
        [[RTRUserManager rtr_shareManager].user setHasLogin:YES];
        
        // 本地存储token
        [[NSUserDefaults standardUserDefaults] setObject:[RTRUserManager rtr_shareManager].user.token forKey:@"TOKEN"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        success(task, responseObject);
        rtr_log(@"login success!");
        rtr_log(responseObject);
        
    }
                                                     failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        failure(task, error);
        rtr_log(@"login failed!");
        rtr_log(error);
    }];
}

- (void)requestRegisterWithUserName:(NSString *)username password:(NSString *)password confirmPassword:(NSString *)confirmPassword {
    
}

@end
