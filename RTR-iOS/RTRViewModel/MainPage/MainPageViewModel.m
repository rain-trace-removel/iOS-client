//
//  MainPageViewModel.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainPageViewModel.h"

static MainPageViewModel *mainPageViewModel = nil;

@interface MainPageViewModel ()

@end

@implementation MainPageViewModel

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainPageViewModel = [[self alloc] init];
    });
    return mainPageViewModel;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mainPageModelArrArray = [NSMutableArray array];
        [self initData];
    }
    return self;
}

- (void)initData {
    MainPageFunctionModel *m1 = [[MainPageFunctionModel alloc] initWithIcon:@"icon_app" Title:@"相机拍摄" Type:TypePCameraPhoto];
    MainPageFunctionModel *m2 = [[MainPageFunctionModel alloc] initWithIcon:@"icon_app" Title:@"图像编辑" Type:TypePictureEdit];
    MainPageFunctionModel *m3 = [[MainPageFunctionModel alloc] initWithIcon:@"icon_app" Title:@"视频编辑" Type:TypePCameraPhoto];
    MainPageFunctionModel *m4 = [[MainPageFunctionModel alloc] initWithIcon:@"icon_app" Title:@"图像去雨" Type:TypePCameraPhoto];
    MainPageFunctionModel *m5 = [[MainPageFunctionModel alloc] initWithIcon:@"icon_app" Title:@"图像边框" Type:TypePCameraPhoto];
    MainPageFunctionModel *m6 = [[MainPageFunctionModel alloc] initWithIcon:@"icon_app" Title:@"VIP SERVICE" Type:TypePCameraPhoto];
    self.functionModuleArray = [NSMutableArray arrayWithArray:@[m1,m2,m3,m4,m5,m6]];
    [self.mainPageModelArrArray addObject:self.functionModuleArray];

}

@end
