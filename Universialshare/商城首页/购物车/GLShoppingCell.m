//
//  GLShoppingCell.m
//  Universialshare
//
//  Created by 龚磊 on 2017/3/25.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLShoppingCell.h"

@interface GLShoppingCell ()
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *goodsNamelabel;


@end

@implementation GLShoppingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bottomView.layer.cornerRadius = 5.f;
    self.bottomView.clipsToBounds = YES;
//    self.bottomView.alpha = 0.3;
    self.bottomView.layer.borderColor = YYSRGBColor(148, 148, 148, 0.3).CGColor;
    self.bottomView.layer.borderWidth = 1;
 
    self.goodsNamelabel.font = [UIFont systemFontOfSize:ADAPT(15)];
    UIGestureRecognizer *tap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(changeStatus)];
    [self addGestureRecognizer:tap];
}

- (IBAction)changeClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(changeStatus:)]) {
        [_delegate changeStatus:self.index];
    }
   
}
- (void)changeStatus {
    if ([_delegate respondsToSelector:@selector(changeStatus:)]) {
        [_delegate changeStatus:self.index];
    }
}
- (IBAction)changeSum:(id)sender {
    if (sender == self.addBtn) {
        
        if ([_delegate respondsToSelector:@selector(addNum:)]) {
            [_delegate addNum:self.index];
        }
    }else{
        if ([_delegate respondsToSelector:@selector(reduceNum:)]) {
            [_delegate reduceNum:self.index];
        }
    }
    
}

@end
