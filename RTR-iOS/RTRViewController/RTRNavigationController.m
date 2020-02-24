//
//  RTRNavigationController.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/2/24.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTRNavigationController.h"
#import "RTRTabBarController.h"

@interface RTRNavigationController()

@end

# pragma mark Life cycle
@implementation RTRNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}


# pragma mark Private
- (void)setupView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self pushViewController:[[RTRTabBarController alloc] init] animated:YES];
    [self setNavigationBarHidden:YES animated:NO];
}

@end
