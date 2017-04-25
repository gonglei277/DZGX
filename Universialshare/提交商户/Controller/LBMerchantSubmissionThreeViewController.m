//
//  LBMerchantSubmissionThreeViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMerchantSubmissionThreeViewController.h"
#import "LBMerchantSubmissionFourViewController.h"

@interface LBMerchantSubmissionThreeViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *banktf;
@property (weak, nonatomic) IBOutlet UITextField *bankCode;
@property (weak, nonatomic) IBOutlet UITextField *phonetf;
@property (weak, nonatomic) IBOutlet UITextField *nametf;
@property (weak, nonatomic) IBOutlet UITextField *treebank;

@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIButton *nextbt;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentH;

@end

@implementation LBMerchantSubmissionThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提交商户";
    
}


//点击开户银行
- (IBAction)tapgesturebank:(UITapGestureRecognizer *)sender {
    
    
}
//点击下一步
- (IBAction)nextbutton:(UIButton *)sender {
    self.hidesBottomBarWhenPushed = YES;
    LBMerchantSubmissionFourViewController *vc=[[LBMerchantSubmissionFourViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField == self.nametf && [string isEqualToString:@"\n"]) {
        [self.treebank becomeFirstResponder];
        return NO;
        
    }else if (textField == self.treebank && [string isEqualToString:@"\n"]){
        
        [self.view endEditing:YES];
        return NO;
    }
    
    if (textField == self.nametf) {
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
    
    self.baseView.layer.cornerRadius = 3;
    self.baseView.clipsToBounds = YES;
    
    self.nextbt.layer.cornerRadius = 3;
    self.nextbt.clipsToBounds = YES;

    self.contentW.constant = SCREEN_WIDTH;
    self.contentH.constant = SCREEN_HEIGHT - 64;

}

@end
