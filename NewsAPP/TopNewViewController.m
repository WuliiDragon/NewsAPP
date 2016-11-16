//
//  TopNewViewController.m
//  NewsAPP
//
//  Created by 管理员 on 2016/11/16.
//  Copyright © 2016年 Dragon. All rights reserved.
//

#import "TopNewViewController.h"
#import "HYBLoopScrollView.h"
#import "newData.h"
#import "myTableViewCell.h"
#import "webViewViewController.h"
#import "UIImageView+WebCache.h"

@interface TopNewViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak,nonatomic)   NSArray *dataArr;
@property (strong, nonatomic) UIView *headerView;
@property(strong,nonatomic) UIScrollView *scree;
@property(strong,nonatomic) UITableView *tableView;

@end
@implementation TopNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     // [_tableView reloadData];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(notificationAction:) name: @"notificationAction" object:nil];
    _tableView =  [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    
    self.tableView.estimatedRowHeight = 120;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.delegate =self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myTableViewCell *cell = [myTableViewCell mycellWithtableView:tableView];
    NSDictionary  *new =  _dataArr[indexPath.row];
    cell.title.text = [new objectForKey:@"title"];
    [cell.thumbnail_pic_s sd_setImageWithURL:[NSURL URLWithString: [new objectForKey:@"thumbnail_pic_s"]]];
    NSLog(@"----------------------------------------------%@",[new objectForKey:@"thumbnail_pic_s"]);
    NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++%@",[new objectForKey:@"title"]);
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
    NSDictionary *dic = _dataArr[indexPath.row];
    NSString *strUrl = [dic objectForKey:@"url"];
    webViewViewController *web = [[webViewViewController alloc]init];
    web.str = strUrl;
    NSLog(@"%@",strUrl);
    [self.navigationController pushViewController:web animated:YES];
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


-(void)notificationAction:(NSNotification *)notification{
   _dataArr =  notification.object;
    [self LoadLoopScrollView];
    
}

-(void)LoadLoopScrollView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSMutableArray *images  = [[NSMutableArray alloc]init];
    NSMutableArray *titles   = [[NSMutableArray alloc]init];
    for (int i = 0 ; i<4 ;i++){
        NSDictionary *news = _dataArr[i];
        NSString *url = [news objectForKey:@"thumbnail_pic_s"];
        NSString *title = [news objectForKey:@"title"];
        [images addObject:url];
        [titles addObject:title];
    }
    __weak __typeof(self) weakSelf = self;
    HYBLoopScrollView *loop = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) imageUrls:images timeInterval:3  didSelect:^(NSInteger atIndex) {
        NSLog(@"%ld",(long)atIndex);
        [weakSelf dismissViewControllerAnimated:YES completion:NULL];
    } didScroll:^(NSInteger toIndex) {
        //
    }];
    loop.shouldAutoClipImageToViewSize = NO;
    loop.placeholder = [UIImage imageNamed:@"default.png"];
    loop.alignment = kPageControlAlignRight;
    loop.adTitles = titles;
    [loop pauseTimer];
    loop.imageContentMode = UIViewContentModeScaleToFill;
    _tableView.tableHeaderView =  loop;
}
@end
