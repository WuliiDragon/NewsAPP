//
//  MainViewController.m
//  NewsAPP
//
//  Created by 管理员 on 2016/11/15.
//  Copyright © 2016年 Dragon. All rights reserved.
//

#import "MainViewController.h"
#import "MyInfoViewController.h"
#import "FoundViewController.h"
#import "RecommendViewController.h"
#import "HomePageViewController.h"
#import "TabItem.h"
#import "BaseNavigationController.h"

@interface MainViewController ()
{
    TabItem *last_tabItem;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSonViewController];
    [self loadTabBarView];
}

#pragma mark 创建子控制器
-(void)loadSonViewController{
    HomePageViewController*homePageVC = [[HomePageViewController alloc]init];
    RecommendViewController *recommendVC = [[RecommendViewController alloc]init];
    FoundViewController *foundVC = [[FoundViewController alloc]init];
    MyInfoViewController *myInfoVC = [[MyInfoViewController alloc]init];
    NSArray *controllerArr = @[homePageVC,recommendVC,foundVC,myInfoVC];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:4];
    for(int i = 0;i<4;i++){
        BaseNavigationController *baseNC = [[BaseNavigationController alloc]initWithRootViewController:controllerArr[i]];
        [arr addObject:baseNC];
    }
    self.viewControllers = arr;
}

#pragma mark 自定义TabBar

-(void) loadTabBarView{
    for (UIView *tabBar in self.tabBar.subviews) {
        [tabBar removeFromSuperview];
    }
    
    CGFloat itemWidth =  [UIScreen mainScreen].bounds.size.width/self.viewControllers.count;
    
    NSArray *titles = @[@"首页",@"推荐",@"发现",@"我"];
    NSArray *images = @[@"homepage",@"recommend",@"found",@"myinfo"];
    NSArray *imagesSelect = @[@"shomepage",@"srecommend",@"sfound",@"smyinfo"];
    
    for (int i = 0;i<4; i++) {
        TabItem *tabItem = [[TabItem alloc]initWithFrame:CGRectMake(i*itemWidth, 0, itemWidth, self.tabBar.frame.size.height)];
        [tabItem  addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [tabItem setItemTitle:titles[i]];
        tabItem.tag = 100 + i;
        [tabItem setItemImage:[UIImage imageNamed:images[i]] forState:true];
        [tabItem setItemImage:[UIImage imageNamed:imagesSelect[i]] forState:false];
        [self.tabBar addSubview: tabItem];
        if(i==0){
            [tabItem setItemSelected:YES];
            last_tabItem = tabItem;
        }
    }
}
-(void)click:(TabItem*) tabItem{
    if(last_tabItem!= tabItem){
        [last_tabItem setItemSelected:NO];
        [tabItem setItemSelected:YES];
        last_tabItem = tabItem;
        self.selectedIndex = tabItem.tag - 100;
    }
    
    
}










@end
