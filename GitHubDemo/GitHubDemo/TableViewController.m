//
//  TableViewController.m
//  GitHubDemo
//
//  Created by ryan.huang on 2020/3/24.
//  Copyright © 2020 ryan.huang. All rights reserved.
//

#import "TableViewController.h"
#import <MJRefresh/MJRefresh.h>
//記得先繼承delegate、dataSource
@interface TableViewController () <UITableViewDelegate,UITableViewDataSource>
//宣告表格及陣列屬性
@property (strong,nonatomic) UITableView *table;
@property (strong,nonatomic) NSArray *content;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //設定title
    self.title = @"One Week";
    //設定NSArray資料
    self.content = @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"];
    //顯示表格
    [self myTableView];
    
#pragma mark-頁面更新
    __unsafe_unretained UITableView *tableView = self.table;
    
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_header endRefreshing];
        });
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_footer endRefreshing];
        });
    }];
    
}

-(void)myTableView {
    //設定tableView初始化，及選擇style
    self.table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //連結delegate及dataSource
    self.table.delegate = self;
    self.table.dataSource = self;
    //將表格添加至view以顯示
    [self.view addSubview:self.table];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _content.count; //疑問：為什麼content要用底線？差別是什麼？
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Inside of this method we need to create a static property to identify the cells in our tableView and initialize UITableViewCell:
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [_content objectAtIndex:indexPath.row]; //疑問：_底線？
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Title of cell %@", [_content objectAtIndex:indexPath.row]);
}



@end
