//
//  LTMainTableViewController.m
//  LTPoetry
//
//  Created by Latte_Bear on 16/1/8.
//  Copyright © 2016年 Latte_Bear. All rights reserved.
//

#import "LTMainTableViewController.h"
#import "LTPoemCategory.h"
#import "LTPoem.h"
#import "LTTableViewCell.h"
#import "LTPeomListTableViewController.h"
#import "LTCategoryIntroductionViewController.h"

@interface LTMainTableViewController ()
@property (nonatomic, strong) NSArray *poemCategoryArray;
@end

@implementation LTMainTableViewController
-(NSArray *)poemCategoryArray {
    if (!_poemCategoryArray) {
        _poemCategoryArray = [LTPoemCategory parsePoetryCategory];
    }
    return _poemCategoryArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.poemCategoryArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    LTPoemCategory *category = self.poemCategoryArray[indexPath.row];
    cell.poemLabel.text = category.poemCategory;
    cell.poemLabel.font = [UIFont systemFontOfSize:15];
    //button是否显示
    if (category.categoryIntroduction.length == 0) {
        cell.poemButton.hidden = YES;
    }else {
        //显示四次分类的详情控制器
        [cell.poemButton setTag:indexPath.row];
        [cell.poemButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //数据来源
    LTPoemCategory *category = self.poemCategoryArray[indexPath.row];
    //push显示当前分类的所有诗词列表
    LTPeomListTableViewController *peomListTableViewcontroller = [[LTPeomListTableViewController alloc] initWithCategory:category];
    [self.navigationController pushViewController:peomListTableViewcontroller animated:YES];
}
#pragma mark - 点击详情按钮之后触发
-(void)clickButton:(id)sender {
    LTPoemCategory *category = self.poemCategoryArray[[sender tag]];
    LTCategoryIntroductionViewController *introductionViewController = [LTCategoryIntroductionViewController new];
    introductionViewController.poemIntroduction = category.categoryIntroduction;
    [self.navigationController pushViewController:introductionViewController animated:YES];
}
@end
