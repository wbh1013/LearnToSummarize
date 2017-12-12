//
//  WBHWebViewJSController.m
//  WBHLearnToSummarize
//
//  Created by hjy on 2017/12/12.
//  Copyright © 2017年 baohong. All rights reserved.
//

#import "WBHWebViewJSController.h"
#import <WebKit/WebKit.h>
#import <WebKit/WKWebView.h>
#import "WBHWebViewJSController+WBHDelegate.h"
static void *WkwebBrowserContext = &WkwebBrowserContext;
@interface WBHWebViewJSController ()
//
@property (nonatomic,strong)WKWebView * webView;

@end

@implementation WBHWebViewJSController

- (void)viewDidLoad {
    [super viewDidLoad];
//    WKUserContentController
    [self.view addSubview:self.webView];
    //添加进度条
    [self.view addSubview:self.progressView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
}


-(WKWebView *)webView{
    if (_webView == nil) {
        _webView = [[WKWebView alloc]init];
        _webView.scrollView.backgroundColor = [UIColor whiteColor];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        //kvo 添加进度监控
        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
    }
    return _webView;
}

//  KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.webView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 3);
        
        // 设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
        _progressView.progressTintColor = [UIColor orangeColor];
    }
    return _progressView;
}

@end
