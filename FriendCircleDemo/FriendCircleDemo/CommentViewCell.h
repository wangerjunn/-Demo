//
//  CommentViewCell.h
//  FriendCircleDemo
//
//  Created by 花花 on 2017/8/15.
//  Copyright © 2017年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentContentModel.h"

@interface CommentViewCell : UITableViewCell

@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UITextView *commentLabel;

@property (nonatomic, copy) CommentContentModel *model;
@property (nonatomic, copy) void(^ClickMemberName)(CommentContentModel *cmtModel);
@property (nonatomic, copy) void(^clickCommentContent)();

@end
