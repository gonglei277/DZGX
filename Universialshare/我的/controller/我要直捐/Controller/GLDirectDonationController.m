//
//  GLDirectDonationController.m
//  PovertyAlleviation
//
//  Created by 龚磊 on 2017/3/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLDirectDonationController.h"
#import "GLSet_MaskVeiw.h"
#import "GLDirectDnationView.h"
#import "GLDirectDnationRecordController.h"
#import "GLNoticeView.h"

@interface GLDirectDonationController ()<UITextFieldDelegate,UIScrollViewDelegate>
{
    GLDirectDnationView *_directV;
    GLSet_MaskVeiw * _maskV;
    LoadWaitView *_loadV;
}
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomV;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;

@property (weak, nonatomic) IBOutlet UILabel *beanStyleLabel;

@property (weak, nonatomic) IBOutlet UITextField *donationNumT;

@property (weak, nonatomic) IBOutlet UITextField *secondPwdT;
@property (weak, nonatomic) IBOutlet UILabel *useableBeanNumLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewW;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation GLDirectDonationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI{
    self.title = @"我要直捐";
    
    self.navigationController.navigationBar.hidden = NO;
    self.ensureBtn.layer.cornerRadius = 5.f;
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"直捐记录" style:UIBarButtonItemStylePlain target:self action:@selector(pushToRecordVC)];
    self.scrollView.delegate = self;
    //自定义导航栏右按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH - 60, 14, 60, 30);
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [button setTitle:@"直捐记录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:self action:@selector(pushToRecordVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.donationNumT.returnKeyType = UIReturnKeyNext;
    self.secondPwdT.returnKeyType = UIReturnKeyDone;
    self.donationNumT.delegate = self;
    self.secondPwdT.delegate = self;
    
//    self.useableBeanNumLabel.text = [UserModel defaultUser].couriercount;
    
    self.bgViewH.constant = SCREEN_HEIGHT - 64;
    self.bgViewW.constant = SCREEN_WIDTH;
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:@"maskView_dismiss" object:nil];
    
}
//移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)dismiss {
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[self.chooseBtn convertRect: self.chooseBtn.bounds toView:window];
    
