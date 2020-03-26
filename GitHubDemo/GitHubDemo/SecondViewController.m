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
@property (strong,nonatomic) NSArray *content;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //設定分頁title
    self.title = @"客製化cell";
    //設定NSArray資料
    self.content = @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"];
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
    return _content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MyTableViewCell *cell = nil; //1

    cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"forIndexPath:indexPath]; //2

    cell.label1.text = @"NO.1";
    cell.label1.textColor = [UIColor redColor];
    
    cell.label2.text = @"抖音沙發哥";
    cell.label2.textColor = [UIColor blueColor];
    
    [cell.icon1 setTitle:@"Press" forState:UIControlStateNormal];
    [cell.icon1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [cell.icon1 setBackgroundImage:[UIImage imageNamed:@"金币"] forState:UIControlStateNormal];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.textLabel.text = [_content objectAtIndex:indexPath.row];

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
