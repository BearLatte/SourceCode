//
//  LTCategoryIntroductionViewController.m
//  LTPoetry
//
//  Created by Latte_Bear on 16/1/9.
//  Copyright © 2016年 Latte_Bear. All rights reserved.
//

#import "LTCategoryIntroductionViewController.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>

@interface LTCategoryIntroductionViewController () <AVSpeechSynthesizerDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@property (nonatomic, strong) UIBarButtonItem *voiceItem;
@end

@implementation LTCategoryIntroductionViewController
-(UIBarButtonItem *)voiceItem {
    if (!_voiceItem) {
        _voiceItem = [[UIBarButtonItem alloc] initWithTitle:@"朗读" style:UIBarButtonItemStyleDone target:self action:@selector(clickButtonStartRead)];
    }
    return _voiceItem;
}
-(AVSpeechSynthesizer *)synthesizer {
    if (!_synthesizer) {
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
        _synthesizer.delegate = self;
    }
    return _synthesizer;
}
-(UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        //设置文字
        _textView.text = self.poemIntroduction;
        _textView.font = [UIFont systemFontOfSize:17];
        _textView.editable = NO;
        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
    }
    return _textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.textView.hidden = NO;
    self.navigationItem.rightBarButtonItem = self.voiceItem;
}
-(void)clickButtonStartRead {
    if (self.synthesizer.speaking) {
        [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
        return;
    }
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.poemIntroduction];
    utterance.rate = 0.5;
    utterance.volume = 1.0;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"];
    [self.synthesizer speakUtterance:utterance];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}
#pragma mark - AVSpeechSynthesizerDelegate
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.voiceItem.title = @"停止";
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.voiceItem.title = @"朗读";
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.voiceItem.title = @"朗读";
}
@end