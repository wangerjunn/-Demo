//
//  TestImageViewController.m
//  FriendCircleDemo
//
//  Created by 花花 on 2017/8/16.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "TestImageViewController.h"

@interface TestImageViewController ()
{
    UIScrollView *scr;
    
    NSInteger index;
}
@end

@implementation TestImageViewController

#pragma mark -- 切换视图
- (void)exchangeView {
    [scr scrollRectToVisible:CGRectMake(kScreenWidth*index, 0, scr.width, scr.height) animated:YES];
    
    index++;
    if (index == 3) {
        index = 0;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    index = 0;
    [self.navigationItem setTitle:@"test"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(exchangeView)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    scr = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scr.showsVerticalScrollIndicator = NO;
    scr.showsHorizontalScrollIndicator = NO;
    scr.pagingEnabled = YES;
    scr.maximumZoomScale = 2;
//    scr.contentSize = CGSizeMake(kScreenWidth*3, scr.height);
    [self.view addSubview:scr];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:scr.bounds];
    img.userInteractionEnabled = YES;
    [img sd_setImageWithURL:[NSURL URLWithString:_url] placeholderImage:[UIImage imageNamed:kPlaceHolderImage] options:0 progress:NULL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!error) {
            img.image = image;
        }
    }];
//    [img sd_setImageWithURL:[NSURL URLWithString:_url] placeholderImage:[UIImage imageNamed:kPlaceHolderImage]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickScaleImg:)];
    tap.numberOfTapsRequired = 2;
    [img addGestureRecognizer:tap];
    [scr addSubview:img];
    
//    NSArray *colors = @[[UIColor orangeColor],[UIColor lightGrayColor],[UIColor purpleColor]];
//    for (int i = 0; i < colors.count; i ++) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, scr.width, scr.height)];;
//        [scr addSubview:view];
//        UILabel *label = [[UILabel alloc]initWithFrame:view.bounds];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.text = [NSString stringWithFormat:@"%d",i+1];
//        label.font = [UIFont systemFontOfSize:40];
//        label.textColor = [UIColor whiteColor];
//        [view addSubview:label];
//        view.backgroundColor = colors[i];
//        
//        
//    }
}

- (void)clickScaleImg:(UITapGestureRecognizer *)tap {
    
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
