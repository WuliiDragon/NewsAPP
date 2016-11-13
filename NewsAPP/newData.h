//
//  newData.h
//  NewsAPP
//
//  Created by Dragon on 2016/11/11.
//  Copyright © 2016年 Dragon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataDlegate <NSObject>//通过代理将得到的JSON数据传递到ViewController

- (void) data: (NSMutableArray *)array;

@end



@interface newData : NSObject

@property (nonatomic, weak) id <DataDlegate> delegate;
-(void) getdata;

@end

