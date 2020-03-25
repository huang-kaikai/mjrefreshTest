//
//  RootViewController.m
//  GitHubDemo
//
//  Created by ryan.huang on 2020/3/24.
//  Copyright © 2020 ryan.huang. All rights reserved.
//

#import "RootViewController.h"
#import "TableViewController.h"
#import "SecondViewController.h"

@interface RootViewController () <UITabBarControllerDelegate>

@property (strong,nonatomic)UITabBarController *tabBarController;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.delegate = self;
    
    TableViewController *firstVC = [[TableViewController alloc] init];
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:firstVC];
    firstNav.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:secondVC];
    secondNav.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:1];
    
    tabBarController.viewControllers = [NSArray arrayWithObjects:firstNav, secondNav, nil];
    self.tabBarController = tabBarController;
    [self.view addSubview:tabBarController.view];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
