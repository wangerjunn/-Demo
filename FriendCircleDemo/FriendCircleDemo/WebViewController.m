
//
//  WebViewController.m
//  FriendCircleDemo
//
//  Created by 花花 on 2017/8/16.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:web];
    
    [self.navigationItem setTitle:_navTitle?_navTitle:@""];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_httpUrl]];
    
    [web loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
