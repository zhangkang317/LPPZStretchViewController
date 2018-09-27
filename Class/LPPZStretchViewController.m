//
//  LPPZStretchViewController.m
//  LPPZStretchViewController
//
//  Created by zhangkang on 2018/9/27.
//  Copyright © 2018年 zhangkang. All rights reserved.
//

#import "LPPZStretchViewController.h"
#define UI_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UI_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height



#define KtabBarHeigh 49
#define KHeaderViewMaxHeight 100

#import "Masonry.h"
#import "LPPZListViewController.h"
#import "UIView+LPPZExtension.h"
#import "LPPZStretchTabBarView.h"
#import "LPPZStretchHeaderView.h"
@interface LPPZStretchViewController ()
<
UIScrollViewDelegate>
@property (strong, nonatomic) LPPZStretchTabBarView *tabBarView;

@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) MASConstraint *headerViewHeightConstraint;

@property (assign, nonatomic) NSInteger selectedIndex;
@end

@implementation LPPZStretchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _MaxHeaderViewHeight = KHeaderViewMaxHeight;
    _MinHeaderViewHeight = 0;
    _shouldBounce = YES;
    self.selectedIndex = 0;
    [self lppz_addCustomView];
    [self.view addSubview:self.headerView];
    
}

-(void)lppz_addCustomView{
    
    self.mainScrollView =({
        UIScrollView * mainScrollView = [[UIScrollView alloc] init];
        mainScrollView.delegate = self;
        mainScrollView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:mainScrollView];
        mainScrollView.pagingEnabled = YES;
        mainScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH * 2 , 0);
        mainScrollView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
        mainScrollView;
    });
    
    _headerView = [[LPPZStretchHeaderView alloc] init];
    [self.view addSubview:_headerView];
    _headerView.backgroundColor = [UIColor greenColor];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        self.headerViewHeightConstraint =  make.height.mas_equalTo(self.MaxHeaderViewHeight);
    }];
  
    self.tabBarView = ({
        LPPZStretchTabBarView *tabBarView = [[LPPZStretchTabBarView alloc] init];
        [self.view addSubview:tabBarView];
        tabBarView.backgroundColor = [UIColor yellowColor];
        tabBarView.titles = @[@"精选",@"热门"];
        __weak typeof(self) weak_self = self;
        tabBarView.tabBarButtonClickBlock = ^(NSInteger index) {
            __strong typeof(self) strong_self = weak_self;
            [strong_self.mainScrollView setContentOffset:CGPointMake(index * UI_SCREEN_WIDTH, 0) animated:YES];
            self.selectedIndex = index;
            [self lppz_layoutSelectedViewContoller];
        };
        [tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(KtabBarHeigh);
            make.top.equalTo(self.headerView.mas_bottom);
        }];
        
        tabBarView;
    });
}


-(void)setHeaderView:(LPPZStretchHeaderView *)headerView{
    if (_headerView.superview &&_headerView) {
        [_headerView removeFromSuperview];
    }
    _headerView = headerView;
    [self.view addSubview:_headerView];
    _headerView.backgroundColor = [UIColor greenColor];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        self.headerViewHeightConstraint =  make.height.mas_equalTo(self.MaxHeaderViewHeight);
    }];
    [self.tabBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(KtabBarHeigh);
        make.top.equalTo(self.headerView.mas_bottom);

    }];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat headerViewHeight = self.MaxHeaderViewHeight - (self.selectedScrollView.contentOffset.y + self.selectedScrollView.contentInset.top) -20;
        if (headerViewHeight <= self.MinHeaderViewHeight) {
            headerViewHeight = self.MinHeaderViewHeight;
        }
        if (headerViewHeight> self.MaxHeaderViewHeight && _shouldBounce == NO) {
            headerViewHeight = self.MaxHeaderViewHeight;
        }
        
        self.headerViewHeightConstraint.mas_equalTo(headerViewHeight);
        !self.headerViewHeightChangeBlock ?: self.headerViewHeightChangeBlock(headerViewHeight);
    }
}


-(UIScrollView *)selectedScrollView{
    UIViewController * selectedVC = self.childViewControllers[self.selectedIndex];
    return [selectedVC valueForKey:@"tableView"] ;
}


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    self.selectedIndex =  (targetContentOffset->x/UI_SCREEN_WIDTH);
    [self lppz_layoutSelectedViewContoller];
}

-(void)lppz_layoutSelectedViewContoller{
    CGFloat contentOffsetY = self.MaxHeaderViewHeight- self.headerView.height -20 -(KtabBarHeigh + self.MaxHeaderViewHeight);
    NSLog(@"contentOffsetY:%f",contentOffsetY);
    NSLog(@"self.selectedScrollView.contentOffset.y;%f",self.selectedScrollView.contentOffset.y);
    if (self.selectedScrollView.contentOffset.y >-20 &&self.headerView.height<self.MaxHeaderViewHeight) {
        return;
    }
    [self.selectedScrollView setContentOffset:CGPointMake(0, contentOffsetY) animated:NO];
}


-(void)setSubViewControllers:(NSArray<UIViewController *> *)subViewControllers{
    _subViewControllers = subViewControllers;
    [subViewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:obj];
        [self.mainScrollView addSubview:obj.view];
        UITableView * tableView  = [obj valueForKey:@"tableView"];
        [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        CGFloat y = KtabBarHeigh + self.MaxHeaderViewHeight;
        obj.view.frame = CGRectMake(idx *UI_SCREEN_WIDTH, 0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT);
        tableView.contentInset = UIEdgeInsetsMake(y, 0, 0, 0);
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }];
}
-(void)setMaxHeaderViewHeight:(CGFloat)MaxHeaderViewHeight{
    _MaxHeaderViewHeight  = MaxHeaderViewHeight;
    self.headerViewHeightConstraint.mas_equalTo(MaxHeaderViewHeight);
    if (self.subViewControllers.count) {
        [self.subViewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UITableView * tableView  = [obj valueForKey:@"tableView"];
            [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            CGFloat y = KtabBarHeigh + self.MaxHeaderViewHeight;
            obj.view.frame = CGRectMake(idx *UI_SCREEN_WIDTH, 0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT);
            tableView.contentInset = UIEdgeInsetsMake(y, 0, 0, 0);
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }];
    }
}

-(void)setMinHeaderViewHeight:(CGFloat)MinHeaderViewHeight{
    _MinHeaderViewHeight = MinHeaderViewHeight;
    
}
@end
