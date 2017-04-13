//
//  GLMine_InfoCell.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLMine_InfoCell.h"

@implementation GLMine_InfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageV.layer.cornerRadius = 20;
    self.imageV.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
