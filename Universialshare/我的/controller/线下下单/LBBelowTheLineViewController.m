//
//  LBBelowTheLineViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/26.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBBelowTheLineViewController.h"

@interface LBBelowTheLineViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentW;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentH;
@property (weak, nonatomic) IBOutlet UIView *baseView1;
@property (weak, nonatomic) IBOutlet UIView *baseView2;
@property (weak, nonatomic) IBOutlet UIView *baseview3;
@property (weak, nonatomic) IBOutlet UIView *baseView4;
@property (weak, nonatomic) IBOutlet UIView *baseView5;
@property (weak, nonatomic) IBOutlet UIView *baseView6;
@property (weak, nonatomic) IBOutlet UIView *baseView7;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;
@property (weak, nonatomic) IBOutlet UIButton *comitbt;

@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *modeltf;
@property (weak, nonatomic) IBOutlet UITextField *moneyTf;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *numTf;
@property (weak, nonatomic) IBOutlet UITextField *yuliuTf;
@property (weak, nonatomic) IBOutlet UITextField *codeTf;



@end

@implementation LBBelowTheLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"线下下单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}




//选择激励模式
- (IBAction)choseJiliModel:(UITapGestureRecognizer *)sender {
}
//打款凭证
- (IBAction)choseimageone:(UITapGestureRecognizer *)sender {
}
//消费凭证
- (IBAction)choseimageTwo:(UITapGestureRecognizer *)sender {
}


//获取验证码
- (IBAction)getcodeEvent:(UIButton *)sender {
}
//提交
- (IBAction)submitInfoEvent:(UIButton *)sender {
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.baseView1.layer.cornerRadius = 4;
    self.baseView1.clipsToBounds = YES;
    self.baseView2.layer.cornerRadius = 4;
    self.baseView2.clipsToBounds = YES;
    self.baseview3.layer.cornerRadius = 4;
    self.baseview3.clipsToBounds = YES;
    self.baseView4.layer.cornerRadius = 4;
    self.baseView4.clipsToBounds = YES;
    self.baseView5.layer.cornerRadius = 4;
    self.baseView5.clipsToBounds = YES;
    self.baseView6.layer.cornerRadius = 4;
    self.baseView6.clipsToBounds = YES;
    self.baseView7.layer.cornerRadius = 4;
    self.baseView7.clipsToBounds = YES;

    self.codeBt.layer.cornerRadius = 4;
    self.codeBt.clipsToBounds = YES;
    self.comitbt.layer.cornerRadius = 4;
    self.comitbt.clipsToBounds = YES;
    
    self.contentW.constant = SCREEN_WIDTH;
    self.contentH.constant = 770;

}

@end