//    _directV.frame = CGRectMake(0,CGRectGetMaxY(rect), SCREEN_WIDTH, 4 * self.chooseBtn.yy_height);
    
    [UIView animateWithDuration:0.3 animations:^{
        _directV.frame = CGRectMake(0, CGRectGetMaxY(rect), SCREEN_WIDTH, 0);
        _maskV.alpha = 0;
    } completion:^(BOOL finished) {
        [_maskV removeFromSuperview];
        
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.donationNumT){
        [self.secondPwdT becomeFirstResponder];
        
    }else if(textField == self.secondPwdT){
        [self.secondPwdT becomeFirstResponder];
        
    }
    return YES;
}
- (void)pushToRecordVC{
    self.hidesBottomBarWhenPushed = YES;
    GLDirectDnationRecordController *recordVC = [[GLDirectDnationRecordController alloc] init];
    [self.navigationController pushViewController:recordVC animated:YES];
}
- (IBAction)chooseStyle:(id)sender {

    _maskV = [[GLSet_MaskVeiw alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _maskV.bgView.alpha = 0.1;
    
    _directV = [[NSBundle mainBundle] loadNibNamed:@"GLDirectDnationView" owner:nil options:nil].lastObject;
    [_directV.normalBtn addTarget:self action:@selector(chooseValue:) forControlEvents:UIControlEventTouchUpInside];
    [_directV.taxBtn addTarget:self action:@selector(chooseValue:) forControlEvents:UIControlEventTouchUpInside];
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[self.chooseBtn convertRect: self.chooseBtn.bounds toView:window];
    
    _directV.frame = CGRectMake(0,CGRectGetMaxY(rect), SCREEN_WIDTH, 4 * self.chooseBtn.yy_height);
//    if([[UserModel defaultUser].userLogin integerValue] == 1){
//        [_directV.taxBtn setTitle:@"待缴税志愿豆" forState:UIControlStateNormal];
//        
//    }else{
//        
//        [_directV.taxBtn setTitle:@"待提供发票志愿豆" forState:UIControlStateNormal];
//    }
    _directV.backgroundColor = [UIColor whiteColor];
    _directV.layer.cornerRadius = 4;
    _directV.layer.masksToBounds = YES;
    
    [_maskV showViewWithContentView:_directV];
    
}

- (void)chooseValue:(UIButton *)sender {
    
//    if (sender== _directV.normalBtn) {
//        self.beanStyleLabel.text = @"普通志愿豆";
//        self.useableBeanNumLabel.text = [NSString stringWithFormat:@"%ld",[[UserModel defaultUser].couriercount integerValue]];
//        [_maskV removeFromSuperview];
//    }else{
//        
//        if([[UserModel defaultUser].userLogin integerValue] == 1){
//            self.beanStyleLabel.text = @"代缴税志愿豆";
//            
//        }else{
//            
//            self.beanStyleLabel.text = @"待提供发票志愿豆";
//        }
//        self.useableBeanNumLabel.text = [NSString stringWithFormat:@"%ld",[[UserModel defaultUser].nopaycount integerValue]];
//        [_maskV removeFromSuperview];
//    }
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
    
    //判断
    if (self.donationNumT.text == nil||self.donationNumT.text.length == 0) {
        [MBProgressHUD showError:@"请输入捐赠数量"];
        return;
    }
//    if ([self.beanStyleLabel.text isEqualToString:@"普通志愿豆"]){
//        
//        if([self.donationNumT.text integerValue] > [[UserModel defaultUser].couriercount integerValue]){
//            [MBProgressHUD showError:@"余额不足,请充值!"];
//            return;
//        }
//    }else{
//        if([self.donationNumT.text integerValue] > [[UserModel defaultUser].nopaycount integerValue]){
//            [MBProgressHUD showError:@"余额不足,请充值!"];
//            return;
//        }
//    }
    if(![self isPureNumandCharacters:self.donationNumT.text]){
        [MBProgressHUD showError:@"捐赠数量只能为正整数"];
        return;
    }
    if (self.secondPwdT.text == nil || self.secondPwdT.text.length == 0) {
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
    [contentView.cancelBtn addTarget:self action:@selector(cancelDonation) forControlEvents:UIControlEventTouchUpInside];
    [contentView.ensureBtn addTarget:self action:@selector(ensureDonation) forControlEvents:UIControlEventTouchUpInside];
    contentView.contentLabel.text = @"您是否选择捐赠?中国文学艺术基金会将会感谢您的每一份善心!";
    [_maskV showViewWithContentView:contentView];
    
}
- (void)cancelDonation {
    [UIView animateWithDuration:0.2 animations:^{
        _maskV.alpha = 0;
    }completion:^(BOOL finished) {
        [_maskV removeFromSuperview];
    }];
}
- (void)ensureDonation {
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"token"] = [UserModel defaultUser].aukeyValue;
//    dict[@"password"] = self.secondPwdT.text;
//    dict[@"beannum"] = @([self.donationNumT.text doubleValue]);
//    NSString *beanStyle = self.beanStyleLabel.text;
//    //0 普通善行豆   1 激励善行豆
//    
//    if ([beanStyle isEqualToString:@"普通志愿豆"]) {
//        dict[@"donatetype"] = @"0";
//    }else{
//        dict[@"donatetype"] = @"1";
//    }
//    _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
//    
//    [NetworkManager requestPOSTWithURLStr:@"Index/donates" paramDic:dict finish:^(id responseObject) {
//        
//        if ([responseObject[@"code"] integerValue] == 0) {
//            
//            [self cancelDonation];
//            self.donationNumT.text = nil;
//            self.secondPwdT.text = nil;
//            
//            //刷新信息
//            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//            dict[@"token"] = [UserModel defaultUser].aukeyValue;
//            
//            [NetworkManager requestPOSTWithURLStr:@"Index/updata" paramDic:dict finish:^(id responseObject) {
//                
//                [_loadV removeloadview];
//                if ([responseObject[@"code"] integerValue] == 0){
//                    
//                    //                    NSLog(@"%@",responseObject);
//                    [UserModel defaultUser].couriercount = [NSString stringWithFormat:@"%@",responseObject[@"couriercount"]];
//                    [UserModel defaultUser].nopaycount = [NSString stringWithFormat:@"%@",responseObject[@"nopaycount"]];
//                    [usermodelachivar achive];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"updataNotification" object:nil];
//                    
//                    if ([beanStyle isEqualToString:@"普通志愿豆"]) {
//                        
//                        self.useableBeanNumLabel.text = [UserModel defaultUser].couriercount;
//                    }else{
//                        self.useableBeanNumLabel.text = [UserModel defaultUser].nopaycount;
//                    }
//                    [MBProgressHUD showSuccess:@"直捐成功!"];
//                }else{
//                    
//                    [MBProgressHUD showError:@"数据提交异常,请重试!"];
//                }
//                
//            } enError:^(NSError *error) {
//                [_loadV removeloadview];
//                [MBProgressHUD showError:@"数据提交异常,请重试!"];
//            }];
//            
//        }else{
//            [_loadV removeloadview];
//            [MBProgressHUD showError:responseObject[@"msg"]];
//        }
//    } enError:^(NSError *error) {
//        
//        [_loadV removeloadview];
//        [MBProgressHUD showError:error.localizedDescription];
//    }];
}
//用 bounces 属性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    scrollView.bounces = (scrollView.contentOffset.y <= 0) ? NO : YES;
}
@end
