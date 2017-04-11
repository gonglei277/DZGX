
//  GLLoginController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/5.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLLoginController.h"
#import "GLRegisterController.h"
#import "BasetabbarViewController.h"
#import "LoginIdentityView.h"

@interface GLLoginController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *scretTf;

@property (strong, nonatomic)LoginIdentityView *loginView;
@property (strong, nonatomic)UIView *maskView;
@property (strong, nonatomic)NSString *usertype;//用户类型 默认为善行者

@end

@implementation GLLoginController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bgView.layer.cornerRadius = 5;
//    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    self.bgView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.bgView.layer.shadowOpacity = 0.7;//阴影透明度，默认0
    self.bgView.layer.shadowRadius = 5;//阴影半径，默认3
    
    [self.loginView.cancelBt addTarget:self action:@selector(maskviewgesture) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.sureBt addTarget:self action:@selector(surebuttonEvent) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *maskvgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskviewgesture)];
    [self.maskView addGestureRecognizer:maskvgesture];
    //
    UITapGestureRecognizer *shanVgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shangViewgesture)];
    
    [self.loginView.shangView addGestureRecognizer:shanVgesture];
    //
    UITapGestureRecognizer *lingVgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lingViewgesture)];
    //
    [self.loginView.lingView addGestureRecognizer:lingVgesture];
    
    self.usertype = @"7";
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];

}
//注册
- (IBAction)registerClick:(id)sender {
    GLRegisterController *registerVC = [[GLRegisterController alloc] init];
    registerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:registerVC animated:YES completion:nil];
}

//登录
- (IBAction)login:(id)sender {
    
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.loginView];
    
    
}

//确定按
-(void)surebuttonEvent{

    
    [NetworkManager requestPOSTWithURLStr:@"user/login" paramDic:@{@"userphone":self.phone.text,@"password":self.scretTf.text,@"groupID":self.usertype} finish:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } enError:^(NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
        BasetabbarViewController *baseVC = [[BasetabbarViewController alloc] init];
         baseVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:baseVC animated:YES completion:nil];
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];

}

//选择善行者
-(void)shangViewgesture{
    
    self.usertype = @"7";
    self.loginView.shangImage.image=[UIImage imageNamed:@"lblocation_on"];
    self.loginView.lingimage.image=[UIImage imageNamed:@"lblocation_off"];
    
}
//一级零售商
-(void)lingViewgesture{
    
    self.usertype = @"7";
    self.loginView.shangImage.image=[UIImage imageNamed:@"lblocation_off"];
    self.loginView.lingimage.image=[UIImage imageNamed:@"lblocation_on"];
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.phone && [string isEqualToString:@"\n"]) {
        [self.scretTf becomeFirstResponder];
        return NO;
        
    }else if (textField == self.scretTf && [string isEqualToString:@"\n"]){
        
        [self.view endEditing:YES];
        return NO;
    }
    
    return YES;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
    
}

//点击maskview
-(void)maskviewgesture{
    
    [self.maskView removeFromSuperview];
    [self.loginView removeFromSuperview];
    
}

-(LoginIdentityView*)loginView{
    
    if (!_loginView) {
        _loginView=[[NSBundle mainBundle]loadNibNamed:@"LoginIdentityView" owner:self options:nil].firstObject;
        _loginView.frame=CGRectMake(20, (SCREEN_HEIGHT - 160)/2, SCREEN_WIDTH-40, 160);
        _loginView.alpha=1;
        
    }
    
    return _loginView;
    
}

-(UIView*)maskView{
    
    if (!_maskView) {
        _maskView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [_maskView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2f]];
        
    }
    return _maskView;
    
}

@end
