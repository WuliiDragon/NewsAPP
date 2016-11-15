//
//  XXPageViewController.h
//  XXPageViewController
//
//  Created by yxlong on 15/5/19.
//  Copyright (c) 2015年 yixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXPageViewController.h"

@interface XXPageViewController : UIViewController

@property(nonatomic, strong) NSMutableArray *subviewControllers;
@property(nonatomic, assign) NSInteger selectedIndex;

// 页数
@property(nonatomic, copy) NSInteger(^block_numberOfPages)(void);
// 每一页对应的ViewController
@property(nonatomic, copy) UIViewController*(^block_viewControllerAtIndex)(NSUInteger index);
// 每一页name，显示在tab上
@property(nonatomic, copy) NSString*(^block_titleForPageAtIndex)(NSUInteger index);
// tab距离顶端的距离
@property(nonatomic, copy) CGFloat(^block_topInset)(void);
// 内容视图距离底部的距离
@property(nonatomic, copy) CGFloat(^block_bottomInset)(void);
// 每个tab item的width
@property(nonatomic, copy) CGFloat(^block_widthOfTitleItem)(void);
// tab的边color
@property(nonatomic, copy) UIColor*(^block_borderColorOfTabBar)(void);
// 当前选中的底线
@property(nonatomic, copy) UIColor*(^block_indicatorColorOfSelectedTabItem)(void);

/**
 *  重加载数据
 */
- (void)reloadData;
@end

/*
 使用示例:
 
 pageTitles = @[@"Page1", @"Page2"];
 
 NSUInteger _pageNumber = pageTitles.count;
 [self setBlock_numberOfPages:^(void){
 return _pageNumber;
 }];
 [self setWidthOfTitleItem:^CGFloat(void){
 return [UIScreen mainScreen].bounds.size.width/3;
 }];
 [self setBlock_topInset:^CGFloat(void){
 return 190;
 }];
 [self setBlock_bottomInset:^CGFloat{
 return 55;
 }];
 [self setBorderColorOfTabBar:^UIColor*(void){
 return [UIColor greenColor];
 }];
 [self setIndicatorColorOfSelectedTabItem:^UIColor *(void){
 return [UIColor greenColor];
 }];
 __weak NSArray *weak_array = pageTitles;
 
 [self setBlock_titleForPageAtIndex:^(NSUInteger index){
 NSArray *strong_array = weak_array;
 return strong_array[index];
 }];
 
 [self setBlock_viewControllerAtIndex:^(NSUInteger index){
 return [XXPageChildViewController CreateViewControllerWithAlias:[NSString stringWithFormat:@"Page %lu", (unsigned long)index]];
 }];
 
 [self reloadData];
 */


