//
//  CommentContentModel.h
//  FriendCircleDemo
//
//  Created by 花花 on 2017/8/16.
//  Copyright © 2017年 花花. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CommentContentModel : JSONModel

/*
    
 applicationId = 4179;
 cmtMemberId = 16828;
 majorId = 2045;
 replyFromMember = 18367;
 replyMemberFromName = "\U4f3c\U61c2\U975e\U61c2";
 replyMsg = "\U5f88\U597d";
 */

@property (nonatomic, copy) NSNumber *applicationId;
@property (nonatomic, copy) NSNumber *cmtMemberId;
@property (nonatomic, copy) NSString *replyMemberFromName;//评论人
@property (nonatomic, copy) NSString *replyMemberToName;//被回复人
@property (nonatomic, copy) NSString *replyMsg;//评论内容

@property (nonatomic, assign) CGFloat contentHeight;

@end
