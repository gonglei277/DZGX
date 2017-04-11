//
//  GLConfirmOrderController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/1.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLConfirmOrderController.h"
#import "GLOrderDetailController.h"
#import "GLOrderPayView.h"
#import "GLSet_MaskVeiw.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface GLConfirmOrderController ()
{
    int _sumNum;
//    GLSet_MaskVeiw *_maskV;
}
@property (weak, nonatomic) IBOutlet UILabel *fanliLabel;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (nonatomic, strong)GLSet_MaskVeiw *maskV;
@property (nonatomic, strong)GLOrderPayView *payV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewH;

@end

@implementation GLConfirmOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"确认订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.fanliLabel.layer.borderWidth = 2;
    self.fanliLabel.layer.borderColor = YYSRGBColor(199, 78, 63, 1).CGColor;
    self.fanliLabel.layer.cornerRadius = 3;
    self.fanliLabel.clipsToBounds = YES;
    
    self.numberLabel.text = @"1";
    _sumNum = [self.numberLabel.text intValue];
  
    self.contentViewW.constant = SCREEN_WIDTH;
    self.contentViewH.constant = SCREEN_HEIGHT + 49;
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(dismiss) name:@"maskView_dismiss" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(ensurePassword:) name:@"input_PasswordNotification" object:nil];
    
}
- (void)dismiss {
    [_payV.passwordF resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        _payV.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT *0.5);

    }completion:^(BOOL finished) {

        [_maskV removeFromSuperview];
    }];
}

- (void)ensurePassword:(NSNotification *)userInfo{
    [self dismiss];
   
    NSLog(@"userinfo = %@",userInfo.userInfo[@"password"]);
}
  

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
- (IBAction)submitOrder:(UIButton *)sender {

    _maskV = [[GLSet_MaskVeiw alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _maskV.bgView.alpha = 0.1;
    
    _payV = [[NSBundle mainBundle] loadNibNamed:@"GLOrderPayView" owner:nil options:nil].lastObject;
    [_payV.backBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _maskV.alpha = 1;
        _payV.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    [_maskV showViewWithContentView:_payV];
 
    [UIView animateWithDuration:0.3 animations:^{
        _payV.frame = CGRectMake(0, SCREEN_HEIGHT *0.5 , SCREEN_WIDTH, SCREEN_HEIGHT *0.5);
        [_payV.passwordF becomeFirstResponder];
    }];

}

- (IBAction)changeNum:(id)sender {
    
    if (sender == self.reduceBtn) {
        _sumNum -= 1;
        if(_sumNum < 1){
            _sumNum = 1;
        }
    }else{
        _sumNum += 1;
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%d",_sumNum];
    
}

@end
