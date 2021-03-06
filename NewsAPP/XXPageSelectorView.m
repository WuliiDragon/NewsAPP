//
//  XXPageSelectorView.m
//  XXPageViewController
//
//  Created by yxlong on 15/5/19.
//  Copyright (c) 2015年 yixin. All rights reserved.
//

#import "XXPageSelectorView.h"

#define _bar_item_tag_base 1000
#define _bar_item_width 80
#define defaultSeparatorLineColor [UIColor orangeColor]
#define defaultIndicatorColor [UIColor whiteColor]

@interface XXPageSelectorView ()
{
    UIScrollView *_scrollView;
}

- (void)_cleanupItems;
@end

@implementation XXPageSelectorView
@synthesize separatorLineColor=_separatorLineColor;
@synthesize sourceItems=_sourceItems;

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        self.userInteractionEnabled = YES;
        _itemWidth = _bar_item_width;
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor colorWithRed:247.f / 255.f green:248.f / 255.f blue:249.f / 255.f alpha:1];
        [self addSubview:_scrollView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame itemTitles:(NSArray *)array
{
    if(self=[self initWithFrame:frame]){
        self.sourceItems = array;
    }
    return self;
}

- (void)_cleanupItems
{
    for(UIView *v in _scrollView.subviews){
        if([v isKindOfClass:[XXPageSelectorItem class]]){
            [v removeFromSuperview];
        }
    }
}

- (void)setItemWidth:(CGFloat)width
{
    _itemWidth = width;
    if(_sourceItems.count>0){
        int i=0;
        for(NSString *title in _sourceItems){
            XXPageSelectorItem *btn = (XXPageSelectorItem *)[_scrollView viewWithTag:_bar_item_tag_base+i];
            if(btn==nil){
                btn.tag = _bar_item_tag_base+i;
                [btn setTitle:title forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn.indicatorColor = [UIColor orangeColor];
                [btn addTarget:self action:@selector(_barItemSelect:) forControlEvents:UIControlEventTouchUpInside];
                [_scrollView addSubview:btn];
            }
            btn.frame = CGRectMake(i*_itemWidth, 0, _itemWidth, self.frame.size.height);
            i++;
        }
    }
//    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.scrollEnabled = NO;
    [_scrollView setContentSize:CGSizeMake(_itemWidth*_sourceItems.count, self.frame.size.height)];
}

- (void)setSourceItems:(NSArray *)array
{
    _sourceItems = array;
    [self _cleanupItems];
    if(_sourceItems.count>0){
        int i=0;
        for(NSString *title in _sourceItems){
            XXPageSelectorItem *btn = [[XXPageSelectorItem alloc] init];
            btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
            btn.tag = _bar_item_tag_base+i;
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.indicatorColor = self.indicatorColor;
            [btn addTarget:self action:@selector(_barItemSelect:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:btn];
            btn.frame = CGRectMake(i*_itemWidth, 0, _itemWidth, self.frame.size.height);
            i++;
        }
    }
//    [_scrollView setContentSize:CGSizeMake(_itemWidth*_sourceItems.count, self.frame.size.height)];
}

- (UIColor*)separatorLineColor
{
    if(_separatorLineColor){
        return _separatorLineColor;
    }
    return defaultSeparatorLineColor;
}

- (void)setSeparatorLineColor:(UIColor *)color
{
    _separatorLineColor = color;
    [self setNeedsDisplay];
}

- (void)_barItemSelect:(id)sender
{
    XXPageSelectorItem *btn = (XXPageSelectorItem *)sender;
    NSUInteger willSelectedIndex = btn.tag-_bar_item_tag_base;
    
    if(willSelectedIndex==_selectedIndex){
        return;
    }
    if(_block_didSelectedAtIndex){
        _block_didSelectedAtIndex(willSelectedIndex);
    }
}

- (void)setSelectedIndex:(NSUInteger)index
{
    UIButton *lastBtn = (UIButton *)[_scrollView viewWithTag:(_selectedIndex+_bar_item_tag_base)];
    lastBtn.selected = NO;
    
    _selectedIndex = index;
    
    UIButton *selectedBtn = (UIButton *)[_scrollView viewWithTag:(index+_bar_item_tag_base)];
    selectedBtn.selected = YES;
    
    UIView *willSelectedBarItem = [_scrollView viewWithTag:(index+_bar_item_tag_base)];
    CGRect visibleFrame = willSelectedBarItem.frame;
    visibleFrame.origin.x -= _bar_item_width*2;
    visibleFrame.size.width = CGRectGetWidth(self.frame);
    
    [_scrollView scrollRectToVisible:visibleFrame animated:YES];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [self.separatorLineColor setStroke];
    [bezierPath setLineWidth:1.0];
    
    [bezierPath moveToPoint:CGPointMake(0.0, 0.0)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect), 0.0)];
    [bezierPath stroke];
    
    [bezierPath moveToPoint:CGPointMake(0.0, CGRectGetHeight(rect))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect))];
    [bezierPath stroke];
}

@end

@implementation XXPageSelectorItem
@synthesize indicatorColor=_indicatorColor;

- (UIColor *)indicatorColor
{
    if(_indicatorColor){
        return _indicatorColor;
    }
    return defaultIndicatorColor;
}

- (void)setIndicatorColor:(UIColor *)color
{
    _indicatorColor = color;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    if (self.selected) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        // Draw the indicator
        [bezierPath moveToPoint:CGPointMake(0.0, CGRectGetHeight(rect) - 1.0)];
        [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect) - 1.0)];
        [bezierPath setLineWidth:3.0];
        [self.indicatorColor setStroke];
        [bezierPath stroke];
    }
}

@end

