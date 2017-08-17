//
//  CommentContentModel.m
//  FriendCircleDemo
//
//  Created by 花花 on 2017/8/16.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "CommentContentModel.h"

@implementation CommentContentModel

/* 属性都是可选的  如果Model中属性多了 也不会崩溃 */
+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return  YES;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    if (self = [super initWithDictionary:dict error:err]) {
        
        NSString *msg = [NSString stringWithFormat:@"%@:%@",_replyMemberFromName?_replyMemberFromName:@"",_replyMsg?_replyMsg:@""];
        
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = 4;
        
        NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12],
                                      NSParagraphStyleAttributeName:paragraph };
        CGSize size_con = [msg boundingRectWithSize:CGSizeMake(kScreenWidth-90-13, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
        
        _contentHeight = size_con.height+5;
    }
    
    
    return self;
}

@end
