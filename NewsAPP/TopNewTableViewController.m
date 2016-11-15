//
//  TopNewTableViewController.m
//  NewsAPP
//
//  Created by 管理员 on 2016/11/15.
//  Copyright © 2016年 Dragon. All rights reserved.
//

#import "TopNewTableViewController.h"
#import "myTableViewCell.h"

@interface TopNewTableViewController ()

@end

@implementation TopNewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getdata:) name:@"AppDidEnterBackground" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    myTableViewCell *cell = [myTableViewCell mycellWithtableView:tableView];
    NSDictionary  *new =  _myArray[indexPath.row];
    cell.title.text = [new objectForKey:@"title"];
    [cell.thumbnail_pic_s sd_setImageWithURL:[NSURL URLWithString: [new objectForKey:@"thumbnail_pic_s"]]];
    cell.author_name.text = [new objectForKey:@"author_name"];
    cell.comment.text =  [[ NSString stringWithFormat:@" " ] stringByAppendingString:[[NSString stringWithFormat:@"%d", arc4random_uniform(300)] stringByAppendingString:@"条评论"]];
    cell.str =[new objectForKey:@"url"];
    NSString  *time =[new objectForKey:@"date"];
    if (time!=nil) {
        NSString *result =  [self calculatetime:time];
        cell.date.text = result;
    }
    
    return cell;

    
    return cell;
}


/
@end
