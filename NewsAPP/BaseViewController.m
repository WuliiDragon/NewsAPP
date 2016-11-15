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
