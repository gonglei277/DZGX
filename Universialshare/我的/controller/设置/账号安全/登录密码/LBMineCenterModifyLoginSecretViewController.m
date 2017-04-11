//
//  LBMineCenterModifyLoginSecretViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/31.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineCenterModifyLoginSecretViewController.h"

@interface LBMineCenterModifyLoginSecretViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentVW;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentVH;

@property (weak, nonatomic) IBOutlet UIView *baseview1;

@property (weak, nonatomic) IBOutlet UIView *baseview2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baseviewW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baseview2W;

@property (weak, nonatomic) IBOutlet UIImageView *imageOne;//验证身份图片

@property (weak, nonatomic) IBOutlet UIImageView *imageTwo;//修改登录密码图片

@property (weak, nonatomic) IBOutlet UILabel *base1phone;//验证身份里的电话号码

@property (weak, nonatomic) IBOutlet UIButton *base1Bt;//验证身份里的验证码按钮
@property (weak, nonatomic) IBOutlet UITextField *base1Tf;//验证身份里的验证码输入框
@property (weak, nonatomic) IBOutlet UIButton *nextbt;//下一步按钮


@property (weak, nonatomic) IBOutlet UITextField *baseTwoSecret;

@property (weak, nonatomic) IBOutlet UITextField *RepeatSecret;

@property (weak, nonatomic) IBOutlet UIButton *submitbuton;

@property (weak, nonatomic) IBOutlet UIView *contentview;

@end

@implementation LBMineCenterModifyLoginSecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"登录密码";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

//获取验证身份里的验证码
- (IBAction)baseOneCode:(UIButton *)sender {
    
    
}
//下一步
- (IBAction)nextutton:(UIButton *)sender {
    
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    [self.contentview exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [self.contentview.layer addAnimation:animation forKey:nil];
    
    self.imageOne.backgroundColor = YYSRGBColor(239, 239, 244, 1);
    self.imageTwo.backgroundColor = YYSRGBColor(194, 50, 25, 1);
    
}
//提交
- (IBAction)submiteent:(UIButton *)sender {
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.base1Tf && [string isEqualToString:@"\n"]) {
         [self.view endEditing:YES];
        return NO;
    }else if (textField == self.baseTwoSecret && [string isEqualToString:@"\n"]) {
        [self.RepeatSecret becomeFirstResponder];
        return NO;
    }else if (textField == self.RepeatSecret && [string isEqualToString:@"\n"]) {
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
    
    
    self.contentVW.constant = SCREEN_WIDTH;
    self.contentVH.constant =SCREEN_HEIGHT - 224;
    
    self.baseviewW.constant = SCREEN_WIDTH - 40;
    self.baseview2W.constant = SCREEN_WIDTH - 40;
    
    self.base1Bt.layer.cornerRadius = 4;
    self.base1Bt.clipsToBounds = YES;
    self.nextbt.layer.cornerRadius = 4;
    self.nextbt.clipsToBounds = YES;
    self.submitbuton.layer.cornerRadius = 4;
    self.submitbuton.clipsToBounds = YES;
    
     self.base1Tf.layer.borderColor = YYSRGBColor(185, 185, 185, 1).CGColor;
     self.base1Tf.layer.borderWidth=1;
     self.baseTwoSecret.layer.borderColor = YYSRGBColor(185, 185, 185, 1).CGColor;
    self.baseTwoSecret.layer.borderWidth=1;
     self.RepeatSecret.layer.borderColor = YYSRGBColor(185, 185, 185, 1).CGColor;
    self.RepeatSecret.layer.borderWidth=1;
    
    
    self.baseview1.layer.borderColor = YYSRGBColor(185, 185, 185, 1).CGColor;
    self.baseview1.layer.borderWidth=1;
    self.baseview1.layer.cornerRadius = 4;
    self.baseview1.clipsToBounds = YES;
    
    self.baseview2.layer.borderColor = YYSRGBColor(185, 185, 185, 1).CGColor;
    self.baseview2.layer.borderWidth=1;
    self.baseview2.layer.cornerRadius = 4;
    self.baseview2.clipsToBounds = YES;


}

@end
