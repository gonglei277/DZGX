//
//  GLSubmitFirstController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLSubmitFirstController.h"
#import "GLSubmitSecondController.h"
#import "SYDatePicker.h"
#import "GLSet_MaskVeiw.h"

@interface GLSubmitFirstController ()<SYDatePickerDelegate>
{
    SYDatePicker *_contentView;
    GLSet_MaskVeiw * _maskV;
    int _whichOne;//区分两个时间
}
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextF;
@property (weak, nonatomic) IBOutlet UITextField *farenNameTextF;
@property (weak, nonatomic) IBOutlet UITextField *farenIDTextF;
@property (weak, nonatomic) IBOutlet UITextField *mailboxTextF;
@property (weak, nonatomic) IBOutlet UITextField *mianjiTextF;
@property (weak, nonatomic) IBOutlet UIView *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextV;

@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

@end

@implementation GLSubmitFirstController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"提交商户";
    self.topView.layer.cornerRadius = 5.f;
    self.topView.clipsToBounds = YES;
    
    self.middleView.layer.cornerRadius = 5.f;
    self.middleView.clipsToBounds = YES;
    
    self.bottomView.layer.cornerRadius = 5.f;
    self.bottomView.clipsToBounds = YES;
    
    self.contentViewWidth.constant = SCREEN_WIDTH;
    self.contentViewHeight.constant = SCREEN_HEIGHT;
    
    self.nextBtn.layer.cornerRadius = 5.f;
    self.nextBtn.clipsToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTime:)];
    [self.startTimeLabel addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTime:)];
    [self.endTimeLabel addGestureRecognizer:tap1];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:@"maskView_dismiss" object:nil];
}
//移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)chooseTime:(UIGestureRecognizer *)tap {
    _maskV = [[GLSet_MaskVeiw alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _maskV.bgView.alpha = 0.1;
    //
    if (!_contentView) {
        _contentView = [[SYDatePicker alloc] init];
    }
    
    [_contentView showInView:self.view withFrame:CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 200) andDatePickerMode:UIDatePickerModeTime];
    _contentView.delegate = self;
    
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[self.startTimeLabel convertRect: self.startTimeLabel.bounds toView:window];
    
    _contentView.frame = CGRectMake(10,CGRectGetMaxY(rect) + 10, SCREEN_WIDTH - 20, SCREEN_HEIGHT - (CGRectGetMaxY(rect) + 10));
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 4;
    _contentView.layer.masksToBounds = YES;
    
    [_maskV showViewWithContentView:_contentView];
    
    if (tap.view == self.startTimeLabel) {
        _whichOne = 1;
    }else{
        _whichOne = 2;
    }
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        _maskV.alpha = 0;
    } completion:^(BOOL finished) {
        [_maskV removeFromSuperview];
        
    }];
}
- (void)ensureBtnClick {
    [self dismiss];
}
- (void)picker:(UIDatePicker *)picker ValueChanged:(NSDate *)date{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"HH:mm:a";
    if (_whichOne == 1) {
        self.startTimeLabel.text = [fm stringFromDate:date];
    }else{
        self.endTimeLabel.text = [fm stringFromDate:date];
    }

    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.phoneTextF && [string isEqualToString:@"\n"]) {
        [self.passwordTextF becomeFirstResponder];
        return NO;
    }else if (textField == self.passwordTextF && [string isEqualToString:@"\n"]) {
        [self.farenNameTextF becomeFirstResponder];
        return NO;
    }else if (textField == self.farenNameTextF && [string isEqualToString:@"\n"]) {
        
        [self.farenIDTextF becomeFirstResponder];
        return NO;
        
    }else if (textField == self.farenIDTextF && [string isEqualToString:@"\n"]){
        [self.mailboxTextF becomeFirstResponder];
        return NO;
    }
    else if (textField == self.mailboxTextF && [string isEqualToString:@"\n"]){
        [self.mianjiTextF becomeFirstResponder];
        return NO;
    }else if (textField == self.mianjiTextF && [string isEqualToString:@"\n"]){
        [self.view endEditing:YES];
        return NO;
    }
   
    if (textField == self.farenIDTextF || textField == self.mailboxTextF) {
        
        for(int i=0; i< [string length];i++){
            
            int a = [string characterAtIndex:i];
            
            if( a >= 0x4e00 && a <= 0x9fff)
                
                return NO;
        }
    }
    
    if (textField == self.farenNameTextF && ![string isEqualToString:@""] ) {
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
    if(textField == self.mianjiTextF){
        BOOL isHaveDian = false;
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        if ([string length] > 0) {
            
            unichar single = [string characterAtIndex:0];//当前输入的字符
            
            if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
                
                //首字母不能为0和小数点
                if([textField.text length] == 0){
                    if(single == '.') {
                        [MBProgressHUD showError:@"亲，第一个数字不能为小数点"];
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                    if (single == '0') {
                        [MBProgressHUD showError:@"亲，第一个数字不能为0"];
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                
                //输入的字符是否是小数点
                if (single == '.') {
                    if(!isHaveDian)//text中还没有小数点
                    {
                        isHaveDian = YES;
                        return YES;
                        
                    }else{
                        [MBProgressHUD showError:@"亲，您已经输入过小数点了"];
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else{
                    if (isHaveDian) {//存在小数点
                        
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 2) {
                            return YES;
                        }else{
                            [MBProgressHUD showError:@"亲，您最多输入两位小数"];
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{//输入的数据格式不正确
                [MBProgressHUD showError:@"亲，您输入的格式不正确"];
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }

    }
    
    return YES;
    
}

- (IBAction)nextClick:(id)sender {
    
    if (self.phoneTextF.text.length <=0 ) {
        [MBProgressHUD showError:@"请输入手机号码"];
        return;
    }else{
        if (![predicateModel valiMobile:self.phoneTextF.text]) {
            [MBProgressHUD showError:@"手机号格式不对"];
            return;
        }
    }
    if (self.passwordTextF.text.length <= 6 || self.passwordTextF.text.length >=20) {
        [MBProgressHUD showError:@"请输入6~20位的密码"];
        return;
    }else if(![predicateModel judgePassWordLegal:self.passwordTextF.text]){
        [MBProgressHUD showError:@"密码必须由字母和数字组成"];
        return;
    }
    if (self.farenNameTextF.text.length <=0 ) {
        [MBProgressHUD showError:@"请输入法人姓名"];
        return;
    }
    if (self.farenIDTextF.text.length <=0 ) {
        [MBProgressHUD showError:@"请输入法人身份证号"];
        return;
    }
    if (self.mailboxTextF.text.length <=0 ) {
        [MBProgressHUD showError:@"请输入邮箱"];
        return;
    }
    if (self.mianjiTextF.text.length <=0 ) {
        [MBProgressHUD showError:@"请输入门店面积"];
        return;
    }
    if ([self.startTimeLabel.text isEqualToString:@"开始时间"] ) {
        [MBProgressHUD showError:@"请输入店铺开始时间"];
        return;
    }
    if ([self.endTimeLabel.text isEqualToString:@"关门时间"]  ) {
        [MBProgressHUD showError:@"请输入店铺关门时间"];
        return;
    }
    if (self.contentTextV.text.length == 0) {
        [MBProgressHUD showError:@"请输入经营内容"];
        return;
    }

    self.hidesBottomBarWhenPushed = YES;

    GLSubmitSecondController *secondVC = [[GLSubmitSecondController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
}


@end
