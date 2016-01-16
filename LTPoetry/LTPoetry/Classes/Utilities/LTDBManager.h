//
//  LTDBManager.h
//  LTPoetry
//
//  Created by Latte_Bear on 16/1/9.
//  Copyright © 2016年 Latte_Bear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface LTDBManager : NSObject
///使用单例模式返回一个唯一的数据库对象
+(FMDatabase *)sharedDatabase;
@end
