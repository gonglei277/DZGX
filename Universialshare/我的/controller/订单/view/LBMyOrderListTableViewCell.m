//
//  LBMyOrderListTableViewCell.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/1.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMyOrderListTableViewCell.h"

@implementation LBMyOrderListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.payBt.layer.borderColor = YYSRGBColor(191, 0, 0, 1).CGColor;
    self.payBt.layer.borderWidth = 1;
    
    UITapGestureRecognizer *tapgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgestureEvent:)];
    
    [self.stauesLb addGestureRecognizer:tapgesture];
    
}

- (IBAction)paEvent:(UIButton *)sender {
    
    if (self.retunpaybutton) {
        self.retunpaybutton(self.index);
    }
    
}
//查看进度
- (void)tapgestureEvent:(UITapGestureRecognizer *)sender {
    
    if (_delegete && [_delegete respondsToSelector:@selector(clickTapgesture)]) {
        
        [_delegete clickTapgesture];
    }

}

- (IBAction)deletebutton:(UIButton *)sender {
    
    if (self.retundeletebutton) {
        self.retundeletebutton(self.index);
    }
    
}


@end
