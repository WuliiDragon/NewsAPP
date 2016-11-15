//
//  HomePageViewController.m
//  NewsAPP
//
//  Created by 管理员 on 2016/11/15.
//  Copyright © 2016年 Dragon. All rights reserved.
//

#import "HomePageViewController.h"



@interface HomePageViewController ()
{
    NSArray *pageTitles;
}
@end

@implementation HomePageViewController
-(void) loadNav{
    UIButton* searchBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtu setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    searchBtu.frame = CGRectMake(0, 0, 23, 23);
    searchBtu.contentMode = UIViewContentModeScaleAspectFit;
    [searchBtu  addTarget:searchBtu action:@selector(click:) forControlEvents:UIControlEventAllTouchEvents];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtu];
    
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    [logoImageView setImage:[UIImage imageNamed:@"glasses"]];
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = logoImageView;
    
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self loadNav];
    
}

-(void)click:(HomePageViewController*)homePagesVC{
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
