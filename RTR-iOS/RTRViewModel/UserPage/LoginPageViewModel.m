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

@implementation LoginPageViewModel

- (void)loginStyleChange:(RTRLoginStyle)chageStyle {
    self.loginStyle = chageStyle;
}

- (RTRResponseTypeCode)responseWhenClickedLoginButtonWithUserName:(NSString *)username
                                                                        password:(NSString *)password
                                                                 confirmPassword:(NSString *)confirmPassword
{
    if (rtr_isEmptyString(username)) {
        return RTRResponseTypeUsernameEmpty;
    } else if (rtr_isEmptyString(password)) {
        return RTRResponseTypePasswordEmpty;
    } else if (self.loginStyle == RTRLoginStyleRegister && confirmPassword != password) {
        return RTRResponseTypeConfirmPasswordNotMatch;
    } else if (self.loginStyle == RTRLoginStyleLogin) {
        [self requestLoginWithUserName:username password:password confirmPassword:confirmPassword];
    } else {
        [self requestRegisterWithUserName:username password:password confirmPassword:confirmPassword];
    }
    return RTRResponseTypeRequesting;
}

- (void)requestLoginWithUserName:(NSString *)username password:(NSString *)password confirmPassword:(NSString *)confirmPassword {
    
}

- (void)requestRegisterWithUserName:(NSString *)username password:(NSString *)password confirmPassword:(NSString *)confirmPassword {
    
}

@end
