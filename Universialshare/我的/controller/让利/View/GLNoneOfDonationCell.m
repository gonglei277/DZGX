//
//  GLNoneOfDonationCell.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLNoneOfDonationCell.h"
@interface GLNoneOfDonationCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end


@implementation GLNoneOfDonationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(GLNoneOfDonationModel *)model {
    _model = model;
    self.dateLabel.text = model.returntime;
    self.moneyLabel.text = model.amount;
    
}


@end
