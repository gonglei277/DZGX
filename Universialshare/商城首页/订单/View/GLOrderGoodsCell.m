//
//  GLOrderGoodsCell.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/26.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLOrderGoodsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GLOrderGoodsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanliLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation GLOrderGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(GLConfirmOrderModel *)model{
    _model = model;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.cart_url] placeholderImage:[UIImage imageNamed:@"XRPlaceholder"]];
    _nameLabel.text = model.cart_name;
    _fanliLabel.text = model.cart_discount;
    _priceLabel.text = model.cart_price;
    _sumLabel.text = [NSString stringWithFormat:@"数量:%@",model.cart_number];
    _detailLabel.text = model.cart_info;
}

@end
