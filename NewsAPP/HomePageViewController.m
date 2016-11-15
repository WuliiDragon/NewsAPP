//
//  HomePageViewController.m
//  NewsAPP
//
//  Created by 管理员 on 2016/11/15.
//  Copyright © 2016年 Dragon. All rights reserved.
//

#import "HomePageViewController.h"
#import "newsTableViewController.h"


//top(头条，默认),shehui(社会),guonei(国内),guoji(国际),yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)
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
    [self loadtableview];
    
}
-(void)loadtableview{
    pageTitles = @[@"头条",@"社会",@"体育",@"军事"];
    NSInteger pageNumber = pageTitles.count;
    [self setBlock_numberOfPages:^NSInteger{
        return pageNumber;
    }];
    [self setBlock_widthOfTitleItem:^CGFloat{
        return [UIScreen mainScreen].bounds.size.width/4.f;
    }];
    [self setBlock_topInset:^CGFloat{
        return 0;
    }];
    [self setBlock_borderColorOfTabBar:^UIColor *{
        return [UIColor clearColor];
    }];
    [self setBlock_indicatorColorOfSelectedTabItem:^UIColor *{
        return [UIColor colorWithRed:68/255.f green:150/255.f blue:214/255.f alpha:1.0f];
    }];
     NSArray  *weakArr = pageTitles;
    [self setBlock_titleForPageAtIndex:^NSString *(NSUInteger index) {
        NSArray  *strongArr = weakArr;
        return strongArr[index];
    }];
    
}
-(void)click:(HomePageViewController*)homePagesVC{
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
