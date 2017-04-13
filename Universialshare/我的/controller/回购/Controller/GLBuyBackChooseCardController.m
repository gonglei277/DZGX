//
//  GLBuyBackChooseCardController.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLBuyBackChooseCardController.h"
#import "predicateModel.h"

@interface GLBuyBackChooseCardController ()
{
    LoadWaitView *_loadV;
}
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
@property (weak, nonatomic) IBOutlet UILabel *bankLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardTextF;


@end

@implementation GLBuyBackChooseCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ensureBtn.layer.cornerRadius = 5.f;
    self.title = @"修改银行卡";
    self.nameLabel.text =[NSString stringWithFormat:@"%@",[UserModel defaultUser].name];
    
}
- (void)text:(newBlock)block{
    self.block = block;
}
- (IBAction)chooseBank:(id)sender {
    
    NSLog(@"选择银行");
}
- (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}
- (IBAction)ensureClick:(id)sender {
    
    
    if (self.cardTextF.text == nil||self.cardTextF.text.length == 0) {
        [MBProgressHUD showError:@"请输入银行卡号"];
        return;
    }else if(![self isPureNumandCharacters:self.cardTextF.text]){
        [MBProgressHUD showError:@"银行卡号只能为数字"];
        return;
    }else if(![predicateModel IsBankCard:self.cardTextF.text]){
        [MBProgressHUD showError:@"输入的银行卡不合法"];
        return;
    }
//
    self.block(self.cardTextF.text);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"bankacount"] = [NSString stringWithFormat:@"%@",self.cardTextF.text];
    
    _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"Index/addbankcard" paramDic:dict finish:^(id responseObject) {

        if ([responseObject[@"code"] integerValue] == 0) {
            
            self.cardTextF.text = nil;
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"token"] = [UserModel defaultUser].token;
    
            [NetworkManager requestPOSTWithURLStr:@"user/add_bank_num" paramDic:dict finish:^(id responseObject) {
                
                [_loadV removeloadview];

                if ([responseObject[@"code"] integerValue] == 0){
                    
                    [UserModel defaultUser].banknumber = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"bankacount"]];
                    [UserModel defaultUser].bankname = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"bankname"]];
                    [UserModel defaultUser].bankIcon = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"icon"]];
                    [usermodelachivar achive];

                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateBankInfo" object:nil];
                }
            } enError:^(NSError *error) {
                [_loadV removeloadview];
                
            }];

            [MBProgressHUD showSuccess:@"修改银行卡成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
        
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [MBProgressHUD showError:error.localizedDescription];
    }];
}

@end
