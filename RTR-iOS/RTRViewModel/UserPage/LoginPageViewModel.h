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

@property(nonatomic, assign) RTRLoginStyle loginStyle;

- (void)loginStyleChange:(RTRLoginStyle)chageStyle;

- (RTRResponseTypeCode)responseWhenClickedLoginButtonWithUserName:(NSString *)username password:(NSString *)password confirmPassword:(NSString *)confirmPassword;

@end
