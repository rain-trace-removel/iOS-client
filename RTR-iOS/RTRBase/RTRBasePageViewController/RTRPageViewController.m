//
//  RTRPageViewController.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/16.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTRPageViewController.h"
#import "RTRDefine.h"
#import "Colours.h"
#import <objc/runtime.h>
#import "UIView+Shadow.h"
#import "Masonry/Masonry.h"

@interface RTRPageViewController() <UIPageViewControllerDelegate, UIPageViewControllerDataSource, RTRTabBarItemDelegate>


@property(nonatomic, assign) NSInteger currentIndex;
@property(nonatomic, strong) UIViewController *pendvc;

@end

@implementation RTRPageViewController

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
    self.tabBarItemTags = [NSMutableArray arrayWithArray:tags];
    self.tabBarItemImages = [NSMutableArray arrayWithArray:images];
    self.tabPageVCArray = [NSMutableArray arrayWithArray:VCArray];
    

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController setViewControllers:VCArray direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
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
        make.centerX.equalTo(self.RTRTabBar.mas_left).offset(tabBarItemWidth/2);
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
    NSLog(@"[cbb]reload view: %@, %@", self.tabBarItemTags, self.tabBarItemImages);
    
}

#pragma mark RTRTabBarItemDelegate

- (void)didSelectedTabBarItemAtIndex:(NSUInteger)index WithTag:(NSString *)tag {
    NSLog(@"[cbb]didSelectedTabBarItemWithTag:%@", tag);
    NSLog(@"[cbb]RTRTabBarItemArray:%@", self.RTRTabBarItemArray);
    // 点击震动触觉反馈
    if (@available(iOS 11.0, *)) {
        UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [feedBackGenertor impactOccurred];
    }
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
            make.centerX.equalTo(self.RTRTabBar.mas_left).offset(tabBarItemWidth/2 + index * tabBarItemWidth);
        }];
        [self.whiteBlock.superview layoutIfNeeded];
    }];
    // vc 跳转
//    [self.selec]
}

#pragma mark UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSLog(@"后一个视图控制器");
    NSInteger after = self.currentIndex + 1;
    if (after >= self.tabPageVCArray.count) {
        return nil;
    }
    return self.tabPageVCArray[after];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSLog(@"前一个视图控制器");
    NSInteger before = self.currentIndex - 1;
    if (before < 0) {
        return nil;
    }
    return self.tabPageVCArray[before];
}

#pragma mark UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    NSLog(@"动画过渡开始之前");
    self.pendvc = pendingViewControllers.firstObject;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    NSLog(@"动画过渡完成previousViewControllers");  //previousViewControllers为过渡之前的视图控制器
    [self.tabPageVCArray enumerateObjectsUsingBlock:^(UIViewController *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == self.pendvc) {  //判断视图控制器是否与正在转换的视图控制器为同一个
            self.currentIndex = idx;
            *stop = YES;
        }
    }];
}

////返回视图控制器支持的所有方向
//- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController {
//    return UIInterfaceOrientationMaskLandscape;
//}
//
////返回视图控制器的首选方向
//- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController {
//    return UIInterfaceOrientationLandscapeRight;
//}

#pragma mark - Category Property Getter & Setter

- (UIView *)RTRTabBar {
    if (_RTRTabBar == nil) {
        _RTRTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-TABBAR_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT)];
    }
    return _RTRTabBar;
}


- (UIView *)whiteBlock {
    if (_whiteBlock == nil) {
        _whiteBlock = [[UIView alloc] init];
    }
    return _whiteBlock;
}

- (UIPageViewController *)pageViewController {
    if (_pageViewController == nil) {
        NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:2] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    
    return _pageViewController;
}

@end
