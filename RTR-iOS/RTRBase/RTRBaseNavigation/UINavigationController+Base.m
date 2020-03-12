//
//  UINavigationController+Base.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/2/24.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import "UINavigationController+Base.h"
#import "UIViewController+BackButtonHandler.h"

@implementation UINavigationController (Base)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem*)item {
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }

    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }

    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }

    return NO;
}


@end
