//
//  LPPZListViewController.m
//  LPPZStretchViewController
//
//  Created by zhangkang on 2018/9/18.
//  Copyright © 2018年 zhangkang. All rights reserved.
//

#import "LPPZListViewController.h"
#import "Masonry.h"

@interface LPPZListViewController ()<UITableViewDelegate ,UITableViewDataSource>

@end

@implementation LPPZListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
}
#pragma mark - Add SubViews
- (void)addSubViews {
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
     
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"my-cell"];

        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView;
    });
    [self.view addSubview:self.tableView];
//    [self.tableView reloadData];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);

    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my-cell" forIndexPath:indexPath];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell.textLabel setText:[NSString stringWithFormat:@"(%ld, %ld)", indexPath.section, indexPath.row]];
        return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"godlike");
}
@end
