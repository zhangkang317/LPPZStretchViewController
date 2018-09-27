
//
//  LPPZExampleViewControlller.m
//  LPPZStretchViewController
//
//  Created by zhangkang on 2018/9/27.
//  Copyright © 2018年 zhangkang. All rights reserved.
//

#import "LPPZExampleViewControlller.h"
#import "LPPZListViewController.h"

#import "LPPZExampleHeaderView.h"

@interface LPPZExampleViewControlller ()

@end

@implementation LPPZExampleViewControlller

- (void)viewDidLoad {
    [super viewDidLoad];
    LPPZListViewController * vc1 = [[LPPZListViewController alloc] init];
    LPPZListViewController * vc2 = [[LPPZListViewController alloc] init];
    self.subViewControllers = @[vc1,vc2];
    self.MinHeaderViewHeight = 40;
    
    LPPZExampleHeaderView * headerView = [[LPPZExampleHeaderView alloc] init];
    self.headerView = headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
