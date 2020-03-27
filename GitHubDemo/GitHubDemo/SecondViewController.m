//
//  SecondViewController.m
//  GitHubDemo
//
//  Created by ryan.huang on 2020/3/24.
//  Copyright © 2020 ryan.huang. All rights reserved.
//

#import "SecondViewController.h"
#import "MyTableViewCell.h"

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
//建立一個通用數據源
@property (strong,nonatomic) NSMutableArray *dataSource;

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
    return self.dataSource.count;
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
    //do something
}

@end
