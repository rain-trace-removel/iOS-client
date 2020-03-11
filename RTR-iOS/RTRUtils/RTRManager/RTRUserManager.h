//
//  RTRUserManager.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/10.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTRUserManager : NSObject

+ (instancetype)rtr_shareManager;

- (BOOL)rtr_isLogin;

@end
