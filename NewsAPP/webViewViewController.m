//
//  webViewViewController.m
//  NewsAPP
//
//  Created by 管理员 on 2016/11/13.
//  Copyright © 2016年 Dragon. All rights reserved.
//

#import "webViewViewController.h"

@interface webViewViewController ()

@end

@implementation webViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.str);
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height)];
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [webView setUserInteractionEnabled:YES];//是否支持交互
    NSURL *url = [NSURL URLWithString:self.str];//创建url（统一资源定位符，互联网标准资源的地址）
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];//创建NSURLRequest
    [webView loadRequest:urlRequest];//加载[self.view addSubview:webView];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
