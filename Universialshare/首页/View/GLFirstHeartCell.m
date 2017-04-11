//
//  GLFirstHeartCell.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/7.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLFirstHeartCell.h"

@interface GLFirstHeartCell()

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sixLabel;
@property (weak, nonatomic) IBOutlet UILabel *twelveLabel;
@property (weak, nonatomic) IBOutlet UILabel *twenty_fourLabel;
@property (weak, nonatomic) IBOutlet UILabel *sixValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *twelveValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *twenty_fourValueLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *starWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLineLeading;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hearttrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heartHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xilieLabelleading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *starLaeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLineLeading;


@end

@implementation GLFirstHeartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.typeLabel.font = [UIFont systemFontOfSize:ADAPT(12)];
    self.sixLabel.font = [UIFont systemFontOfSize:ADAPT(12)];
    self.twelveLabel.font = [UIFont systemFontOfSize:ADAPT(12)];
    self.twenty_fourLabel.font = [UIFont systemFontOfSize:ADAPT(12)];
    self.sixValueLabel.font = [UIFont systemFontOfSize:ADAPT(12)];
    self.twelveValueLabel.font = [UIFont systemFontOfSize:ADAPT(12)];
    self.twenty_fourValueLabel.font = [UIFont systemFontOfSize:ADAPT(12)];
    
    _starWidth.constant = ADAPT(12);
    _heartHeight.constant = ADAPT(12);
    _rightLineLeading.constant = ADAPT(10);

    _xilieLabelleading.constant = ADAPT(3);
    _starLaeading.constant = ADAPT(10);
    _leftLineLeading.constant = ADAPT(10);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
