//
//  newsTableViewController.m
//  NewsAPP
//
//  Created by Dragon on 2016/11/11.
//  Copyright © 2016年 Dragon. All rights reserved.
//

#import "newsTableViewController.h"
#import "myTableViewCell.h"
#import "newData.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import <AFNetworking.h>
#import "webViewViewController.h"

@interface newsTableViewController ()<UITableViewDataSource,UITableViewDelegate,DataDlegate>

@property (nonatomic, strong) NSArray *myArray;

@end

@implementation newsTableViewController

- (void) data: (NSMutableArray *)array{
    _myArray=array;
}


- (void)viewDidLoad {
    NSLog(@"%s",__func__);
    [super viewDidLoad];
    //开启Progress
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中";
    newData *new = [[newData alloc]init];
    new.delegate = self;
    [new getdata];

    [hud hide:YES afterDelay:0.2];
    self.tableView.estimatedRowHeight = 120;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%s",__func__);

    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s",__func__);
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
}
#pragma mark - 单元格的点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //参数indexPath是点击cell所在行列的标记
    //自定义所在的 section，在此section中的 第row列
    NSDictionary *dic = _myArray[indexPath.row];
    
    NSString *strUrl = [dic objectForKey:@"url"];
    webViewViewController *web = [[webViewViewController alloc]init];
    web.str = strUrl;
   
    [self.navigationController pushViewController: web animated:YES];
}
-(NSString*)calculatetime :(NSString*)str{
    
    NSDate * senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd-HH-mm"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSArray *locationTime = [locationString componentsSeparatedByString:@"-"];
    
    //2016-11-12 16:26 按照此格式拼接为“yyyy-MM-dd-HH-mm-ss” 的数组
    NSArray *strArray = [str componentsSeparatedByString:@" "];
    NSArray *Y_M_D_Arr = [strArray[0] componentsSeparatedByString:@"-"];
    NSArray *H_S_Arr  = [strArray[1] componentsSeparatedByString:@":"];
    NSArray *newTime = @[Y_M_D_Arr[0],Y_M_D_Arr[1],Y_M_D_Arr[1],H_S_Arr[0],H_S_Arr[1]];
    int day =  [locationTime[2] intValue] -[newTime[2] intValue] ;
    int hour = [locationTime[3] intValue] -[newTime[3] intValue] ;
    int minute = [locationTime[4] intValue]-[newTime[4] intValue] ;
    NSString *time = (day==0)?(hour==0)? [[NSString stringWithFormat:@"%d",minute] stringByAppendingString:@"分钟前"]:[[NSString stringWithFormat:@"%d",hour] stringByAppendingString:@"小时前"]:[[NSString stringWithFormat:@"%d",day] stringByAppendingString:@"天前"];
    return time;
}
@end
