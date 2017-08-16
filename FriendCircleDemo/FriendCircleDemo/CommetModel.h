//
//  CommetModel.h
//  FriendCircleDemo
//
//  Created by 花花 on 2017/8/15.
//  Copyright © 2017年 花花. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>

@interface CommetModel : JSONModel
/*
 {
 applicationId = 4179;
 cmtId = 316;
 cmtImgs =     (
 );
 
 cmtMsg = "\U5b66\U5230\U4e13\U4e1a\U8bfe\U7a0b\Uff0c\U8001\U5e08\U5f88\U8ba4\U771f\U8d1f\U8d23\Uff0c\U5f00\U5fc3\U5b66\U62c9\U4e01\U821e\U3002";
 cmtReplyNum = 4;
 cmtReplys =     (
     {
         applicationId = 4179;
         cmtMemberId = 16828;
         majorId = 2045;
         replyFromMember = 18367;
         replyMemberFromName = "\U4f3c\U61c2\U975e\U61c2";
         replyMsg = "\U5f88\U597d";
     },
     {
         applicationId = 4179;
         cmtMemberId = 16828;
         majorId = 2045;
         replyFromMember = 19881;
         replyMemberFromName = "\U6c34";
         replyMsg = "\U6211\U4e3a\U4ec0\U4e48\U8fdb\U4e0d\U53bb\U5206\U671f\U4ed8\U6b3e\U9875\U9762";
     },
     {
         applicationId = 4179;
         cmtMemberId = 16828;
         majorId = 2045;
         replyFromMember = 21892;
         replyMemberFromName = "\U98ce\U4e00\U6837\U81ea\U7531";
         replyMsg = "\U4f60\U597d";
     },
     {
         applicationId = 4179;
         cmtMemberId = 16828;
         majorId = 2045;
         replyFromMember = 22959;
         replyMemberFromName = "\U534a\U591c\U4e09\U75af";
         replyMsg = "\U4f60\U597d";
     }
 );
  cmtThumbImgs =     (
 );
 cmtTime = "295\U5929\U524d";
 cmtType = 0;
 cmtTypeName = "\U7b2c\U4e00\U5370\U8c61";
 majorId = 2045;
 majorName = "\U62c9\U4e01\U821e\U6559\U5e08\U73ed";
 majorSchoolName = "\U5317\U4eac\U76db\U57fa\U9633\U5149\U56fd\U6807\U821e\U57f9\U8bad\U5b66\U6821";
 memberHead = "http://wx.qlogo.cn/mmopen/Q3auHgzwzM79OmwOQxAQF5zqWkb2MkcRN1FoQlibQa4iazuOAvoEBVLWI5qN5FMWkzMD1B10lnjRLiccAFshUZA7J0mmOlxAjxb66vLJECrhVk/0";
 memberId = 16828;
 memberName = CoCo;
 }

 */

@property (nonatomic, copy) NSNumber *applicationId;
@property (nonatomic, copy) NSNumber *cmtId;
@property (nonatomic, copy) NSArray *cmtImgs;//评论图片
@property (nonatomic, copy) NSString *cmtMsg;//评论内容
@property (nonatomic, copy) NSArray *cmtReplys;//评论数组
@property (nonatomic, copy) NSString *cmtTime;//评论时间

@property (nonatomic, copy) NSString *memberHead;//头像
@property (nonatomic, copy) NSString *memberName;//昵称

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, copy) NSArray *commentModels;
@end
