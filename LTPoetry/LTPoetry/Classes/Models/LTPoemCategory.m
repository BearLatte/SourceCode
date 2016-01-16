//
//  LTPoemCategory.m
//  LTPoetry
//
//  Created by Latte_Bear on 16/1/9.
//  Copyright © 2016年 Latte_Bear. All rights reserved.
//

#import "LTPoemCategory.h"
#import "LTDBManager.h"
#import "FMDatabase.h"

@implementation LTPoemCategory
+(NSArray *)parsePoetryCategory {
    //获取数据库对象
    FMDatabase *database = [LTDBManager sharedDatabase];
    //获取T_KIND表中的所有数据
    FMResultSet *resultSet = [database executeQuery:@"select * from t_kind"];
    //循环解析
    NSMutableArray *categoryMutableArray = [NSMutableArray array];
    while ([resultSet next]) {
        LTPoemCategory *poemCategory = [LTPoemCategory new];
        //解析（resultSet每条记录 <-------> poemCategory）
        poemCategory.poemCategory = [resultSet stringForColumn:@"D_KIND"];
        poemCategory.number = [resultSet intForColumn:@"D_NUM"];
        poemCategory.categoryIntroduction = [resultSet stringForColumn:@"D_INTROKIND"];
        poemCategory.poemComment = [resultSet stringForColumn:@"D_INTROKIND2"];
        [categoryMutableArray addObject:poemCategory];
    }
    //收尾工作(释放resultSet占用内存；关闭数据库)
    [database closeOpenResultSets];
    [database close];
    return [categoryMutableArray copy];
}
+(BOOL)removePoemCategory:(NSString *)category {
    FMDatabase *database = [LTDBManager sharedDatabase];
    BOOL isSuccess = [database executeUpdateWithFormat:@"delete from T_KIND where D_KIND = %@",category];
    //收尾
    [database close];
    return isSuccess;
}
@end