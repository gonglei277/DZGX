//
//  GLBuyBackChooseCardController.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLBuyBackChooseCardController.h"
#import "predicateModel.h"
#import "GLSet_MaskVeiw.h"
#import "GLBuyBackChooseBankView.h"

@interface GLBuyBackChooseCardController ()
{
    LoadWaitView *_loadV;
    GLSet_MaskVeiw *_maskV;
    GLBuyBackChooseBankView *_contentV;
    
}
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
@property (weak, nonatomic) IBOutlet UILabel *bankLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardTextF;
@property (weak, nonatomic) IBOutlet UIButton *chooseBankBtn;
@property (weak, nonatomic) IBOutlet UITextField *addressF;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;


@end

@implementation GLBuyBackChooseCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ensureBtn.layer.cornerRadius = 5.f;
    self.title = @"修改银行卡";
    self.nameLabel.text =[NSString stringWithFormat:@"%@",[UserModel defaultUser].name];
    self.navigationController.navigationBar.hidden = NO;
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:@"maskView_dismiss" object:nil];
    
}
//移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)dismiss {

    [UIView animateWithDuration:0.3 animations:^{
        
        _maskV.alpha = 0;
    } completion:^(BOOL finished) {
        [_maskV removeFromSuperview];
        
    }];
}
- (void)text:(newBlock)block{
    self.block = block;
}

- (IBAction)chooseBank:(id)sender {
    _maskV = [[GLSet_MaskVeiw alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _maskV.bgView.alpha = 0.1;
    
    _contentV = [[NSBundle mainBundle] loadNibNamed:@"GLBuyBackChooseBankView" owner:nil options:nil].lastObject;
    [_contentV.chinaBankBtn addTarget:self action:@selector(chooseValue:) forControlEvents:UIControlEventTouchUpInside];
    [_contentV.icbcBtn addTarget:self action:@selector(chooseValue:) forControlEvents:UIControlEventTouchUpInside];
    [_contentV.abcBtn addTarget:self action:@selector(chooseValue:) forControlEvents:UIControlEventTouchUpInside];
    [_contentV.ccbBtn addTarget:self action:@selector(chooseValue:) forControlEvents:UIControlEventTouchUpInside];
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[self.chooseBankBtn convertRect: self.chooseBankBtn.bounds toView:window];
    
    _contentV.frame = CGRectMake(0,CGRectGetMaxY(rect), SCREEN_WIDTH, 6 * self.chooseBankBtn.yy_height);
    //    if([[UserModel defaultUser].userLogin integerValue] == 1){
    //        [_directV.taxBtn setTitle:@"待缴税志愿豆" forState:UIControlStateNormal];
    //
    //    }else{
    //
    //        [_directV.taxBtn setTitle:@"待提供发票志愿豆" forState:UIControlStateNormal];
    //    }
    _contentV.backgroundColor = [UIColor whiteColor];
    _contentV.layer.cornerRadius = 4;
    _contentV.layer.masksToBounds = YES;
    
    [_maskV showViewWithContentView:_contentV];
}
- (void)chooseValue:(UIButton *)sender{
    if (sender == _contentV.chinaBankBtn) {
        self.bankLabel.text = @"中国银行";
    }else if(sender == _contentV.icbcBtn){
         self.bankLabel.text = @"中国工商银行";
    }else if(sender == _contentV.abcBtn){
        self.bankLabel.text = @"中国农业银行";
    }else{
        self.bankLabel.text = @"中国建设银行";
    }
    [self dismiss];
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
    }
//    }else if(![predicateModel IsBankCard:self.cardTextF.text]){
//        [MBProgressHUD showError:@"输入的银行卡不合法"];
//        return;
//    }
//
//    self.block(self.cardTextF.text);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"bankname"] = self.bankLabel.text;
    dict[@"address"] = self.addressF.text;
    dict[@"isDefault"] = @(self.switchBtn.isOn);
    dict[@"number"] = [NSString stringWithFormat:@"%@",self.cardTextF.text];
    
    _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"user/add_bank_num" paramDic:dict finish:^(id responseObject) {
        [_loadV removeloadview];

//        NSLog(@"responseObject = %@",responseObject);
        if ([responseObject[@"code"] integerValue] == 1) {
            
            self.block(self.cardTextF.text);
  
            self.cardTextF.text = nil;

            [MBProgressHUD showSuccess:@"添加银行卡成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
        
            [MBProgressHUD showError:responseObject[@"message"]];
       
        }

     
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [MBProgressHUD showError:error.localizedDescription];
    }];
}

@end
