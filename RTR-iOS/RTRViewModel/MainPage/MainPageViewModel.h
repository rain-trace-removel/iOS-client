//
//  MainPageViewModel.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MainPageFunctionModel.h"

#ifndef MainPageViewModel_h
#define MainPageViewModel_h


@interface MainPageViewModel : NSObject

+ (instancetype)shareInstance;

@property(nonatomic, strong) NSMutableArray<MainPageFunctionModel *> *functionModuleArray;
@property(nonatomic, strong) NSMutableArray *mainPageModelArrArray;

@end

#endif /* MainPageViewModel_h */
