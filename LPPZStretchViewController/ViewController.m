//
//  ViewController.m
//  LPPZStretchViewController
//
//  Created by zhangkang on 2018/9/18.
//  Copyright © 2018年 zhangkang. All rights reserved.
//
#define UI_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UI_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height





#define KtabBarHeigh 49
#define KHeaderViewMaxHeight 100

#import "ViewController.h"
#import "Masonry.h"
#import "UIView+LPPZExtension.h"
#import "LPPZStretchViewController.h"
#import "LPPZExampleViewControlller.h"






@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * acitonButton = [[UIButton alloc] init];
    [acitonButton setTitle:@"点击" forState:UIControlStateNormal];
    [acitonButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [acitonButton addTarget:self action:@selector(Onclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:acitonButton];
    [acitonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
}
-(void)Onclick{
    
    LPPZExampleViewControlller *vc = [[LPPZExampleViewControlller alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
}
@end
