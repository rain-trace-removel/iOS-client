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
#import "MBProgressHUD.h"
#import "RTRUserManager.h"
#import "RLog.h"
#import <Photos/Photos.h>
#import "YBImageBrowserTipView.h"

@interface DerainEditPageViewController() <EditPageNavigationBarDelegate>

@property(nonatomic, strong) DerainEditPageViewModel *viewModel;
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
    self.viewModel = model;
    CGSize imageview_size =  [self.pictureShowImageView setImageViewByImage:model.original_image WithLimitWidth:self.view.frame.size.width andLimitHeight:self.view.frame.size.height - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - 100];
    [self.pictureShowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(imageview_size);
    }];
    [self requestDerain];
}

#pragma mark EditPageNavigationBarDelegate

- (void)didClickBackButton {
    [self popThisViewController];
}

- (void)didClickSaveButton {
    [self saveDerainImage];
}

#pragma mark Private

- (void)popThisViewController {
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveDerainImage {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            
         //写入图片到相册
         PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:self.viewModel.derain_image];
            
     } completionHandler:^(BOOL success, NSError * _Nullable error) {
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [[UIApplication sharedApplication].keyWindow yb_showHookTipView:[NSString stringWithFormat:@"图片保存成功"]];
                 [self popThisViewController];
             });
         } else {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [[UIApplication sharedApplication].keyWindow yb_showForkTipView:[NSString stringWithFormat:@"图片保存失败"]];
             });
         }
            
    }];
}

- (void)requestDerain {
    // 等待tipsView
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.label.text = @"去雨大约需要8-10s，请耐心等候";
    // viewmodel请求
    [self.viewModel requestImageDerainWithToken:[RTRUserManager rtr_shareManager].user.token
                                          Image:self.viewModel.original_image
                                       progress:^(NSProgress *progress)
    {
        hud.progress = progress.fractionCompleted;
    }
                                        success:^(NSURLSessionDataTask *task, id responseObject)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [[UIApplication sharedApplication].keyWindow yb_showHookTipView:[NSString stringWithFormat:@"图片去雨成功"]];
        self.viewModel.derain_image = (UIImage *)responseObject;
        [self.pictureShowImageView setImage:responseObject];
        rtr_log(responseObject);
    }
                                        failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [[UIApplication sharedApplication].keyWindow yb_showForkTipView:[NSString stringWithFormat:@"图片去雨失败"]];
        rtr_log(error);
    }];
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
