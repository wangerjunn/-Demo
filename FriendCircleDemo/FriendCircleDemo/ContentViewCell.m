
//
//  ContentViewCell.m
//  FriendCircleDemo
//
//  Created by 花花 on 2017/8/15.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "ContentViewCell.h"

@interface ContentViewCell () <
    UICollectionViewDelegate,
    UICollectionViewDataSource>
{
    
}

@end

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
        
        //内容
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nickLabel.left, self.nickLabel.bottom+coorX, self.nickLabel.width, 20)];
        self.contentLabel.font = [UIFont systemFontOfSize:15];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.lineBreakMode = NSLineBreakByClipping;
        [self.contentView addSubview:self.contentLabel];
        
        //照片
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat wdtImg = (self.contentLabel.width-10)/3.0;
        
        layout.itemSize = CGSizeMake(wdtImg, wdtImg);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 0;
        _collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cmtImg"];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_collection];
        
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
    
    if (model.imgHeight > 0) {
        _collection.frame = CGRectMake(_contentLabel.left, _contentLabel.bottom+15+5, _contentLabel.width, model.imgHeight);
        self.cmtTimeLabel.frame = CGRectMake(self.contentLabel.left, self.collection.bottom+15, self.contentLabel.width, 15);
        [_collection reloadData];
    }else{
        
        _collection.frame = CGRectZero;
        self.cmtTimeLabel.frame = CGRectMake(self.contentLabel.left, self.contentLabel.bottom+15+5, self.contentLabel.width, 15);
    }
    
    self.cmtTimeLabel.text = [NSString stringWithFormat:@"%@ | %lu张图片评论",model.cmtTime,(unsigned long)model.cmtImgs.count];
    
    
    
}

#pragma mark -- UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _model.cmtImgs.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *iden = @"cmtImg";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    
    if (!cell) {
        CGFloat wdtImg = (self.contentLabel.width-10)/3.0;
        cell = [[UICollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, wdtImg, wdtImg)];
    }
    
    UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:100];
    if (!img) {
        img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.width, cell.height)];
        img.tag = 100;
        
        [cell.contentView addSubview:img];
    }
    NSString *url = _model.cmtThumbImgs[indexPath.item];
    url = @"http://qsx-app.img-cn-beijing.aliyuncs.com/major_comment/2748/3734/cmt_img_1470988109948.png@!dynamic_style";
    [img sd_setImageWithURL:[NSURL URLWithString:url?url:@""] placeholderImage:[UIImage imageNamed:kPlaceHolderImage]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *url = _model.cmtImgs[indexPath.item];
    if (self.clickImageBlock) {
        self.clickImageBlock(url);
    }
}

@end










