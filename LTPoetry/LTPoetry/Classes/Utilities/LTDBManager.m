//
//  LTDBManager.m
//  LTPoetry
//
//  Created by Latte_Bear on 16/1/9.
//  Copyright © 2016年 Latte_Bear. All rights reserved.
//

#import "LTDBManager.h"

@implementation LTDBManager
+(FMDatabase *)sharedDatabase {
    //声明一个静态的对象
    static FMDatabase *database = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //拼接拷贝的路径
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *copyDBPath = [documentsPath stringByAppendingPathComponent:@"sqlite.db"];
        //获取数据库文件的路径
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Poetry" ofType:@"bundle"];
        //拼接数据库文件路径
        NSString *databaseFilePath = [bundlePath stringByAppendingPathComponent:@"sqlite.db"];
        NSError *error = nil;
        if (![[NSFileManager defaultManager] fileExistsAtPath:copyDBPath]) {
            [[NSFileManager defaultManager] copyItemAtPath:databaseFilePath toPath:copyDBPath error:&error];
            }
        if (!error) {
                //初始化database对象
                database = [FMDatabase databaseWithPath:copyDBPath];
            }else {
                NSLog(@"拷贝失败:%@",error.userInfo);
        }
        
    });
    //!!!手动打开数据库
    [database open];
    return database;
}
@end