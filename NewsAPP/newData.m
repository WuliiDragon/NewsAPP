//
//  newData.m
//  NewsAPP
//
//  Created by Dragon on 2016/11/11.
//  Copyright © 2016年 Dragon. All rights reserved.
//

#import "newData.h"
#import <AFNetworking.h>

@implementation newData


-(void) getdata{
    NSLog(@"%s",__func__);

    __block NSMutableArray *result = [[NSMutableArray alloc] init];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    //在数组里面添加请求参数
    params[@"key"] = @"ad8e3cf67ed35b9789848d40b904eda7";
    params[@"type"] = @"tiyu";
    
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //发送请求
    [manager GET:@"http://v.juhe.cn/toutiao/index" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //如果数据请求成功返回到responseObject中
        NSMutableDictionary *datasouce=[responseObject mutableCopy];
        //在返回的字典中通过关键字result索引到的数据存放到另外的数组中
        NSDictionary *resultArray = [datasouce objectForKey:@"result"];
        NSMutableArray *data = [resultArray objectForKey:@"data"];
        
        [self.delegate data:data];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
