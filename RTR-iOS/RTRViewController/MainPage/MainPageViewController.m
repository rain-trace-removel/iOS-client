//
//  MainPageViewController.m
//  RTR-iOS
//
//  Created by chenbb6 on 2020/3/3.
//  Copyright © 2020 chenbb6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainPageViewController.h"
#import "RTRDefine.h"
#import "RLog.h"
#import "MainPageFunctionEntriesView.h"
#import <SDWebImage/SDWebImage.h>
#import <TZImagePickerController.h>
#import "DerainEditPageViewController.h"

@interface MainPageViewController() <UITableViewDelegate, UITableViewDataSource, MainPageFunctionEntriesViewDelegate, TZImagePickerControllerDelegate>

@property(nonatomic, strong) MainPageViewModel *mainPageViewModel;
@property(nonatomic, strong) UITableView *mainPageTableView;
@property(nonatomic, strong) NSString *identifier;
@property(nonatomic, assign) FunctionModelType clickedType;

@end

@implementation MainPageViewController

- (instancetype)initWithViewModel:(MainPageViewModel *)viewModel {
    self = [super init];
    if(self) {
        self.mainPageViewModel = viewModel;
        self.clickedType = TypeCameraPhoto;
        self.identifier = [NSString stringWithFormat:@"%s", __FILE__];
    }
    return self;
}

- (void)viewDidLoad {
    [self setupView];
}

- (void)setupView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mainPageTableView];
}

#pragma mark MainPageFunctionEntriesViewDelegate

- (void)didClickedEntryItemWithModel:(MainPageFunctionModel *)model {
    rtr_log(model.title);
    self.clickedType = model.type;
    if (model.type == TypeCameraPhoto) {
        
    } else if (model.type == TypePictureBorder || model.type == TypePictureDerain || model.type == TypePictureEdit) {
        TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        // 是否显示可选原图按钮
        imagePicker.allowPickingOriginalPhoto = NO;
        // 是否允许显示视频
        imagePicker.allowPickingVideo = NO;
        // 是否允许显示图片
        imagePicker.allowPickingImage = YES;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else if (model.type == TypeVideoEdit) {
        TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        // 是否显示可选原图按钮
        imagePicker.allowPickingOriginalPhoto = NO;
        // 是否允许显示视频
        imagePicker.allowPickingVideo = YES;
        // 是否允许显示图片
        imagePicker.allowPickingImage = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else if (model.type == TypeUserVIPService) {
        
    }
}

#pragma mark TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    if (self.clickedType == TypePictureDerain) {
        DerainEditPageViewController *derainEditPage = [[DerainEditPageViewController alloc] init];
        [derainEditPage.view setFrame:self.view.frame];
        DerainEditPageViewModel *derainEditPageViewModel = [[DerainEditPageViewModel alloc] init];
        derainEditPageViewModel.original_image = photos.firstObject;
        [derainEditPage reloadViewWithModel:derainEditPageViewModel];
        [self.navigationController pushViewController:derainEditPage animated:YES];
    }
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    rtr_log(coverImage);
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
//    return [self.mainPageViewModel.mainPageModelArrArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
//    return [self.mainPageViewModel.mainPageModelArrArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [NSString stringWithFormat:@"%@-%zd-%zd", self.identifier, indexPath.section, indexPath.row];
    UITableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier: cellID];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellID];
    }
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    for(UIView *view in cell.subviews){
        [view removeFromSuperview];
    }

    [cell setBackgroundColor:randomColor];
    if (indexPath.section == 0) {
        // 轮播Banner页
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.jmxdtv.com/uploadfiles/image/201901/50.jpg?1584263180969"] placeholderImage:nil];
        [cell addSubview:imageView];
    }
    else if (indexPath.section == 1) {
        // 功能模块入口页
        MainPageFunctionEntriesView *funcitonEntriesCell = [[MainPageFunctionEntriesView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
        funcitonEntriesCell.delegate = self;
        [funcitonEntriesCell reloadViewWithModelArray:[MainPageViewModel shareInstance].functionModuleArray itemsNumInOneLine:3];
        [cell setFrame:funcitonEntriesCell.frame];
        [cell addSubview:funcitonEntriesCell];
    }
    else if (indexPath.section == 2) {
        // 广告页
    }
    else if (indexPath.section == 3) {
        // 灵感与交流页
    }
    return cell;
}



#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    rtr_log(indexPath);
    if (indexPath.section == 0) {
        NSURL *applink = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://apps.apple.com/cn/app/id1142110895"]];
        [[UIApplication sharedApplication] openURL:applink options:@{} completionHandler:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (indexPath.section == 1) {
        UITableViewCell *cell = [self tableView: _mainPageTableView cellForRowAtIndexPath: indexPath];
        return cell.frame.size.height;
    }
    switch (indexPath.section) {
        case 0:
            height = 200;
            break;
        case 1:
            height = 44;
            break;
        case 2:
            height = 260;
            break;
        case 3:
            height = 220;
            break;
        default:
            height = 0;
            break;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

#pragma mark Getter & Setter

- (UITableView *)mainPageTableView {
    if(_mainPageTableView == nil) {
        _mainPageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-TABBAR_HEIGHT) style:UITableViewStyleGrouped];
        _mainPageTableView.delegate = self;
        _mainPageTableView.dataSource = self;
        _mainPageTableView.showsVerticalScrollIndicator = NO;
        _mainPageTableView.separatorStyle = UITableViewCellAccessoryNone;

    }
    return _mainPageTableView;
}

@end
