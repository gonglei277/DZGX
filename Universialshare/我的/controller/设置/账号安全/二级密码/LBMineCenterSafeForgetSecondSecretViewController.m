//
//  LBMineCenterSafeForgetSecondSecretViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/31.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineCenterSafeForgetSecondSecretViewController.h"

@interface LBMineCenterSafeForgetSecondSecretViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentVW;

@property (weak, nonatomic) IBOutlet UIView *baseV1;
@property (weak, nonatomic) IBOutlet UIView *codeview;
@property (weak, nonatomic) IBOutlet UIView *buttonview;
@property (weak, nonatomic) IBOutlet UITextField *codetectf;
@property (weak, nonatomic) IBOutlet UIButton *nextbt;

@property (weak, nonatomic) IBOutlet UIButton *sendCodeBT;

@property (weak, nonatomic) IBOutlet UIView *baseV2;
@property (weak, nonatomic) IBOutlet UIView *secretView;
@property (weak, nonatomic) IBOutlet UITextField *secrectTF;
@property (weak, nonatomic) IBOutlet UIView *RepeatView;
@property (weak, nonatomic) IBOutlet UITextField *RepeatTf;
@property (weak, nonatomic) IBOutlet UIButton *doneBt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *base1W;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *base2W;

@end

@implementation LBMineCenterSafeForgetSecondSecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)nextbutton:(UIButton *)sender {
     [self.scrollview setContentOffset:CGPointMake(SCREEN_WIDTH - 60, 0) animated:YES];
    
    
}


- (IBAction)donebutton:(UIButton *)sender {
    
     [[NSNotificationCenter defaultCenter]postNotificationName:@"LoveConsumptionVC" object:nil];
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.codetectf && [string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    else if (textField == self.secrectTF && [string isEqualToString:@"\n"]) {
        [self.RepeatTf becomeFirstResponder];
        return NO;
    }else if (textField == self.RepeatTf && [string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    
    return YES;
    
}


-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.contentVW.constant = (SCREEN_WIDTH - 60)*2;

    self.base1W.constant = SCREEN_WIDTH - 60;
    self.base2W.constant = SCREEN_WIDTH - 60;

    self.codeview.layer.borderWidth = 1;
    self.codeview.layer.borderColor = YYSRGBColor(233, 233, 233, 1).CGColor;
    
    self.buttonview.layer.borderWidth = 1;
    self.buttonview.layer.borderColor = YYSRGBColor(233, 233, 233, 1).CGColor;
    
    self.nextbt.layer.cornerRadius = 4;
    self.nextbt.clipsToBounds = YES;
    
    self.doneBt.layer.cornerRadius = 4;
    self.doneBt.clipsToBounds = YES;
    
    self.baseV1.layer.cornerRadius = 6;
    self.baseV1.clipsToBounds = YES;
    
    self.secretView.layer.cornerRadius = 4;
    self.secretView.clipsToBounds = YES;
    
    self.RepeatView.layer.cornerRadius = 4;
    self.RepeatView.clipsToBounds = YES;
    
    self.secretView.layer.borderWidth = 1;
    self.secretView.layer.borderColor = YYSRGBColor(233, 233, 233, 1).CGColor;
    
    self.RepeatView.layer.borderWidth = 1;
    self.RepeatView.layer.borderColor = YYSRGBColor(233, 233, 233, 1).CGColor;

}

@end
