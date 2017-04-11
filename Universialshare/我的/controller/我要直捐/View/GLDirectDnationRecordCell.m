//
//  GLDirectDnationRecordCell.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLDirectDnationRecordCell.h"
@interface GLDirectDnationRecordCell()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *beanStyleLabel;
@property (weak, nonatomic) IBOutlet UILabel *beanNumLabel;



@end

@implementation GLDirectDnationRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(GLDirectDonationModel *)model{
    _model = model;
    self.dateLabel.text = model.donatetime;
    self.beanStyleLabel.text = model.donatetype;
    self.beanNumLabel.text = model.beannum;
}


@end
