//
//  myTableViewCell.m
//  NewsAPP
//
//  Created by Dragon on 2016/11/11.
//  Copyright © 2016年 Dragon. All rights reserved.
//

#import "myTableViewCell.h"

@implementation myTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
+(instancetype)mycellWithtableView:(UITableView *)tableView{
   static NSString *cellID = @"mycell";
    myTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell==nil){
       cell = [[[NSBundle mainBundle ]loadNibNamed:@"myTableViewCell" owner:self options:nil]lastObject];
        
    }
    return cell;
    
}

@end
