//
//  MainPageFunctionModel.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainPageFunctionModel.h"

@interface MainPageFunctionModel()

@end

@implementation MainPageFunctionModel

- (instancetype)initWithIcon:(NSString *)icon Title:(NSString *)title Type:(FunctionModelType)type {
    self = [super init];
    if (self) {
        self.icon = icon;
        self.title = title;
        self.type = type;
    }
    return self;
}


@end
