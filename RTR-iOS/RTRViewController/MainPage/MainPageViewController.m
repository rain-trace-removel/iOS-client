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

@interface MainPageViewController() <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) MainPageViewModel *mainPageViewModel;
@property(nonatomic, strong) UITableView *mainPageTableView;
@property(nonatomic, strong) NSString *identifier;

@end

@implementation MainPageViewController

- (instancetype)initWithViewModel:(MainPageViewModel *)viewModel {
    self = [super init];
    if(self) {
        self.mainPageViewModel = viewModel;
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
//    UserProfileTableViewCell *cell_view = [[UserProfileTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 80)];
//    [cell_view reloadViewWithProfileItem:[[RTRUserManager rtr_shareManager].userProfile readProfileItemWithSection:indexPath.section Item:indexPath.item]];
//    [cell addSubview:cell_view];
    
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
