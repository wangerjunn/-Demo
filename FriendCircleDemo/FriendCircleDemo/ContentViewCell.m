
//
//  ContentViewCell.m
//  FriendCircleDemo
//
//  Created by 花花 on 2017/8/15.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "ContentViewCell.h"

@implementation ContentViewCell

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
        CGFloat coorX = 15;
        CGFloat wdtHeader = 45;
        self.header = [[UIImageView alloc]initWithFrame:CGRectMake(coorX, coorX, wdtHeader, wdtHeader)];
        self.header.layer.cornerRadius = wdtHeader/2.0;
        self.header.layer.masksToBounds = YES;
        self.header.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.header];
        
        //昵称
        self.nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.header.right+coorX, self.header.top+5, kScreenWidth-self.header.right-coorX*2, 20)];
        self.nickLabel.textColor = BlueFontColor;
        self.nickLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.nickLabel];
        
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nickLabel.left, self.nickLabel.bottom+coorX, self.nickLabel.width, 20)];
        self.contentLabel.font = [UIFont systemFontOfSize:15];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.lineBreakMode = NSLineBreakByClipping;
        [self.contentView addSubview:self.contentLabel];
        
        //时间
        self.cmtTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentLabel.left, self.contentLabel.bottom+coorX+5, self.contentLabel.width, 15)];
        self.cmtTimeLabel.font = [UIFont systemFontOfSize:11];
        self.cmtTimeLabel.textColor = k99Gray;
        [self.contentView addSubview:self.cmtTimeLabel];
        
    }
    
    return self;
}

- (void)setModel:(CommetModel *)model {
    _model = model;
    [self.header sd_setImageWithURL:[NSURL URLWithString:model.memberHead]];
    self.nickLabel.text = model.memberName;
    
    self.contentLabel.frame = CGRectMake(self.contentLabel.left, self.contentLabel.top, self.contentLabel.width, model.contentHeight);
    self.contentLabel.text = model.cmtMsg;
    
    self.cmtTimeLabel.frame = CGRectMake(self.contentLabel.left, self.contentLabel.bottom+15+5, self.contentLabel.width, 15);
    self.cmtTimeLabel.text = [NSString stringWithFormat:@"%@ | %lu张图片评论",model.cmtTime,(unsigned long)model.cmtImgs.count];
    
}

@end










