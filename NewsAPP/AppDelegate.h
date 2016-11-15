//
//  AppDelegate.h
//  NewsAPP
//
//  Created by Dragon on 2016/11/11.
//  Copyright © 2016年 Dragon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

