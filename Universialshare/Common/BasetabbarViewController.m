//
//  BasetabbarViewController.m
//  PovertyAlleviation
//
//  Created by 四川三君科技有限公司 on 2017/2/20.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "BasetabbarViewController.h"
#import "GLHomePageController.h"
#import "LBIntegralMallViewController.h"
#import "LBMineViewController.h"
#import "BaseNavigationViewController.h"

#import "GLLoginController.h"
#import "GLFirstPageController.h"
#import "GLLoginController.h"

@interface BasetabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation BasetabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.delegate=self;
    [self addViewControllers];
    
    self.selectedIndex=0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(pushToHome) name:@"notification_push" object:nil];
}

- (void)addViewControllers {
    
    
    GLFirstPageController *firstVC = [[GLFirstPageController alloc] init];
    GLHomePageController *Homevc = [[GLHomePageController alloc] init];
    
//    GLLoginController *Homevc = [[GLLoginController alloc] init];
    LBIntegralMallViewController *IntegralMallvc = [[LBIntegralMallViewController alloc] init];
    LBMineViewController *minevc = [[LBMineViewController alloc] init];
    
   
     BaseNavigationViewController *firstNav = [[BaseNavigationViewController alloc] initWithRootViewController:firstVC];
    BaseNavigationViewController *Homenav = [[BaseNavigationViewController alloc] initWithRootViewController:Homevc];
    BaseNavigationViewController *IntegralMallnav = [[BaseNavigationViewController alloc] initWithRootViewController:IntegralMallvc];
    BaseNavigationViewController *minenav = [[BaseNavigationViewController alloc] initWithRootViewController:minevc];
   
   
    firstVC.title = @"首页";
    Homevc.title=@"商城首页";
    IntegralMallvc.title=@"积分商城";
    minevc.title=@"我的";

    firstVC.tabBarItem = [self barTitle:@"首页" image:@"home_page_normal"  selectImage:@"home_page_select"];
    Homevc.tabBarItem = [self barTitle:@"首页" image:@"home_page_normal" selectImage:@"home_page_select"];
    IntegralMallvc.tabBarItem = [self barTitle:@"积分商城" image:@"public_welfare_consumption_normal" selectImage:@"public_welfare_consumption_select"];
    minevc.tabBarItem = [self barTitle:@"我的" image:@"mine_normal" selectImage:@"mine_select"];
    
    
    self.viewControllers = @[firstNav, Homenav, IntegralMallnav, minenav,];
    
}


- (UITabBarItem *)barTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    UITabBarItem *item = [[UITabBarItem alloc] init];
    
    item.title = title;
    item.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : TABBARTITLE_COLOR} forState:UIControlStateSelected];
    
    return item;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    if (viewController == [tabBarController.viewControllers objectAtIndex:0]) {

    }
    if (viewController == [tabBarController.viewControllers objectAtIndex:1]) {
      
    }
    if (viewController == [tabBarController.viewControllers objectAtIndex:2]) {
       
    }
    if (viewController == [tabBarController.viewControllers objectAtIndex:3]) {
       
        if ([UserModel defaultUser].loginstatus == YES) {
            return YES;
        }
        GLLoginController *loginVC = [[GLLoginController alloc] init];
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginVC];
        nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nav animated:YES completion:nil];
        return NO;
        
    }
    
    return YES;
}

- (void)pushToHome{
    
     self.selectedIndex=0;
}

@end
