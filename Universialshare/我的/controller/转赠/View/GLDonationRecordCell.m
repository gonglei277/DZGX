//
//  GLDonationRecordCell.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLDonationRecordCell.h"
@interface GLDonationRecordCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameTitle;
@property (weak, nonatomic) IBOutlet UILabel *beanNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation GLDonationRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(GLDonationRecordModel *)model{
    _model = model;
    if ([model.picture rangeOfString:@"null"].location != NSNotFound) {
        model.picture = @"mine_head";
    }
    if ([model.receivename rangeOfString:@"null"].location != NSNotFound) {
        model.receivename = @"";
    }
    if ([model.beannum rangeOfString:@"null"].location != NSNotFound) {
        model.beannum = @"0";
    }
    if ([model.donationtime rangeOfString:@"null"].location != NSNotFound) {
        model.donationtime = @"";
    }
    self.imageV.image = [UIImage imageNamed:model.picture];
    self.nameTitle.text = model.receivename;
    self.beanNumLabel.text = model.beannum;
    self.dateLabel.text = model.donationtime;
    
    if (self.imageV.image ==nil) {
        self.imageV.image = [UIImage imageNamed:@"mine_head"];
    }
}
@end
