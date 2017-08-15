//
//  ContentViewCell.h
//  FriendCircleDemo
//
//  Created by 花花 on 2017/8/15.
//  Copyright © 2017年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommetModel.h"

@interface ContentViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *header;
@property (nonatomic, strong) UILabel *nickLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *cmtTimeLabel;

@property (nonatomic, copy) CommetModel *model;

@end
