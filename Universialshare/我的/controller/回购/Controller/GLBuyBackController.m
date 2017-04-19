//
//  GLBuyBackController.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLBuyBackController.h"
#import "GLBuyBackChooseCardController.h"
#import "GLSet_MaskVeiw.h"
#import "GLDirectDnationView.h"
#import "GLBuyBackRecordController.h"
#import "GLNoticeView.h"
#import "UIImageView+WebCache.h"

#import "GLBuyBackChooseController.h"
#import "GLBankCardModel.h"

@interface GLBuyBackController ()<UITextFieldDelegate,UIScrollViewDelegate>
{
    GLDirectDnationView *_directV;
    GLSet_MaskVeiw * _maskV;
    LoadWaitView *_loadV;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UILabel *beanStyleLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
//回购数量
@property (weak, nonatomic) IBOutlet UITextField *buybackNumF;

//二级密码
@property (weak, nonatomic) IBOutlet UITextField *secondPwdF;

@property (weak, nonatomic) IBOutlet UILabel *remainBeanLabel;
//修改银行卡
@property (weak, nonatomic) IBOutlet UIImageView *bankStyleImageV;
@property (weak, nonatomic) IBOutlet UILabel *cardNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardStyleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *addImageV;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageV;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation GLBuyBackController
//用 bounces 属性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    scrollView.bounces = (scrollView.contentOffset.y <= 0) ? NO : YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"回购";
    self.view.backgroundColor = [UIColor whiteColor];
    self.ensureBtn.layer.cornerRadius = 5.f;
    [self.backBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 20)];

    self.scrollView.delegate = self;
//    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 450);
    
//    //自定义导航栏右按钮
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(SCREEN_WIDTH - 60, 14, 60, 30);
//    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
//    [button setTitle:@"回购记录" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:13];
//    [button addTarget:self action:@selector(pushToBuyBackVC) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];

//    if([[UserModel defaultUser].userLogin integerValue] == 1){
//        
        self.noticeLabel.text = [NSString stringWithFormat:@" 1. 回购建议优先选择工商银行\n 2. 单笔最多回购50000颗米子\n 3. 单笔%@扣除回购金额10%%的手续费 ",NormalMoney] ;
//    }else{
//        self.noticeLabel.text = @" 1. 回购建议优先选择工商银行\n 2. 单笔普通志愿豆扣除回购金额5%的手续费\n 3. 单笔待提供发票志愿豆回购扣除手续费5(颗)志愿豆手续费,以及回购金额4.8‰的代缴税\n 4. 待提供发票志愿豆任意时间允许回购\n";
//    }
//    
//    [UILabel changeLineSpaceForLabel:self.noticeLabel WithSpace:5.0];

    self.remainBeanLabel.text = [NSString stringWithFormat:@"%.2f",[[UserModel defaultUser].ketiBean floatValue]];
    
    self.buybackNumF.placeholder = @"请输入100的整数倍";
    
    self.buybackNumF.returnKeyType = UIReturnKeyNext;
    self.secondPwdF.returnKeyType = UIReturnKeyDone;
    self.buybackNumF.delegate = self;
    self.secondPwdF.delegate = self;
    
    self.contentViewWidth.constant = SCREEN_WIDTH;
    self.contentViewHeight.constant = SCREEN_HEIGHT - 100;

    
    [self updateBankInfo];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:@"maskView_dismiss" object:nil];
    
}
- (void)updateData {
    
    self.bankStyleImageV.image = [UIImage imageNamed:@"mine_icbc"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;
    
//    _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"user/refresh" paramDic:dict finish:^(id responseObject) {
        
        [_loadV removeloadview];
//        NSLog(@"responseObject = %@",responseObject);
        if ([responseObject[@"code"] integerValue] == 1){
            
            if ([[NSString stringWithFormat:@"%@",responseObject[@"data"][@"banknumber"]] rangeOfString:@"null"].location != NSNotFound) {
                [UserModel defaultUser].banknumber = @"";
            }else{
                [UserModel defaultUser].banknumber = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"banknumber"]];
            }
            
            if ([[NSString stringWithFormat:@"%@",responseObject[@"data"][@"bankname"]] rangeOfString:@"null"].location != NSNotFound) {
                [UserModel defaultUser].defaultBankname = @"";
            }else{
                
                [UserModel defaultUser].defaultBankname = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"bankname"]];
            }
            
            [UserModel defaultUser].ketiBean = [NSString stringWithFormat:@"%@元",responseObject[@"data"][@"common"]];
            [UserModel defaultUser].djs_bean = [NSString stringWithFormat:@"%@元",responseObject[@"data"][@"taxes"]];
            [UserModel defaultUser].banknumber = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"banknumber"]];
            [UserModel defaultUser].defaultBankname = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"bankname"]];
            
            [usermodelachivar achive];
            
            if ([self.beanStyleLabel.text isEqualToString:NormalMoney]) {

                self.remainBeanLabel.text = [NSString stringWithFormat:@"%.2f",[[UserModel defaultUser].ketiBean floatValue]];
            }else{

                self.remainBeanLabel.text = [NSString stringWithFormat:@"%.2f",[[UserModel defaultUser].djs_bean floatValue]];
            }
            
        }
        
