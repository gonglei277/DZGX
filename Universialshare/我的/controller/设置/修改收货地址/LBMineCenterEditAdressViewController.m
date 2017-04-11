//
//  LBMineCenterEditAdressViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/30.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineCenterEditAdressViewController.h"

@interface LBMineCenterEditAdressViewController ()<UITextFieldDelegate>

@end

@implementation LBMineCenterEditAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"编辑收货地址";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (IBAction)savaevent:(UIButton *)sender {
    
    
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField == self.nameTf && [string isEqualToString:@"\n"]) {
        [self.phoneTf becomeFirstResponder];
        return NO;
    }else if (textField == self.phoneTf && [string isEqualToString:@"\n"]) {
        [self.areaTf becomeFirstResponder];
        return NO;
    }else if (textField == self.areaTf && [string isEqualToString:@"\n"]) {
        [self.adressFt becomeFirstResponder];
        return NO;
    }else if (textField == self.adressFt && [string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }

    return YES;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];

}

-(void)updateViewConstraints{

    [super updateViewConstraints];
    
    self.savaBt.layer.cornerRadius = 4;
    self.savaBt.clipsToBounds = YES;

}
@end
