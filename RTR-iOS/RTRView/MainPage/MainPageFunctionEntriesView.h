//
//  MainPageFunctionEntriesView.h
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageFunctionModel.h"

@interface MainPageFunctionEntriesView : UIView

@property(nonatomic, assign) CGFloat count_height;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)reloadViewWithModelArray:(NSMutableArray<MainPageFunctionModel *> *)modelArray itemsNumInOneLine:(NSUInteger)num;

- (void)fitCellFrame;

@end

