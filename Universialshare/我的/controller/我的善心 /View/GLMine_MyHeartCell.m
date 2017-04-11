//
//  GLMine_MyHeartCell.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLMine_MyHeartCell.h"

@interface GLMine_MyHeartCell ()

@property (weak, nonatomic) IBOutlet UILabel *costDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *heartDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *taxLabel;
@property (weak, nonatomic) IBOutlet UILabel *acountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalHeartLabel;
@property (weak, nonatomic) IBOutlet UILabel *loveValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishedNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *returnValueLabel;


@end

@implementation GLMine_MyHeartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(GLMyheartModel *)model{
    _model = model;
    if([model.amount rangeOfString:@"null"].location != NSNotFound){
        model.amount = @"0";
    }
    if([model.tax rangeOfString:@"null"].location != NSNotFound){
        model.tax = @"0";
    }
    if([model.lovevalue rangeOfString:@"null"].location != NSNotFound){
        model.lovevalue = @"0";
    }
    if([model.endnumber rangeOfString:@"null"].location != NSNotFound){
        model.endnumber = @"0";
    }
    if([model.returnvalue rangeOfString:@"null"].location != NSNotFound){
        model.returnvalue = @"0";
    }
    if([model.expensetime rangeOfString:@"null"].location != NSNotFound){
        model.expensetime = @"";
    }
    if([model.expensetime rangeOfString:@"null"].location != NSNotFound){
        model.expensetime = @"";
    }
    
    self.costDateLabel.text = model.expensetime;
    self.heartDateLabel.text = model.gather_date;
    self.acountLabel.text = model.amount;
    self.totalHeartLabel.text = model.tax;
    self.loveValueLabel.text = model.lovevalue;
    self.finishedNumLabel.text = model.endnumber;
    self.returnValueLabel.text = model.returnvalue;
    self.taxLabel.text = model.tax;
}


@end
