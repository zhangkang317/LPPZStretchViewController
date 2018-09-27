//
//  LPPZStretchViewController.h
//  LPPZStretchViewController
//
//  Created by zhangkang on 2018/9/27.
//  Copyright © 2018年 zhangkang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LPPZStretchHeaderView;
@interface LPPZStretchViewController : UIViewController

//设置子ViewControllee
@property (strong, nonatomic) NSArray<UIViewController *> *subViewControllers;
//设置header的最大高度
@property (assign, nonatomic) CGFloat MaxHeaderViewHeight;
//设置header的最小高度
@property (assign, nonatomic) CGFloat MinHeaderViewHeight;
//设置header是否可以弹簧
@property (assign, nonatomic) BOOL shouldBounce;
//监听head的高度整体的变化
@property (nonatomic, copy) void(^headerViewHeightChangeBlock)(CGFloat height);
@property (nonatomic, strong) LPPZStretchHeaderView *headerView;

@end
