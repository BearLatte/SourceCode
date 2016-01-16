//
//  LTPoem.h
//  LTPoetry
//
//  Created by Latte_Bear on 16/1/9.
//  Copyright © 2016年 Latte_Bear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTPoem : NSObject
///诗词内容
@property (nonatomic, strong) NSString *poemContent;
///诗词介绍
@property (nonatomic, strong) NSString *poemIntrodution;
///诗词作者名字
@property (nonatomic, strong) NSString *poemAuthor;
///当前诗词所属分类
@property (nonatomic, strong) NSString *poemCategory;
///诗词的标题
@property (nonatomic, strong) NSString *poemTitle;
///诗词ID
@property (nonatomic, assign) int poemID;

///给定一个诗词的类别，返回所有解析好的LTPoem数组
+(NSArray *)poetryListWithCategory:(NSString *)category;
///给定一个诗词的ID，返回是否删除成功的BOOL值
+(BOOL)removePoem:(int)poemID;
@end