//
//  UIViewController+BackButtonHandler.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/12.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#ifndef UIViewController_BackButtonHandler_h
#define UIViewController_BackButtonHandler_h

#import <UIKit/UIKit.h>
@protocol BackButtonHandlerProtocol <NSObject>
    @optional
    // Override this method in UIViewController derived class to handle 'Back' button click
    -(BOOL)navigationShouldPopOnBackButton;
@end

@interface UIViewController (BackButtonHandler) <BackButtonHandlerProtocol>

@end

#endif /* UIViewController__BackButtonHandler_h */
