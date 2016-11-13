//
//  myTableViewCell.h
//  NewsAPP
//
//  Created by Dragon on 2016/11/11.
//  Copyright © 2016年 Dragon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail_pic_s;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail_pic_s02;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail_pic_s03;
@property (weak, nonatomic) IBOutlet UILabel *comment;


@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UILabel *author_name;

@property (weak, nonatomic) NSString *str;

+(instancetype) mycellWithtableView:(UITableView*)tableView;

@end
