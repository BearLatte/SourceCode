//
//  LTPoemDetailTableViewController.m
//  LTPoetry
//
//  Created by Latte_Bear on 16/1/9.
//  Copyright © 2016年 Latte_Bear. All rights reserved.
//

#import "LTPoemDetailTableViewController.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>


@interface LTPoemDetailCell : UITableViewCell
@property (nonatomic, strong) UILabel *label;
@end
@implementation LTPoemDetailCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        //在cell的contentView上添加一个UILable
        self.label = [UILabel new];
        self.label.numberOfLines = 0;
        [self.contentView addSubview:self.label];
        //设置约束（Masonry）
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
    }
    return self;
}
@end

@interface LTPoemDetailTableViewController () <AVSpeechSynthesizerDelegate>
@property (nonatomic, strong) LTPoem *poem;
//朗读Item
@property (nonatomic, strong) UIBarButtonItem *readItem;
//语音合成的对象
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@end

@implementation LTPoemDetailTableViewController
-(AVSpeechSynthesizer *)synthesizer {
    if (!_synthesizer) {
        _synthesizer = [AVSpeechSynthesizer new];
        _synthesizer.delegate = self;
    }
    return _synthesizer;
}
-(id)initWithPoem:(LTPoem *)poem {
    if (self = [super init]) {
        self.poem = poem;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
    [self.tableView registerClass:[LTPoemDetailCell class] forCellReuseIdentifier:@"detailCell"];
    //创建readItem并添加
    self.readItem = [[UIBarButtonItem alloc] initWithTitle:@"朗读" style:UIBarButtonItemStyleDone target:self action:@selector(readPoem)];
    self.navigationItem.rightBarButtonItem = self.readItem;
}
-(void)readPoem {
    //判定如果正在读，设置成暂停状态
    if (self.synthesizer.speaking) {
        [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
        return;
    }
//    AVSpeechSynthesizer --> 播放操作
//    AVSpeechUtterance ----> 设置语言/音调/语速
//    AVSpeechSynthesizerDelegate
    //说话方式对象（指定说话内容）
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:[self.poem.poemContent stringByAppendingString:self.poem.poemIntrodution]];
    //设置说话的语言
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"];
    //设置音量(0.0~1.0)
    utterance.volume = 1.0;
    //设置语速
    utterance.rate = 0.5;
    //设置语调
    utterance.pitchMultiplier = 0.5;
    //开始说话
    [self.synthesizer speakUtterance:utterance];

}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}
#pragma mark - AVSpeechDelegate
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    //监听到暂停的动作
    self.readItem.title = @"朗读";
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    //监听到开始读
    self.readItem.title = @"停止";
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    //监听到读完
    self.readItem.title = @"朗读";
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
//设置section的title
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @[@"诗词鉴赏",@"注解"][section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTPoemDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    cell.label.font = [UIFont systemFontOfSize:15];
    cell.label.text = @[self.poem.poemContent,self.poem.poemIntrodution][indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
@end
