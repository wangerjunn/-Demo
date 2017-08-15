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
    
    
    tab_circle = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tab_circle.delegate = self;
    tab_circle.dataSource = self;
    tab_circle.backgroundColor = [UIColor colorWithRed:241/255.0 green:242/255.0 blue:243/255.0 alpha:1];
    tab_circle.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tab_circle];
    
    [self loadData];
}

- (void)loadData {
    
    NSString *url = @"https://api.bestudent.cn/app/school/major/comment/list.action?from=ios&memberId=2165&pageNum=0&pageSize=2&version=1.9.0";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connect = [NSURLConnection connectionWithRequest:request delegate:self];
    
    [connect start];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 45;
    CommetModel *model = dataArr[indexPath.section];
    
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *iden = @"cell";
    ContentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (!cell) {
        cell = [[ContentViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
//    NSDictionary *dic = dataArr[indexPath.row];
//    
//    cell.textLabel.font = [UIFont systemFontOfSize:14];
//    cell.textLabel.numberOfLines = 0;
//    cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",dic[@"cmtMsg"]];
    
    cell.model = dataArr[indexPath.section];
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
//            dataArr = [[NSMutableArray alloc]initWithArray:comments];
//            [tab_circle reloadData];
            dataArr = [NSMutableArray array];
        }
        
        for (NSDictionary *dic in comments) {
            CommetModel *model = [[CommetModel alloc]initWithDictionary:dic error:nil];
            [dataArr addObject:model];
        }
        
        [tab_circle reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
