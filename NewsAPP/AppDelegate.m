//
//  AppDelegate.m
//  NewsAPP
//
//  Created by Dragon on 2016/11/11.
//  Copyright © 2016年 Dragon. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "newData.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[MainViewController alloc] init];
    newData *data = [[newData alloc]init];
    [data getdata];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}




@end
