//
//  LTPeomListTableViewController.m
//  LTPoetry
//
//  Created by Latte_Bear on 16/1/9.
//  Copyright © 2016年 Latte_Bear. All rights reserved.
//

#import "LTPeomListTableViewController.h"
#import "LTPoem.h"
#import "LTPoemDetailTableViewController.h"


@interface LTPoemCell : UITableViewCell
@end


@implementation LTPoemCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
@end


@interface LTPeomListTableViewController ()
//选择的某个诗词分类的string
@property (nonatomic, strong) NSString *categoryStr;
@property (nonatomic, strong) NSArray *poemArray;
@end

@implementation LTPeomListTableViewController
-(id)initWithCategory:(LTPoemCategory *)category {
    if (self = [super init]) {
        self.categoryStr = category.poemCategory;
    }
    return self;
}
-(NSArray *)poemArray {
    if (!_poemArray) {
        _poemArray = [LTPoem poetryListWithCategory:self.categoryStr];
    }
    return _poemArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[LTPoemCell class] forCellReuseIdentifier:@"poemCell"];
    //设置标题
    self.title = @"诗词列表";
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.poemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTPoemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"poemCell"];
    LTPoem *poem = self.poemArray[indexPath.row];
    cell.textLabel.text = poem.poemTitle;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.text = poem.poemAuthor;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LTPoem *poem = self.poemArray[indexPath.row];
    LTPoemDetailTableViewController *detailViewController = [[LTPoemDetailTableViewController alloc] initWithPoem:poem];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//修改左划的文本
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //创建UIAlertController
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除诗词" message:@"确定永久删除该诗词?" preferredStyle:UIAlertControllerStyleAlert];
        //创建两个UIAlertAction对象（取消/确定）
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //数据来源
            LTPoem *poem = self.poemArray[indexPath.row];
            if ([LTPoem removePoem:poem.poemID]) {
                //更新数据源
                self.poemArray = [LTPoem poetryListWithCategory:self.categoryStr];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
        //添加两个action到alertController中
        [alertController addAction:cancelAction];
        [alertController addAction:deleteAction];
        //显示出来（present）
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
@end
