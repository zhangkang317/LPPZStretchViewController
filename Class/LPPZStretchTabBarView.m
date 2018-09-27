//
//  LPPZStretchHeaderView.m
//  LPPZStretchViewController
//
//  Created by zhangkang on 2018/9/26.
//  Copyright © 2018年 zhangkang. All rights reserved.
//
//十六进制颜色转换（0xFFFFFF）
#define HEXRGBCOLOR(hex)        [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]
#define UI_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UI_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "LPPZStretchTabBarView.h"
#import "UIView+LPPZExtension.h"

@interface LPPZStretchTabBarView()
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) UIButton *selectedButton;

@end

@implementation LPPZStretchTabBarView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        self.lineView = ({
            UIView * lineView = [[UIView alloc] init];
            lineView.backgroundColor = [UIColor redColor];
            [self addSubview:lineView];
            lineView;
        });
        self.buttonArray = [NSMutableArray array];

    }
    return self;
}
-(void)setTitles:(NSArray<NSString *> *)titles{
    _titles = titles;
    
    CGFloat buttonWith = UI_SCREEN_WIDTH/titles.count;
    [titles enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * button = [[UIButton alloc] init];
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitle:obj forState:UIControlStateSelected];
        [button setTitleColor:HEXRGBCOLOR(0x444444) forState:UIControlStateNormal];
        [button setTitleColor:HEXRGBCOLOR(0x444444) forState:UIControlStateSelected];
        [button setTitleColor:HEXRGBCOLOR(0x444444) forState:UIControlStateHighlighted];
        [self addSubview:button];
        [button addTarget:self action:@selector(buttonOnclick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(idx * buttonWith, 0, buttonWith, 49);
        [button.titleLabel sizeToFit];
        [self.buttonArray addObject:button];
    }];
    UIButton * button = self.buttonArray.firstObject;
    button.selected = YES;
    self.selectedButton = button;
    self.lineView.height = 2;
    self.lineView.width = button.titleLabel.width;
    self.lineView.centerX = button.centerX;
    self.lineView.y = 49 - 2;
}
-(void)buttonOnclick:(UIButton *)sender{
    if (sender.isSelected == YES) {
        return;
    }
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;

    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.centerX = sender.centerX;
    }];
    
    NSInteger index = [self.buttonArray indexOfObject:sender];
    !self.tabBarButtonClickBlock ?: self.tabBarButtonClickBlock(index);
}

@end
