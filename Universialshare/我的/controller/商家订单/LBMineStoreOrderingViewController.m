//
//  LBMineStoreOrderingViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/14.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineStoreOrderingViewController.h"
#import "LBMineStoreTodayOrderingViewController.h"
#import "LBMineStoreHistoryOrderingViewController.h"

@interface LBMineStoreOrderingViewController ()

@property (weak, nonatomic) IBOutlet UIButton *todatbutton;
@property (weak, nonatomic) IBOutlet UIButton *historybutton;
@property (strong, nonatomic)LBMineStoreTodayOrderingViewController *todayVc;
@property (strong, nonatomic)LBMineStoreHistoryOrderingViewController *historyVc;
@property (nonatomic, strong)UIViewController *currentViewController;
@property (nonatomic, strong)UIView *contentView;

@end

@implementation LBMineStoreOrderingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"我的订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _todayVc=[[LBMineStoreTodayOrderingViewController alloc]init];
    _historyVc=[[LBMineStoreHistoryOrderingViewController alloc]init];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-114)];
    [self.view addSubview:_contentView];
    
    [self addChildViewController:_todayVc];
    [self addChildViewController:_historyVc];
    
    self.currentViewController = _todayVc;
    [self fitFrameForChildViewController:_todayVc];
    [self.contentView addSubview:_todayVc.view];
    
}

- (void)fitFrameForChildViewController:(UIViewController *)childViewController{
    CGRect frame = self.contentView.frame;
    frame.origin.y = 0;
    childViewController.view.frame = frame;
}

- (void)transitionFromVC:(UIViewController *)viewController toviewController:(UIViewController *)toViewController {
    
    if ([toViewController isEqual:self.currentViewController]) {
        return;
    }
    [self transitionFromViewController:viewController toViewController:toViewController duration:0.5 options:UIViewAnimationOptionCurveEaseIn animations:nil completion:^(BOOL finished) {
        [viewController willMoveToParentViewController:nil];
        [toViewController willMoveToParentViewController:self];
        self.currentViewController = toViewController;
    }];
    
    
}

- (IBAction)todaybutton:(UIButton *)sender {
    
    [self transitionFromVC:self.currentViewController toviewController:_todayVc];
    [self fitFrameForChildViewController:_todayVc];
    
}

- (IBAction)historybutton:(UIButton *)sender {
    
    [self transitionFromVC:self.currentViewController toviewController:_historyVc];
    [self fitFrameForChildViewController:_historyVc];

    
    
}



@end
