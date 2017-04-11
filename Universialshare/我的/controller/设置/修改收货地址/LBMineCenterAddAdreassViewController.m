//
//  LBMineCenterAddAdreassViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/30.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineCenterAddAdreassViewController.h"
#import "LBMineCenterChooseAreaViewController.h"
#import "editorMaskPresentationController.h"

@interface LBMineCenterAddAdreassViewController ()<UITextFieldDelegate,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
{
    BOOL      _ishidecotr;//判断是否隐藏弹出控制器
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentVH;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentVW;

@property (weak, nonatomic) IBOutlet UITextField *nameTf;

@property (weak, nonatomic) IBOutlet UITextField *phoneTf;

@property (weak, nonatomic) IBOutlet UITextField *provinceTf;

@property (weak, nonatomic) IBOutlet UITextField *streetTf;

@property (weak, nonatomic) IBOutlet UITextField *codeTf;

@property (weak, nonatomic) IBOutlet UITextField *adressTf;

@property (weak, nonatomic) IBOutlet UIButton *savebutoon;


@end

@implementation LBMineCenterAddAdreassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"新增收货地址";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.nameTf && [string isEqualToString:@"\n"]) {
        [self.phoneTf becomeFirstResponder];
        return NO;
    }else if (textField == self.phoneTf && [string isEqualToString:@"\n"]) {
        [self.streetTf becomeFirstResponder];
        return NO;
    }else if (textField == self.streetTf && [string isEqualToString:@"\n"]) {
        [self.codeTf becomeFirstResponder];
        return NO;
    }else if (textField == self.codeTf && [string isEqualToString:@"\n"]) {
        [self.adressTf becomeFirstResponder];
        return NO;
    }else if (textField == self.adressTf && [string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    
    return YES;
    
}


- (IBAction)tapgestureChoose:(UITapGestureRecognizer *)sender {
    
    LBMineCenterChooseAreaViewController *vc=[[LBMineCenterChooseAreaViewController alloc]init];
    vc.transitioningDelegate=self;
    vc.modalPresentationStyle=UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
    
    __weak typeof(self) weakself = self;
    vc.returnreslut = ^(NSString *str){
    
        weakself.provinceTf.text = str;
    };
   
    
}

- (IBAction)saveBtevent:(UIButton *)sender {
    
    
}


- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    
    return [[editorMaskPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    
}

//控制器创建执行的动画（返回一个实现UIViewControllerAnimatedTransitioning协议的类）
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    _ishidecotr=YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _ishidecotr=NO;
    return self;
}
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    return 0.5;
    
}
-(void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (_ishidecotr==YES) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        toView.frame=CGRectMake(-SCREEN_WIDTH, (SCREEN_HEIGHT - 300)/2, SCREEN_WIDTH - 40, 280);
        toView.layer.cornerRadius = 6;
        toView.clipsToBounds = YES;
        [transitionContext.containerView addSubview:toView];
        [UIView animateWithDuration:0.3 animations:^{
           
            toView.frame=CGRectMake(20, (SCREEN_HEIGHT - 300)/2, SCREEN_WIDTH - 40, 280);
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES]; //这个必须写,否则程序 认为动画还在执行中,会导致展示完界面后,无法处理用户的点击事件
            
        }];
    }else{
        
        UIView *toView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
            [UIView animateWithDuration:0.3 animations:^{
                
                toView.frame=CGRectMake(20 + SCREEN_WIDTH, (SCREEN_HEIGHT - 300)/2, SCREEN_WIDTH - 40, 280);
                
            } completion:^(BOOL finished) {
                if (finished) {
                    [toView removeFromSuperview];
                    [transitionContext completeTransition:YES]; //这个必须写,否则程序 认为动画还在执行中,会导致展示完界面后,无法处理用户的点击事件
                }
                
            }];
            
        }
        
    }
    



-(void)updateViewConstraints{

    [super updateViewConstraints];
    self.contentVH.constant = 310;
    self.contentVW.constant = SCREEN_WIDTH;
    
    self.savebutoon.layer.cornerRadius = 4;
    self.savebutoon.clipsToBounds=YES;

}

@end
