//
//  LBSetUpViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/28.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBSetUpViewController.h"
#import "LBMineCentermodifyAdressViewController.h"
#import "LBMineCenterAccountSafeViewController.h"


@interface LBSetUpViewController ()

@property (weak, nonatomic) IBOutlet UIButton *exitBt;


@end

@implementation LBSetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"设置";
}
//修改收货地址
- (IBAction)exchangeAdress:(UITapGestureRecognizer *)sender {
    self.hidesBottomBarWhenPushed = YES;
    LBMineCentermodifyAdressViewController *vc=[[LBMineCentermodifyAdressViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
   
}
//清除缓存
- (IBAction)clearMomery:(UITapGestureRecognizer *)sender {
    
    
}
//账号安全
- (IBAction)accountSafe:(UITapGestureRecognizer *)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    LBMineCenterAccountSafeViewController *vc=[[LBMineCenterAccountSafeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
   
}
//关于
- (IBAction)aboutUs:(UITapGestureRecognizer *)sender {
    
    
}
//退出登录
- (IBAction)exitEvent:(UIButton *)sender {
    
    
}


-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.exitBt.layer.cornerRadius = 5;
    self.exitBt.clipsToBounds = YES;


}

@end
