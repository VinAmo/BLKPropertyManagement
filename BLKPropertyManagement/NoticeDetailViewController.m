//
//  NoticeDetailViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTPDataFetcher.h"
#import "NoticeDetailViewController.h"

@interface NoticeDetailViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    _indicator = [[UIActivityIndicatorView alloc] init];
    _indicator.frame = CGRectMake(0, 0, 100, 100);
    _indicator.center = webView.center;
    [_indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [webView addSubview:_indicator];
    
    [HTTPDataFetcher setCookies];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingFormat:@"/AppNotice/findNoticeView.do?uuid=%@", _uuid];
//    NSString *parameters = [NSString stringWithFormat:@"uuid=%@", _uuid];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    [HTTPDataFetcher deleteCookies];
}

#pragma mark - web view delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.indicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Failed load with error: %@", error);
}

@end
