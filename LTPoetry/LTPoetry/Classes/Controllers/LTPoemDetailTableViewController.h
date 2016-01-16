//
//  LTPoemDetailTableViewController.h
//  LTPoetry
//
//  Created by Latte_Bear on 16/1/9.
//  Copyright © 2016年 Latte_Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTPoem.h"

@interface LTPoemDetailTableViewController : UITableViewController
-(id)initWithPoem:(LTPoem *)poem;
@end
