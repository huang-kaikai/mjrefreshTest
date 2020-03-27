//
//  SecondViewController.m
//  GitHubDemo
//
//  Created by ryan.huang on 2020/3/24.
//  Copyright © 2020 ryan.huang. All rights reserved.
//

#import "SecondViewController.h"
#import "MyTableViewCell.h"
#import <MJRefresh.h>

//随机数据
static const CGFloat MJDuration = 2.0;
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
//建立一個通用數據源
@property (strong,nonatomic) NSMutableArray *dataSource;
/** 用来显示的假数据 */
@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //設定分頁title
    self.title = @"這是一個客製化cell";
    //設定NSArray資料
    //self.showLabelNumber = @[@"NO.1", @"NO.2", @"NO.3", @"NO.4", @"NO.5", @"NO.6", @"NO.7"];
    //self.titleText = @[@"抖音沙發哥", @"我是大美女", @"誰能比我正", @"iOS Swift", @"iOS OC", @"MacBook Air", @"MacBook Pro"];
    
    #pragma mark - 創建可變數組，初始化
    self.dataSource = [NSMutableArray array]; //瞭解這邊這樣使用array的用法原理
    
    NSArray *randomArray = @[@"抖音沙發哥", @"我是大美女", @"誰能比我正", @"iOS Swift", @"iOS OC", @"MacBook Air", @"MacBook Pro"];
    #pragma mark - 創建隨機數據源
    for (int i = 0; i<100; i++) {
        NSString *num = [NSString stringWithFormat:@"NO.%d", i+1];
        
         #pragma mark - 獲取隨機數
        int index = (arc4random() % randomArray.count); //這個用法多加練習理解
         #pragma mark - 創建隨機數據源，randomArray隨機抽取名字付值
        NSString *name = [NSString stringWithFormat:@"我是%@", randomArray[index]];
        
        NSDictionary *dict = @{
            @"myNumber":num,@"myName":name
        };
        [self.dataSource addObject:dict]; //這個用法再多加練習理解
    }
    
    //畫面顯示TableView
    [self myTableView];
    //在DidLoad函数里对该Cell进行注册
    [self.tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"myCell"];
    
    [self example01];
    
//    #pragma mark-頁面更新
//    __unsafe_unretained UITableView *tableView = self.tableView;
//
//    // 下拉刷新
//    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 结束刷新
//            [tableView.mj_header endRefreshing];
//        });
//    }];
//
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    tableView.mj_header.automaticallyChangeAlpha = YES;
//
//    // 上拉刷新
//    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 结束刷新
//            [tableView.mj_footer endRefreshing];
//        });
//    }];
    
}

-(void)myTableView {
    //設定tableView初始化，及選擇style
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //連結delegate及dataSource
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //將表格添加至view以顯示
    [self.view addSubview:self.tableView];
}

#pragma mark - tableview delegate / dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //從dataSource讀取行數
    //return self.dataSource.count;
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MyTableViewCell *cell = nil; //1

    cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"forIndexPath:indexPath]; //2
    //從dataSource讀取模型數據
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.label1.text = dict[@"myNumber"];
    cell.label1.textColor = [UIColor redColor];
    
    cell.label2.text = dict[@"myName"];
    cell.label2.textColor = [UIColor blueColor];
    
    [cell.icon1 setTitle:@"Press" forState:UIControlStateNormal];
    [cell.icon1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [cell.icon1 setBackgroundImage:[UIImage imageNamed:@"金币"] forState:UIControlStateNormal];
    
    cell.backgroundColor = [UIColor whiteColor];

    return cell;    //3
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = @"Section Start";
    return title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSString *title2 = @"Section End";
    return title2;
}

//設定每一個Row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
//點擊Row進行事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //點擊動畫
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //點擊後呼叫openNew方法開啟新VC
    [self openNewVC];
}

#pragma mark - 點擊cell開啟新VC
- (void)openNewVC {
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"cell資料";
    [self.navigationController pushViewController:vc animated:YES]; //這邊自己就會有navigationController？
}

#pragma mark - 示例代码
#pragma mark UITableView + 下拉刷新 默认
- (void)example01
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    //[self.tableView.mj_header beginRefreshing];
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data insertObject:MJRandomData atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    });
}

- (NSMutableArray *)data
{
    if (!_data) {
        self.data = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            [self.data addObject:MJRandomData];
        }
    }
    return _data;
}

@end