//        [self updateBankInfo];
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        
    }];

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
- (void)updateBankInfo {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;
    
    _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"user/getbank" paramDic:dict finish:^(id responseObject) {
        
        [_loadV removeloadview];
//        NSLog(@"responseObject = %@",responseObject);
        
        if ([responseObject[@"code"] integerValue] == 1){
            self.bankStyleImageV.hidden = NO;
            self.cardNumLabel.hidden = NO;
            self.cardStyleLabel.hidden = NO;
            self.detailImageV.hidden = NO;
            
            self.addImageV.hidden = YES;
            self.addLabel.hidden = YES;

            self.cardNumLabel.text = responseObject[@"data"][0][@"number"];
            self.cardStyleLabel.text = responseObject[@"data"][0][@"name"];
            self.bankStyleImageV.image = [UIImage imageNamed:@"mine_icbc"];
            
            for (NSDictionary *dic in responseObject[@"data"]) {
                
                self.cardNumLabel.text = dic[@"number"];
                self.cardStyleLabel.text = dic[@"name"];
            
            }
            
        }else{
            self.bankStyleImageV.hidden = YES;
            self.cardNumLabel.hidden = YES;
            self.cardStyleLabel.hidden = YES;
            self.detailImageV.hidden = YES;
            
            self.addImageV.hidden = NO;
            self.addLabel.hidden = NO;

        }
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        
    }];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.buybackNumF){
        [self.secondPwdF becomeFirstResponder];
        
    }else if(textField == self.secondPwdF){
        [self.secondPwdF becomeFirstResponder];
        
    }
    return YES;
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

    if ([[NSString stringWithFormat:@"%ld",[self.cardNumLabel.text integerValue]] isEqualToString:@"0"]) {
        [MBProgressHUD showError:@"请输入银行卡号"];
        return;
    }
    if ([[NSString stringWithFormat:@"%ld",[self.buybackNumF.text integerValue]] isEqualToString:@"0"]) {
        [MBProgressHUD showError:@"请输入回购数量"];
        return;
    }else if(![self isPureNumandCharacters:self.buybackNumF.text]){
        [MBProgressHUD showError:@"回购数量只能为正整数"];
        return;
    }else if([self.buybackNumF.text integerValue] > [self.remainBeanLabel.text integerValue]){
        [MBProgressHUD showError:@"余额不足!"];
        return;
    }
//    if([[UserModel defaultUser].groupId integerValue] == [OrdinaryUser integerValue]){
    
        if ([self.buybackNumF.text integerValue] %100 != 0){
            [MBProgressHUD showError:@"数量必须是100的整数倍!"];
            return;
        }
