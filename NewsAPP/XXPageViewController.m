//
//  XXPageViewController.m
//  XXPageViewController
//
//  Created by yxlong on 15/5/19.
//  Copyright (c) 2015年 yixin. All rights reserved.
//

#import "XXPageViewController.h"
#import "XXPageSelectorView.h"

// Tabbar macro
#define _tab_bar_height 44
#define _tab_bar_top_margin 64
#define _content_bottom_margin 0
#define _tab_bar_left_margin 0

@interface XXPageViewController ()<UIScrollViewDelegate>
{
    XXPageSelectorView *_tabBarView;
    UIScrollView *_contentContainer;
    
    NSUInteger _numberOfPages;
    //When select the page by tap bar item, we disable the method '-scrollViewDidScroll'.
    BOOL scrollByDragging;
    __block CGFloat _topInset;
    __block CGFloat _bottomInset;
}
- (void)_initializeSubviews;
- (void)layoutSubviewsIfNeeded;
- (void)cleanupSubviewControllers;
- (void)transitionToIndex:(NSUInteger)index;
- (void)loadViewControllerAtIndex:(NSUInteger)index;
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index;
@end

@implementation XXPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initializeSubviews];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _topInset = _tab_bar_top_margin;
    _bottomInset = _content_bottom_margin;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_initializeSubviews
{
    if(_tabBarView==nil){
        _tabBarView = [[XXPageSelectorView alloc] initWithFrame:CGRectMake(_tab_bar_left_margin, _topInset, self.view.frame.size.width-_tab_bar_left_margin, _tab_bar_height)];
        _tabBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:_tabBarView];
        _tabBarView.backgroundColor = [UIColor whiteColor];
        
        __weak XXPageViewController *weakSelf = self;
        [_tabBarView setBlock_didSelectedAtIndex:^(NSUInteger index){
            [weakSelf transitionToIndex:index];
        }];
    }
    
    if(_contentContainer==nil){
        float originY = _topInset+_tab_bar_height;
        _contentContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height-originY-_bottomInset)];
        _contentContainer.delegate = self;
        _contentContainer.pagingEnabled = YES;
//        _contentContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_contentContainer];
        _contentContainer.backgroundColor = [UIColor whiteColor];
        _contentContainer.showsHorizontalScrollIndicator = NO;
        _contentContainer.bounces = YES;
    }
}

- (void)cleanupSubviewControllers
{
    for(id elem in self.childViewControllers){
        if([elem isEqual:[NSNull null]]==NO){
            if([elem isKindOfClass:[UIViewController class]]){
                UIViewController *vc = (UIViewController *)elem;
                [vc willMoveToParentViewController:nil];
                [vc.view removeFromSuperview];
                [vc removeFromParentViewController];
            }
        }
    }
}

- (void)reloadData
{
    if(_block_numberOfPages){
        _numberOfPages = _block_numberOfPages();
    }
    else{
        _numberOfPages = 0;
    }
    
    // Clean up all child view controllers
    [self cleanupSubviewControllers];
    if(_subviewControllers==nil){
        _subviewControllers = [NSMutableArray array];
    }
    [_subviewControllers removeAllObjects];
    
    // Reload bar items title
    NSMutableArray *_barItemTitles = [NSMutableArray array];
    if(_numberOfPages>0){
        if(_block_topInset){
            _topInset = _block_topInset();
        }
        if(_block_bottomInset){
            _bottomInset = _block_bottomInset();
        }
        if(_block_borderColorOfTabBar){
            _tabBarView.separatorLineColor = _block_borderColorOfTabBar();
        }
        if(_block_indicatorColorOfSelectedTabItem){
            _tabBarView.indicatorColor = _block_indicatorColorOfSelectedTabItem();
        }
        if(_block_widthOfTitleItem){
            CGFloat itemWidth = _block_widthOfTitleItem();
            _tabBarView.itemWidth = itemWidth;
        }
        if(_block_titleForPageAtIndex){
            for(int i=0; i< _numberOfPages; i++){
                [_barItemTitles addObject:_block_titleForPageAtIndex(i)];
            }
        }
        else{
            for(int i=0; i< _numberOfPages; i++){
                [_barItemTitles addObject:[NSString stringWithFormat:@"Page %d", i]];
            }
        }
        if(_block_viewControllerAtIndex){
            for(int i=0; i< _numberOfPages; i++){
                [_subviewControllers addObject:[NSNull null]];
            }
        }
    }
    [self layoutSubviewsIfNeeded];
    
    _tabBarView.sourceItems = _barItemTitles;
    
    self.selectedIndex = 0;
    [_contentContainer setContentSize:CGSizeMake(_contentContainer.frame.size.width*_numberOfPages, _contentContainer.frame.size.height)];
}

- (void)transitionToIndex:(NSUInteger)index
{
    [self setSelectedIndex:index];
    [_contentContainer setContentOffset:CGPointMake(index*_contentContainer.frame.size.width, 0) animated:YES];
}

- (void)setSelectedIndex:(NSInteger)index
{
    _selectedIndex = index;
    _tabBarView.selectedIndex = index;
    [self loadViewControllerAtIndex:_selectedIndex];
}

- (void)loadViewControllerAtIndex:(NSUInteger)index
{
    UIViewController *viewController = [self viewControllerAtIndex:index];
    if([self.childViewControllers containsObject:viewController]==NO){
        [self addChildViewController:viewController];
        viewController.view.frame = CGRectMake(index*_contentContainer.frame.size.width, 0, _contentContainer.frame.size.width, _contentContainer.frame.size.height);
        viewController.view.autoresizingMask = _contentContainer.autoresizingMask;
        [_contentContainer addSubview:viewController.view];
        [viewController didMoveToParentViewController:self];
    }
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if(index>=_subviewControllers.count)
        return nil;
    UIViewController *viewController = _subviewControllers[index];
    if([viewController isEqual:[NSNull null]]){
        if(_block_viewControllerAtIndex){
            viewController = _block_viewControllerAtIndex(index);
        }
        _subviewControllers[index] = viewController;
    }
    return _subviewControllers[index];
}

- (void)layoutSubviewsIfNeeded
{
    _tabBarView.frame = CGRectMake(_tab_bar_left_margin, _topInset, self.view.frame.size.width-_tab_bar_left_margin, _tab_bar_height);
    
    float originY = _topInset+_tab_bar_height;
    _contentContainer.frame = CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height-originY-_bottomInset);
    [_contentContainer setContentSize:CGSizeMake(_contentContainer.frame.size.width*_numberOfPages, _contentContainer.frame.size.height)];
}

#pragma mark- scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!scrollByDragging){
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    if(scrollView.contentOffset.x+pageWidth> scrollView.contentSize.width ||
       scrollView.contentOffset.x<0){
        return;
    }
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self setSelectedIndex:page];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    scrollByDragging = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    scrollByDragging = NO;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
