//
//  LTTableViewCell.h
//  LTPoetry
//
//  Created by Latte_Bear on 16/1/8.
//  Copyright © 2016年 Latte_Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTTableViewCell : UITableViewCell
///诗词分类标题
@property (weak, nonatomic) IBOutlet UILabel *poemLabel;
///详情按钮
@property (weak, nonatomic) IBOutlet UIButton *poemButton;

@end
