//
//  ViewController.m
//  FriendCircleDemo
//
//  Created by 花花 on 2017/8/15.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "ViewController.h"
#import "TestImageViewController.h"
#import "WebViewController.h"

//model
#import "CommetModel.h"
#import "CommentContentModel.h"

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

- (void)clickRightBtn {
    TestImageViewController *test = [[TestImageViewController alloc]init];
    [self.navigationController pushViewController:test animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //
    
    [self.navigationItem setTitle:@"朋友圈"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"按钮" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBtn)];
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
    
    NSString *url = @"https://api.bestudent.cn/app/school/major/comment/list.action?from=ios&memberId=2165&pageNum=1&pageSize=5&version=1.9.0";
    
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
    
    CommetModel *model = dataArr[section];
    if (model.cmtReplys.count > 0) {
        return 5;
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.001)];
    CommetModel *model = dataArr[section];
    if (model.cmtReplys.count > 0) {
        
        footerView.frame = CGRectMake(0, 0, kScreenWidth, 5);
        footerView.backgroundColor = [UIColor whiteColor];
    }

    return footerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CommetModel *model = dataArr[section];
    
    return 1 + model.cmtReplys.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 45;
    
    CommetModel *model = dataArr[indexPath.section];
    
    if (indexPath.row != 0) {
        CommentContentModel *tmpModel = model.commentModels[indexPath.row-1];
        return tmpModel.contentHeight+10;
    }
    
    
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *iden = @"cell";
        ContentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
        
        if (!cell) {
            cell = [[ContentViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        }
        
        cell.model = dataArr[indexPath.section];
        return cell;
    }
    
    static NSString *iden = @"commentCell";
    CommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (!cell) {
        cell = [[CommentViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    
    CommetModel * model = dataArr[indexPath.section];
    CommentContentModel *tmpModel = model.commentModels[indexPath.row-1];
    cell.model = tmpModel;
    cell.ClickMemberName = ^(CommentContentModel *cmtModel) {
        WebViewController *webVC = [[WebViewController alloc]init];
        webVC.navTitle = cmtModel.replyMemberFromName;
        webVC.httpUrl = @"https://www.baidu.com";
        [self.navigationController pushViewController:webVC animated:YES];
    };
    return cell;
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
////    if (indexPath.row > 0) {
////        //点击评论
////    }
//}

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
            dataArr = [NSMutableArray array];
        }
        
        for (NSDictionary *dic in comments) {
            CommetModel *model = [[CommetModel alloc]initWithDictionary:dic error:nil];
            [dataArr addObject:model];
            
            if (model.cmtReplys.count > 0) {
                
                NSMutableArray *tempArr = [NSMutableArray array];
                for (NSDictionary *tmpDic in model.cmtReplys) {
                    CommentContentModel *tmpModel = [[CommentContentModel alloc]initWithDictionary:tmpDic error:nil];
                    [tempArr addObject:tmpModel];
                }
                
                model.commentModels = tempArr;
            }
        }
        
        [tab_circle reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
