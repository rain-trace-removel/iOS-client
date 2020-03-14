//
//  LoginPageViewModel.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/12.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RTRLoginStyleLogin,
    RTRLoginStyleRegister,
} RTRLoginStyle;

typedef enum : NSUInteger {
    RTRResponseTypeUsernameEmpty,
    RTRResponseTypeUsernameInvalid,
    RTRResponseTypePasswordEmpty,
    RTRResponseTypePasswordInvalid,
    RTRResponseTypeConfirmPasswordNotMatch,
    RTRResponseTypeRequesting,
    RTRResponseTypeLoginFailed,
    RTRResponseTypeRegisterFailed,
    RTRResponseTypeLoginSuccessed,
    RTRResponseTypeRegisterSuccessed,
} RTRResponseTypeCode;


@interface LoginPageViewModel : NSObject

@property(nonatomic, weak) id holdVC;
@property(nonatomic, assign) RTRLoginStyle loginStyle;

- (void)loginStyleChange:(RTRLoginStyle)chageStyle;

/// 响应登录注册界面的响应函数：主要操作为申请注册或申请登录
/// @param username 用户名
/// @param password 用户密码
/// @param confirmPassword 用户二次输入的验证密码
/// @param success 成功回调区块
/// @param failure 失败回调区块
- (RTRResponseTypeCode)responseWhenClickedLoginButtonWithUserName:(NSString *)username
                                                         password:(NSString *)password
                                                  confirmPassword:(NSString *)confirmPassword
                                                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/// 向RTRUserManager请求注册（内部注册完毕会自行调用一次网络请求登录）（<---这也是有一点不合理的地方，后续有时间修改）
/// @param username 用户名
/// @param password 用户密码
/// @param confirmPassword 用户二次输入的验证密码
/// @param success 成功回调block
/// @param failure 失败回调block
- (void)requestRegisterWithUserName:(NSString *)username
                           password:(NSString *)password
                    confirmPassword:(NSString *)confirmPassword
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



/// 向RTRUserManager请求登录
/// @param username 用户名
/// @param password 用户密码
/// @param confirmPassword 用户二次输入的验证密码
/// @param success 成功回调block
/// @param failure 失败回调block
- (void)requestLoginWithUserName:(NSString *)username
                        password:(NSString *)password
                 confirmPassword:(NSString *)confirmPassword
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



@end