//    }else{
//        if ([self.buybackNumF.text integerValue] % 500 != 0){
//            [MBProgressHUD showError:@"数量必须是500的整数倍!"];
//            return;
//        }
//    }
    if ( [self.buybackNumF.text integerValue] > 50000){
        [MBProgressHUD showError:[NSString stringWithFormat:@"单笔最多回购50000颗%@",NormalMoney]];
        return;
    }
    if (self.secondPwdF.text == nil||self.secondPwdF.text.length == 0) {
        [MBProgressHUD showError:@"请输入二级密码"];
        return;
    }
   
    
    CGFloat contentViewH = 200;
    CGFloat contentViewW = SCREEN_WIDTH - 40;
    _maskV = [[GLSet_MaskVeiw alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    _maskV.bgView.alpha = 0.4;
    
    GLNoticeView *contentView = [[NSBundle mainBundle] loadNibNamed:@"GLNoticeView" owner:nil options:nil].lastObject;
    contentView.frame = CGRectMake(20, (SCREEN_HEIGHT - contentViewH)/2, contentViewW, contentViewH);
    contentView.layer.cornerRadius = 4;
    contentView.layer.masksToBounds = YES;
    [contentView.cancelBtn addTarget:self action:@selector(cancelBuyback) forControlEvents:UIControlEventTouchUpInside];
    [contentView.ensureBtn addTarget:self action:@selector(ensureBuyback) forControlEvents:UIControlEventTouchUpInside];
    if ([self.beanStyleLabel.text isEqualToString:NormalMoney]) {
    
        contentView.contentLabel.text = [NSString stringWithFormat:@"手续费为回购数量的10%%"];
    }else{
        contentView.contentLabel.text = [NSString stringWithFormat:@"手续费为回购数量的10%%"];
//        contentView.contentLabel.text = [NSString stringWithFormat:@"手续费为5颗米子\n代扣税为%.2f(颗)米子\n可兑换金额为%.2f元",[self.buybackNumF.text integerValue]*0.0048,([self.buybackNumF.text integerValue]-[self.buybackNumF.text integerValue]*0.0048 - 5)];
        
    }
    
    [_maskV showViewWithContentView:contentView];

//    [self showOkayCancelAlert];

}
- (void)showOkayCancelAlert {
    NSString *title = NSLocalizedString(@"请选择类型", nil);
    NSString *message = NSLocalizedString(@"", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *T1ButtonTitle = NSLocalizedString(@"T + 1 (收取10%的手续费)", nil);
    NSString *T3ButtonTitle = NSLocalizedString(@"T + 3 (收取5%的手续费)", nil);
    NSString *T7ButtonTitle = NSLocalizedString(@"T + 7 (收取0%的手续费)", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

    }];
    
    UIAlertAction *T1Action = [UIAlertAction actionWithTitle:T1ButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    
        [MBProgressHUD showError:@"该类型暂不可使用!"];
    }];
    UIAlertAction *T3Action = [UIAlertAction actionWithTitle:T3ButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            CGFloat contentViewH = 200;
            CGFloat contentViewW = SCREEN_WIDTH - 40;
            _maskV = [[GLSet_MaskVeiw alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
            _maskV.bgView.alpha = 0.4;
        
            GLNoticeView *contentView = [[NSBundle mainBundle] loadNibNamed:@"GLNoticeView" owner:nil options:nil].lastObject;
            contentView.frame = CGRectMake(20, (SCREEN_HEIGHT - contentViewH)/2, contentViewW, contentViewH);
            contentView.layer.cornerRadius = 4;
            contentView.layer.masksToBounds = YES;
            [contentView.cancelBtn addTarget:self action:@selector(cancelBuyback) forControlEvents:UIControlEventTouchUpInside];
            [contentView.ensureBtn addTarget:self action:@selector(ensureBuyback) forControlEvents:UIControlEventTouchUpInside];
//            if ([self.beanStyleLabel.text isEqualToString:@"米子"]) {
        
                contentView.contentLabel.text = [NSString stringWithFormat:@"手续费为回购数量的10%%"];
//            }else{
//        
//                contentView.contentLabel.text = [NSString stringWithFormat:@"手续费为5颗米子n代扣税为%.2f(颗)米子\n可兑换金额为%.2f元",[self.buybackNumF.text integerValue]*0.0048,([self.buybackNumF.text integerValue]-[self.buybackNumF.text integerValue]*0.0048 - 5)];
//   
//            }
            
            [_maskV showViewWithContentView:contentView];
        
    }];
    UIAlertAction *T7Action = [UIAlertAction actionWithTitle:T7ButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        [MBProgressHUD showError:@"该类型暂不可使用!"];
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:T1Action];
    [alertController addAction:T3Action];
    [alertController addAction:T7Action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)cancelBuyback {
    [UIView animateWithDuration:0.2 animations:^{
        
        _maskV.alpha = 0;
        
    }completion:^(BOOL finished) {
        
        [_maskV removeFromSuperview];
        
    }];

}
- (void)ensureBuyback{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"password"] = self.secondPwdF.text;
    dict[@"num"] = self.buybackNumF.text;
    dict[@"IDcar"] = self.cardNumLabel.text;
    //开户行地址  ???
    dict[@"address"] = self.cardStyleLabel.text;

    if ([self.beanStyleLabel.text isEqualToString:NormalMoney]) {
        dict[@"donatetype"] = @"1";
    }else{
        dict[@"donatetype"] = @"0";
    }
    NSLog(@"dict  = %@",dict);
    _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"user/back" paramDic:dict finish:^(id responseObject) {
        
        [_loadV removeloadview];
        if ([responseObject[@"code"] integerValue] == 1) {
            [self cancelBuyback];
            self.secondPwdF.text = nil;
            self.buybackNumF.text = nil;
            
            //刷新信息
            [self updateData];
             [MBProgressHUD showSuccess:@"回购申请成功"];
        }else{
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [MBProgressHUD showError:error.localizedDescription];
    }];

}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//跳转回购记录
- (IBAction)buyBackRecord:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    GLBuyBackRecordController *recordVC = [[GLBuyBackRecordController alloc] init];
    
    [self.navigationController pushViewController:recordVC animated:YES];
}

