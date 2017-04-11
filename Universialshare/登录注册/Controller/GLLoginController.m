
//  GLLoginController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/5.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLLoginController.h"
#import "GLRegisterController.h"
#import "BasetabbarViewController.h"


@interface GLLoginController ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

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
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];

}
//注册
- (IBAction)registerClick:(id)sender {
    GLRegisterController *registerVC = [[GLRegisterController alloc] init];
    registerVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:registerVC animated:YES completion:nil];
}

//登录
- (IBAction)login:(id)sender {
    BasetabbarViewController *baseVC = [[BasetabbarViewController alloc] init];
     baseVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:baseVC animated:YES completion:nil];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}


@end
