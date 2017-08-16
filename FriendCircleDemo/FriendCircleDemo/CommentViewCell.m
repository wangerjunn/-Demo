//
//  CommentViewCell.m
//  FriendCircleDemo
//
//  Created by 花花 on 2017/8/15.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "CommentViewCell.h"
@interface CommentViewCell () <UITextViewDelegate>
{
    
}

@end

@implementation CommentViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.grayView = [[UIView alloc]initWithFrame:CGRectMake(75, 0, kScreenWidth-75-15, 20)];
        self.grayView.backgroundColor = UIColorFromRGB(0xf1f2f3);
        
        [self.contentView addSubview:self.grayView];
        
        self.commentLabel = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, self.grayView.width-10, self.grayView.height-10)];
        self.commentLabel.backgroundColor = UIColorFromRGB(0xf1f2f3);
        self.commentLabel.scrollEnabled = NO;
        self.commentLabel.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.commentLabel.delegate = self;
//        self.commentLabel.numberOfLines = 0;
        self.commentLabel.editable = NO;
        self.commentLabel.textColor = K33Color;
//        self.commentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.commentLabel.font = [UIFont systemFontOfSize:12];
        [self.grayView addSubview:self.commentLabel];
    }
    
    return self;
}

- (void)setModel:(CommentContentModel *)model {
    _model = model;
    
    _commentLabel.frame = CGRectMake(_commentLabel.left, _commentLabel.top, _commentLabel.width, model.contentHeight);
    
    _grayView.frame = CGRectMake(_grayView.left, _grayView.top, _grayView.width, model.contentHeight+10);
    _commentLabel.text = [NSString stringWithFormat:@"%@:%@",model.replyMemberFromName?model.replyMemberFromName:@"",model.replyMsg?model.replyMsg:@""];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:_commentLabel.text];
    
    NSRange range = [_commentLabel.text rangeOfString:model.replyMemberFromName];
    
    [attri addAttribute:NSForegroundColorAttributeName value:BlueFontColor range:range];
    [attri addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"https://www.baidu.com"] range:range];
    _commentLabel.attributedText = attri;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    NSLog(@"url = %@",URL.absoluteString);
    if (URL.absoluteString) {
        if (self.ClickMemberName) {
            self.ClickMemberName(_model);
        }
    }
    return NO;
}

@end
