//
//  LTPeomListTableViewController.h
//  LTPoetry
//
//  Created by Latte_Bear on 16/1/9.
//  Copyright © 2016年 Latte_Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTPoemCategory.h"

@interface LTPeomListTableViewController : UITableViewController
-(id)initWithCategory:(LTPoemCategory *)category;
@end
