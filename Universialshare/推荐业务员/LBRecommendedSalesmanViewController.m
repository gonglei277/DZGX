//
//  LBRecommendedSalesmanViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/25.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBRecommendedSalesmanViewController.h"

@interface LBRecommendedSalesmanViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentW;
@property (weak, nonatomic) IBOutlet UITextField *phonetf;
@property (weak, nonatomic) IBOutlet UITextField *yanzTf;
@property (weak, nonatomic) IBOutlet UIButton *yanzBt;
@property (weak, nonatomic) IBOutlet UITextField *levelTf;
@property (weak, nonatomic) IBOutlet UITextField *proviceTf;
@property (weak, nonatomic) IBOutlet UITextField *cityTf;
@property (weak, nonatomic) IBOutlet UITextField *areaTf;
@property (weak, nonatomic) IBOutlet UITextField *secrestTf;
@property (weak, nonatomic) IBOutlet UIButton *nextBt;
@property (weak, nonatomic) IBOutlet UITextField *idenfyCode;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;

@end

@implementation LBRecommendedSalesmanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加业务员";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

//选择等级
- (IBAction)chooseLevel:(UITapGestureRecognizer *)sender {
}
//选择省份
- (IBAction)choseProvince:(UITapGestureRecognizer *)sender {
}
//选择城市
- (IBAction)choseCity:(UITapGestureRecognizer *)sender {
}
//选择区域
- (IBAction)choseArea:(UITapGestureRecognizer *)sender {
}

//发送验证
- (IBAction)sendCodeEvent:(UIButton *)sender {
    
    
}
//完成
- (IBAction)nextEvent:(UIButton *)sender {
    
    
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.idenfyCode && [string isEqualToString:@"\n"]) {
        [self.nameTf becomeFirstResponder];
        return NO;
    }else if (textField == self.nameTf && [string isEqualToString:@"\n"]) {
        [self.yanzTf becomeFirstResponder];
        return NO;
    }
   else if (textField == self.secrestTf && [string isEqualToString:@"\n"]) {
       
        [self.view endEditing:YES];
        return NO;
        
    }
    
    if (textField == self.idenfyCode ) {
        
        for(int i=0; i< [string length];i++){
            
            int a = [string characterAtIndex:i];
            
            if( a >= 0x4e00 && a <= 0x9fff)
                
                return NO;
        }
    }
    
    if (textField == self.nameTf) {
        //只能输入英文或中文
        NSCharacterSet * charact;
        charact = [[NSCharacterSet characterSetWithCharactersInString:NMUBERS]invertedSet];
        NSString * filtered = [[string componentsSeparatedByCharactersInSet:charact]componentsJoinedByString:@""];
        BOOL canChange = [string isEqualToString:filtered];
        if(canChange) {
            [MBProgressHUD showError:@"只能输入英文或中文"];
            return NO;
        }
    }
    
    return YES;
    
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.nextBt.layer.cornerRadius = 4;
    self.nextBt.clipsToBounds = YES;
    
    self.contentW.constant = SCREEN_WIDTH;
    self.contentH.constant = 550;
    
    
    self.baseView.layer.cornerRadius = 4;
    self.baseView.clipsToBounds = YES;


}

@end
