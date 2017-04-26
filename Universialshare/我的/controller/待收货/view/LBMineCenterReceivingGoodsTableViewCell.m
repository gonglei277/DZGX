//
//  LBMineCenterReceivingGoodsTableViewCell.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/1.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineCenterReceivingGoodsTableViewCell.h"

@implementation LBMineCenterReceivingGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.buyBt.layer.borderWidth = 1;
    self.buyBt.layer.borderColor = YYSRGBColor(191, 0, 0, 1).CGColor;
    
    self.SeeBt.layer.borderWidth = 1;
    self.SeeBt.layer.borderColor = YYSRGBColor(191, 0, 0, 1).CGColor;
}


- (IBAction)buyevent:(UIButton *)sender {
    
    [self.delegete BuyAgain:self.index];
}

- (IBAction)SeeEvent:(UIButton *)sender {
    
    [self.delegete checklogistics:self.index];
    
}



@end
