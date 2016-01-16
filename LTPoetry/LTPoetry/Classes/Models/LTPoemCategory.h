//
//  LTPoemCategory.h
//  LTPoetry
//
//  Created by Latte_Bear on 16/1/9.
//  Copyright © 2016年 Latte_Bear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTPoemCategory : NSObject
///诗词分类
@property (nonatomic, strong) NSString *poemCategory;
///诗词的ID
@property (nonatomic, assign) int number;
///当前诗词分类介绍
@property (nonatomic, strong) NSString *categoryIntroduction;
///当前分类的备注
@property (nonatomic, strong) NSString *poemComment;

///提供一个接口返回所有已经解析好的诗词分类对象的数组（LTPoemCategory）
+(NSArray *)parsePoetryCategory;
///删除指定那个诗词的分类，返回bool值
+(BOOL)removePoemCategory:(NSString *)category;
@end