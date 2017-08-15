
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
        
        CGFloat coorX = 15;
        CGFloat wdtHeader = 45;
        self.header = [[UIImageView alloc]initWithFrame:CGRectMake(coorX, coorX, wdtHeader, wdtHeader)];
        self.header.layer.cornerRadius = wdtHeader/2.0;
        self.header.layer.masksToBounds = YES;
        
        [self.contentView addSubview:self.header];
        
        //昵称
        self.nickLabel = [UILabel alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    }
    
    return self;
}
@end
