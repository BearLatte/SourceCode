//
//  LTPoem.m
//  LTPoetry
//
//  Created by Latte_Bear on 16/1/9.
//  Copyright © 2016年 Latte_Bear. All rights reserved.
//

#import "LTPoem.h"
#import "LTDBManager.h"
#import "FMDatabase.h"

@implementation LTPoem
+(NSArray *)poetryListWithCategory:(NSString *)category {
    //获取数据库对象
    FMDatabase *database = [LTDBManager sharedDatabase];
    //有条件的查询resultSet
    FMResultSet *resultSet = [database executeQueryWithFormat:@"select * from T_SHI where D_KIND = %@",category];
    //循环进行解析(resultSet <---> LTPoem)
    NSMutableArray *mutableArray = [NSMutableArray array];
    while ([resultSet next]) {
        LTPoem *poem = [LTPoem new];
        poem.poemContent = [resultSet stringForColumn:@"D_SHI"];
        poem.poemIntrodution = [resultSet stringForColumn:@"D_INTROSHI"];
        poem.poemAuthor = [resultSet stringForColumn:@"D_AUTHOR"];
        poem.poemCategory = [resultSet stringForColumn:@"D_KIND"];
        poem.poemTitle = [resultSet stringForColumn:@"D_TITLE"];
        poem.poemID = [resultSet intForColumn:@"D_ID"];
        [mutableArray addObject:poem];
    }
    //收尾工作
    [database closeOpenResultSets];
    [database close];
    return [mutableArray copy];
}
+(BOOL)removePoem:(int)poemID {
    FMDatabase *database = [LTDBManager sharedDatabase];
    /*
     执行删除操作
     除了查询操作，其他(增/删/改)操作指定为更新操作
     */
    BOOL isSuccess = [database executeUpdateWithFormat:@"delete from T_SHI where D_ID = %d",poemID];
    [database close];
    return isSuccess;
}
@end
