//
//  LPPZStretchHeaderView.m
//  LPPZStretchViewController
//
//  Created by zhangkang on 2018/9/26.
//  Copyright © 2018年 zhangkang. All rights reserved.
//

#import "LPPZStretchHeaderView.h"
@interface LPPZStretchHeaderView()
@property (strong, nonatomic) UIButton  *actionButton;

@end
@implementation LPPZStretchHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.actionButton = [[UIButton alloc] init];
        [self.actionButton setTitle:@"点击" forState:UIControlStateNormal];
//        self.actionButton.userInteractionEnabled = NO;
        [self addSubview:self.actionButton];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * targetView = [super hitTest:point withEvent:event];
    
    if (targetView == self) {
        return nil;
    }
    
    if (targetView.userInteractionEnabled == YES) {
        
        NSLog(@"123godlike");
        return targetView;

    }
    return nil;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.actionButton.frame = CGRectMake(30, 30, 50, 50);
}
@end


