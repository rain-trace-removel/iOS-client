//
//  UITabBarController+Base.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/2/25.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import "UITabBarController+Base.h"
#import "../RTRDefine.h"
#import "Colours.h"
#import <objc/runtime.h>
#import "UIView+Shadow.h"
#import "Masonry/Masonry.h"


@implementation UITabBarController (Base)

- (void)viewDidLoad {
    [super viewDidLoad];
    [self rtr_initialize];
    [self rtr_loadView];
}

- (void)rtr_initialize {
    self.RTRTabBarItemArray = [[NSMutableArray alloc] initWithCapacity:4];
}

- (void)rtr_loadView {
    [self.view addSubview:self.RTRTabBar];
}

- (void)reloadViewWithTags:(NSMutableArray *)tags Images:(NSMutableArray *)images VCArray:(nonnull NSMutableArray *)VCArray {
    self.tabBarItemTags = tags;
    self.tabBarItemImages = images;
    self.tabPageVCArray = VCArray;
    [self setViewControllers:VCArray];
    
    [self.RTRTabBar setBackgroundColor:[UIColor whiteColor]];
    [self.RTRTabBar.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 位置计算
    NSUInteger tabBarItemNum = self.tabBarItemTags.count;
    CGFloat tabBarItemHeight = TABBAR_HEIGHT;
    CGFloat tabBarItemWidth = SCREEN_WIDTH / tabBarItemNum;

    // TabBar 顶部阴影
    [UIView addTopSideShadowToView:self.RTRTabBar withColor:[UIColor grayColor]];
    
    // TabBar 移动视觉白块
    [self.whiteBlock setBackgroundColor:[UIColor whiteColor]];
    [self.whiteBlock.layer setCornerRadius:5];
    [UIView addShadowToView:self.whiteBlock withColor:[UIColor lightGrayColor]];
    [self.RTRTabBar addSubview:self.whiteBlock];
    [self.whiteBlock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tabBar.mas_left).offset(tabBarItemWidth/2);
        make.top.mas_equalTo(SCREEN_HEIGHT-TABBAR_HEIGHT).offset(-5);
        make.width.mas_equalTo(@48);
        make.height.mas_equalTo(@72);
    }];
    
    // TabBarItem 添加
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.tabBarItemTags.count; i++) {
        RTRTabBarItem *tabBarItem = [[RTRTabBarItem alloc] initWithFrame:CGRectMake(i * tabBarItemWidth, 0, tabBarItemWidth, tabBarItemHeight) tag:self.tabBarItemTags[i] icon:self.tabBarItemImages[i] index:i];
        tabBarItem.delegate = self;
        tabBarItem.tag = i;
        [mArr addObject:tabBarItem];
        
        if (i == 0) {
            [tabBarItem setSelected:YES];
        }
        
        [self.RTRTabBar addSubview:tabBarItem];
    }
    self.RTRTabBarItemArray = mArr;
    NSLog(@"reload view: %@, %@", self.tabBarItemTags, self.tabBarItemImages);
    
}

#pragma mark RTRTabBarItemDelegate

- (void)didSelectedTabBarItemAtIndex:(NSUInteger)index WithTag:(NSString *)tag {
    NSLog(@"didSelectedTabBarItemWithTag:%@", tag);
    NSLog(@"RTRTabBarItemArray:%@", self.RTRTabBarItemArray);
    // tabbar item 选择
    for (RTRTabBarItem *selectedTabBarItem in self.RTRTabBarItemArray) {
        if (selectedTabBarItem.tag == index) {
            [selectedTabBarItem setSelected:YES];
        } else {
            [selectedTabBarItem setSelected:NO];
        }
    }
    // 视觉白块动画
    CGFloat tabBarItemWidth = SCREEN_WIDTH / self.tabBarItemTags.count;
    [UIView animateWithDuration:0.2 animations:^{
        [self.whiteBlock mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.tabBar.mas_left).offset(tabBarItemWidth/2 + index * tabBarItemWidth);
        }];
        [self.whiteBlock.superview layoutIfNeeded];
    }];
    // vc 跳转
    [self setSelectedIndex:index];
}

#pragma mark - Category Property Getter & Setter

- (UIView *)RTRTabBar {
    UIView *rtr_tabBar = objc_getAssociatedObject(self, @selector(RTRTabBar));
    if (rtr_tabBar == nil) {
        rtr_tabBar = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-TABBAR_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT)];
        objc_setAssociatedObject(self, @selector(RTRTabBar), rtr_tabBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return rtr_tabBar;
}

- (void)setRTRTabBar:(UIView *)RTRTabBar {
    objc_setAssociatedObject(self, @selector(RTRTabBar), RTRTabBar, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableArray *)tabBarItemTags {
    return objc_getAssociatedObject(self, @selector(tabBarItemTags));
}

- (void)setTabBarItemTags:(NSMutableArray *)tabBarItemTags {
    objc_setAssociatedObject(self, @selector(tabBarItemTags), tabBarItemTags, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableArray *)tabBarItemImages {
    return objc_getAssociatedObject(self, @selector(tabBarItemImages));
}

- (void)setTabBarItemImages:(NSMutableArray *)tabBarItemImages {
    objc_setAssociatedObject(self, @selector(tabBarItemImages), tabBarItemImages, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableArray *)RTRTabBarItemArray {
    return objc_getAssociatedObject(self, @selector(RTRTabBarItemArray));
}

- (void)setRTRTabBarItemArray:(NSMutableArray *)RTRTabBarItemArray {
    objc_setAssociatedObject(self, @selector(RTRTabBarItemArray), RTRTabBarItemArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableArray *)tabPageVCArray {
    return objc_getAssociatedObject(self, @selector(tabPageVCArray));
}

- (void)setTabPageVCArray:(NSMutableArray *)tabPageVCArray {
    objc_setAssociatedObject(self, @selector(tabPageVCArray), tabPageVCArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIView *)whiteBlock {
    UIView *block = objc_getAssociatedObject(self, @selector(whiteBlock));
    if (block == nil) {
        block = [[UIView alloc] init];
        objc_setAssociatedObject(self, @selector(whiteBlock), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return block;
}

- (void)setWhiteBlock:(UIView *)whiteBlock {
    objc_setAssociatedObject(self, @selector(whiteBlock), whiteBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)dealloc {
    objc_removeAssociatedObjects(self);
    NSLog(@"[cbb] remove associated");
}



@end
