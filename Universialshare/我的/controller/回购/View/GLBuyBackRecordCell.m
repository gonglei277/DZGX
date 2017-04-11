//
//  GLBuyBackRecordCell.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLBuyBackRecordCell.h"

@interface GLBuyBackRecordCell()
@property (weak, nonatomic) IBOutlet UILabel *beanTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *IDLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;



@end

@implementation GLBuyBackRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(GLBuyBackRecordModel *)model{
    _model = model;
    self.IDLabel.text = model.withdrawno;
    self.beanTypeLabel.text = model.withdrawtype;
    self.priceLabel.text = model.beannum;
    self.dateLabel.text = model.applytime;
    if ([model.status isEqualToString:@"0"]) {
        self.typeLabel.text = @"申请中";
    }else if ([model.status isEqualToString:@"1"]){
        self.typeLabel.text = @"回购完成";
    }else{
        self.typeLabel.text = @"回购失败";
    }
    
}


@end
