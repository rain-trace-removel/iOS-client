//
//  MainPageFunctionEntriesView.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/15.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainPageFunctionEntriesView.h"
#import "MainPageViewModel.h"
#import "FunctionEntryItem.h"

#define margin_left 25
#define margin_right 25
#define margin_top 20
#define margin_bottom 20
#define margin_cell_hor 20
#define margin_cell_ver 15
#define default_num_in_one_line 3

@interface MainPageFunctionEntriesView ()

@end

@implementation MainPageFunctionEntriesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.count_height = 0;
        [self reloadViewWithModelArray:[MainPageViewModel shareInstance].functionModuleArray itemsNumInOneLine:default_num_in_one_line];
    }
    return self;
}

#pragma mark Public

- (void)reloadViewWithModelArray:(NSMutableArray<MainPageFunctionModel *> *)modelArray itemsNumInOneLine:(NSUInteger)num {
    
    for(UIView *view in self.subviews){
        [view removeFromSuperview];
    }
    
    CGFloat totalNum = modelArray.count;
    NSInteger line = ceil(totalNum / num);
    
    CGFloat cell_width = (self.frame.size.width - margin_left - margin_right - (num-1)*margin_cell_hor) / num;
    
    for (int i = 0; i < line; i++) {
        for (int j = 0; j < num; j++) {
            NSInteger count = i * num + j;
            if (count < (NSInteger)totalNum) {
                CGFloat x = margin_left + j * (cell_width + margin_cell_hor);
                CGFloat y = margin_top + i * (cell_width + margin_cell_ver);
                FunctionEntryItem *item = [[FunctionEntryItem alloc] initWithFrame:CGRectMake(x, y, cell_width, cell_width) andModel:[modelArray objectAtIndex:count]];
                [self addSubview:item];
            }
        }
    }
    self.count_height = margin_top + line * cell_width + (line-1) * margin_cell_ver + margin_bottom;
    [self fitCellFrame];
}

#pragma mark Private

- (void)fitCellFrame {
    CGRect cell_frame = self.frame;
    cell_frame.size.height = self.count_height;
    [self setFrame:cell_frame];
}

@end
