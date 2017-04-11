//
//  LBMineCenterSafeChangePhoneViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/31.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineCenterSafeChangePhoneViewController.h"

@interface LBMineCenterSafeChangePhoneViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *phonelb;

@property (weak, nonatomic) IBOutlet UIView *baseview1;
@property (weak, nonatomic) IBOutlet UIView *baseview2;

@property (weak, nonatomic) IBOutlet UIView *baseview3;


@property (weak, nonatomic) IBOutlet UITextField *oldcode;

@property (weak, nonatomic) IBOutlet UIButton *oldbutton;

@property (weak, nonatomic) IBOutlet UITextField *newphone;

@property (weak, nonatomic) IBOutlet UITextField *newcode;


@property (weak, nonatomic) IBOutlet UIButton *newbutton;
@property (weak, nonatomic) IBOutlet UIButton *sendebutton;

@end

@implementation LBMineCenterSafeChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)getOldcode:(UIButton *)sender {
    
    
    
}

- (IBAction)getnewcode:(UIButton *)sender {
    
    
}

- (IBAction)submitEvent:(UIButton *)sender {
    
    
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.oldcode && [string isEqualToString:@"\n"]) {
        [self.newphone becomeFirstResponder];
        return NO;
    }else if (textField == self.newphone && [string isEqualToString:@"\n"]) {
        [self.newcode becomeFirstResponder];
        return NO;
    }else if (textField == self.newcode && [string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    
    return YES;
    
}



-(void)updateViewConstraints{

    [super updateViewConstraints];
    
    self.baseview1.layer.cornerRadius = 4;
    self.baseview1.clipsToBounds = YES;
    self.baseview2.layer.cornerRadius = 4;
    self.baseview2.clipsToBounds = YES;
    self.baseview3.layer.cornerRadius = 4;
    self.baseview3.clipsToBounds = YES;
    
    self.oldbutton.layer.cornerRadius = 4;
    self.oldbutton.clipsToBounds = YES;
    
    self.newbutton.layer.cornerRadius = 4;
    self.newbutton.clipsToBounds = YES;
    
    self.sendebutton.layer.cornerRadius = 4;
    self.sendebutton.clipsToBounds = YES;



}

@end
