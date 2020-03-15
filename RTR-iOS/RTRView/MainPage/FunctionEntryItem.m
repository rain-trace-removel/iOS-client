//
//  FunctionEntryItem.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunctionEntryItem.h"
#import "RTRDefine.h"

@interface FunctionEntryItem ()

@property(nonatomic, strong)MainPageFunctionModel *model;

@end

@implementation FunctionEntryItem

- (instancetype)initWithFrame:(CGRect)frame andModel:(MainPageFunctionModel *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        self.model = model;
        [self setBackgroundColor:randomColor];
    }
    return self;
}

@end
