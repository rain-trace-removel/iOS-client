//
//  DerainEditPageViewController.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/16.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DerainEditPageViewController.h"
#import "RTRDefine.h"
#import "EditPageNavigationBar.h"
#import "UIImageView+AutoSize.h"
#import "Masonry/Masonry.h"

@interface DerainEditPageViewController() <EditPageNavigationBarDelegate>

@property(nonatomic, strong) UIImageView *pictureShowImageView;
@property(nonatomic, strong) EditPageNavigationBar *editPageNavigationBar;

@end

@implementation DerainEditPageViewController

#pragma mark Life Cycle

- (void)viewDidLoad {
    [self.view setBackgroundColor:RTRColorFromRGB(0x2a2a2a)];
    [self.view addSubview:self.editPageNavigationBar];
    [self.view addSubview:self.pictureShowImageView];
}

#pragma mark Public

- (void)reloadViewWithModel:(DerainEditPageViewModel *)model {
    CGSize imageview_size =  [self.pictureShowImageView setImageViewByImage:model.original_image WithLimitWidth:self.view.frame.size.width andLimitHeight:self.view.frame.size.height - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - 100];
    [self.pictureShowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(imageview_size);
    }];
}


#pragma mark EditPageNavigationBarDelegate

- (void)didClickBackButton {
    [self popThisViewController];
}

- (void)didClickPreStepButton {
    
}

- (void)didClickNextStepButton {
    
}

- (void)didClickSaveButton {
    
}

#pragma mark Private

- (void)popThisViewController {
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Getter & Setter

- (EditPageNavigationBar *)editPageNavigationBar {
    if (_editPageNavigationBar == nil) {
        _editPageNavigationBar = [[EditPageNavigationBar alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)];
        _editPageNavigationBar.delegate = self;
    }
    return _editPageNavigationBar;
}

- (UIImageView *)pictureShowImageView {
    if (_pictureShowImageView == nil) {
        _pictureShowImageView = [[UIImageView alloc] init];
    }
    return _pictureShowImageView;
}

@end
