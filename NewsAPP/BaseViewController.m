//
//  BaseViewController.m
//  NewsAPP
//
//  Created by 管理员 on 2016/11/15.
//  Copyright © 2016年 Dragon. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.navigationController.viewControllers.count >=2){
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 22, 20);
        [backButton setBackgroundImage:[UIImage imageNamed:@"prev"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentMode = UIViewContentModeScaleAspectFit;
        UIBarButtonItem *liftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = liftButton;
    }
}

-(void)setTitle:(NSString *)title{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 44)];
    [lable setText:title];
    [lable setTextAlignment:NSTextAlignmentCenter];
    lable.center =CGPointMake([UIScreen mainScreen].bounds.size.width/2, 0);
    [lable setFont:[UIFont systemFontOfSize:18]];
    [lable setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView = lable;
}
@end
