//
//  AppDelegate.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "BasetabbarViewController.h"
#import "GLLoginController.h"
#import "IQKeyboardManager.h"
#import "BaseNavigationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
     GLLoginController *loginVC = [[GLLoginController alloc] init];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginVC];
   
    self.window.rootViewController = nav;
//     self.window.rootViewController = [[BasetabbarViewController alloc]init];

    return YES;
}

#pragma mark - 键盘高度处理
- (void)iqKeyboardShowOrHide {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}


@end
