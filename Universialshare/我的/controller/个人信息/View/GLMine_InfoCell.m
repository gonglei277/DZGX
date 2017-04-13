//
//  GLMine_InfoCell.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLMine_InfoCell.h"

@interface GLMine_InfoCell ()<UITextFieldDelegate>

@end

@implementation GLMine_InfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headimage.layer.cornerRadius = 15;
    self.headimage.clipsToBounds = YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{

    if (self.returnEditing) {
        self.returnEditing(textField.text , self.index);
    }

}

@end