- (IBAction)chooseBank:(id)sender {
    if (self.addImageV.hidden) {
        self.hidesBottomBarWhenPushed = YES;
        
        GLBuyBackChooseController *chooseVC = [[GLBuyBackChooseController alloc] init];
        
        [chooseVC returnModel:^(GLBankCardModel *model) {
            self.cardNumLabel.text = model.number;
            self.cardStyleLabel.text = model.name;
            self.bankStyleImageV.image = [UIImage imageNamed:model.iconName];
        }];
        [self.navigationController pushViewController:chooseVC animated:YES];
    }else{
        
        self.hidesBottomBarWhenPushed = YES;
        GLBuyBackChooseCardController *chooseVC = [[GLBuyBackChooseCardController alloc] init];
        chooseVC.block = ^(NSString *cardNum){
            self.cardNumLabel.text = cardNum;
        };
        [self.navigationController pushViewController:chooseVC animated:YES];
    }
    
}
- (IBAction)chooseStyle:(id)sender {
    
    _maskV = [[GLSet_MaskVeiw alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _maskV.bgView.alpha = 0.1;
//
    _directV = [[NSBundle mainBundle] loadNibNamed:@"GLDirectDnationView" owner:nil options:nil].lastObject;
    [_directV.normalBtn addTarget:self action:@selector(chooseValue:) forControlEvents:UIControlEventTouchUpInside];
    [_directV.taxBtn addTarget:self action:@selector(chooseValue:) forControlEvents:UIControlEventTouchUpInside];
//    if([[UserModel defaultUser].userLogin integerValue] == 1){
//        [_directV.taxBtn setTitle:@"待缴税志愿豆" forState:UIControlStateNormal];
//        
//    }else{
//        
//        [_directV.taxBtn setTitle:@"待提供发票志愿豆" forState:UIControlStateNormal];
//    }
//    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[self.chooseBtn convertRect: self.chooseBtn.bounds toView:window];
    
    _directV.frame = CGRectMake(0,CGRectGetMaxY(rect), SCREEN_WIDTH, 3 * self.chooseBtn.yy_height);
    _directV.backgroundColor = [UIColor whiteColor];
    _directV.layer.cornerRadius = 4;
    _directV.layer.masksToBounds = YES;
    
    [_maskV showViewWithContentView:_directV];
    
}
- (void)chooseValue:(UIButton *)sender {
    
    if (sender== _directV.normalBtn) {
        self.beanStyleLabel.text = NormalMoney;
        self.remainBeanLabel.text = [NSString stringWithFormat:@"%.2f",[[UserModel defaultUser].ketiBean floatValue]];
        
    }else{
//        if([[UserModel defaultUser].userLogin integerValue] == 1){
            self.beanStyleLabel.text = SpecialMoney;
//
//        }else{
//            
//            self.beanStyleLabel.text = @"待提供发票志愿豆";
//        }
        self.remainBeanLabel.text = [NSString stringWithFormat:@"%.2f",[[UserModel defaultUser].djs_bean floatValue]];

    }
    [self dismiss];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self updateData];

   
}

@end
