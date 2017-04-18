//
//  GLBankCardCellTableViewCell.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/14.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLBankCardCellTableViewCell.h"

@interface GLBankCardCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *banknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankNumLabel;


@end

@implementation GLBankCardCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(GLBankCardModel *)model {
    _model = model;
    _banknameLabel.text = model.name;
    _bankNumLabel.text = model.number;
    _iconImageV.image = [UIImage imageNamed:@"mine_icbc"];
}
@end
