//
//  ViewController.m
//  FriendCircleDemo
//
//  Created by 花花 on 2017/8/15.
//  Copyright © 2017年 花花. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kNavigationBarHeight 64

#import "ViewController.h"

//model
#import "CommetModel.h"

//view
#import "ContentViewCell.h"
#import "CommentViewCell.h"

@interface ViewController () <
    NSURLConnectionDelegate,
    NSURLConnectionDataDelegate,
    UITableViewDelegate,
    UITableViewDataSource>
{
    UITableView *tab_circle;
    NSMutableArray *dataArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //
    
    [self.navigationItem setTitle:@"朋友圈"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTable];
}

- (void)createTable {
    
    
    tab_circle = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tab_circle.delegate = self;
    tab_circle.dataSource = self;
    tab_circle.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tab_circle];
    
    [self loadData];
}

- (void)loadData {
    
    NSString *url = @"https://api.bestudent.cn/app/school/major/comment/list.action?from=ios&memberId=2165&pageNum=0&pageSize=2&version=1.9.0";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connect = [NSURLConnection connectionWithRequest:request delegate:self];
    
    [connect start];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *iden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    NSDictionary *dic = dataArr[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",dic[@"cmtMsg"]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"请求失败");
}

#pragma mark -- NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"jsonDict = %@",jsonDict);
    
    if ([jsonDict isKindOfClass:[NSDictionary class]]) {
        NSArray *comments = jsonDict[@"data"][@"comments"];
        
        if (!dataArr) {
            dataArr = [[NSMutableArray alloc]initWithArray:comments];
            [tab_circle reloadData];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
