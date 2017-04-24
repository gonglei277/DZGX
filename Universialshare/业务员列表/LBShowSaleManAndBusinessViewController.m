//
//  LBShowSaleManAndBusinessViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBShowSaleManAndBusinessViewController.h"
#import "LBMySalesmanListViewController.h"
#import "LBMyBusinessListViewController.h"
#import "LBMySalesmanListDeatilViewController.h"
#import "LBMyBusinessListDetailViewController.h"
#import "LBSaleManPersonInfoViewController.h"
#import "LBViewProtocolViewController.h"

@interface LBShowSaleManAndBusinessViewController ()
@property (weak, nonatomic) IBOutlet UIView *navigationV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIView *buttonv;
@property (weak, nonatomic) IBOutlet UIButton *saleBt;
@property (weak, nonatomic) IBOutlet UIButton *businessBt;
@property (strong, nonatomic)LBMyBusinessListViewController *businessListVc;
@property (strong, nonatomic)LBMySalesmanListViewController *salesmanListVc;
@property (nonatomic, strong)UIViewController *currentViewController;
@property (nonatomic, strong)UIView *contentView;

@property (nonatomic, strong)UIView *lineView;

@end

@implementation LBShowSaleManAndBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    //    self.navigationItem.title = @"商家列表";
        self.automaticallyAdjustsScrollViewInsets = NO;
     [self.buttonv addSubview:self.lineView];
    
    _businessListVc=[[LBMyBusinessListViewController alloc]init];
    _salesmanListVc=[[LBMySalesmanListViewController alloc]init];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-114)];
    [self.view addSubview:_contentView];
    
    [self addChildViewController:_businessListVc];
    [self addChildViewController:_salesmanListVc];
    
    self.currentViewController = _salesmanListVc;
    [self fitFrameForChildViewController:_salesmanListVc];
    [self.contentView addSubview:_salesmanListVc.view];
    
    __weak typeof(self) weakself = self;
    _salesmanListVc.returnpushvc = ^(){
    
        weakself.hidesBottomBarWhenPushed = YES;
        LBMySalesmanListDeatilViewController *vc=[[LBMySalesmanListDeatilViewController alloc]init];
        [weakself.navigationController pushViewController:vc animated:YES];
        weakself.hidesBottomBarWhenPushed = NO;
    };
    _businessListVc.returnpushvc = ^(){
        
        weakself.hidesBottomBarWhenPushed = YES;
        LBMyBusinessListDetailViewController *vc=[[LBMyBusinessListDetailViewController alloc]init];
        [weakself.navigationController pushViewController:vc animated:YES];
        weakself.hidesBottomBarWhenPushed = NO;
    };
    
    _salesmanListVc.returnpushinfovc = ^(NSInteger index){
    
        weakself.hidesBottomBarWhenPushed = YES;
        LBSaleManPersonInfoViewController *vc=[[LBSaleManPersonInfoViewController alloc]init];
        [weakself.navigationController pushViewController:vc animated:YES];
        weakself.hidesBottomBarWhenPushed = NO;
    
    };
    
    _businessListVc.returnpushinfovc = ^(NSInteger index){
        
       
        
    };
    
}

- (IBAction)salemanEvent:(UIButton *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = CGRectMake(0, 48, SCREEN_WIDTH / 2, 1);
        [self.saleBt setTitleColor:YYSRGBColor(196, 52, 28, 1) forState:UIControlStateNormal];
        [self.businessBt setTitleColor:YYSRGBColor(0, 0, 0, 1) forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        
    }];
    
    [self transitionFromVC:self.currentViewController toviewController:_salesmanListVc];
    [self fitFrameForChildViewController:_salesmanListVc];
}


- (IBAction)businessEvent:(UIButton *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = CGRectMake(SCREEN_WIDTH / 2, 48, SCREEN_WIDTH / 2, 1);
        [self.businessBt setTitleColor:YYSRGBColor(196, 52, 28, 1) forState:UIControlStateNormal];
        [self.saleBt setTitleColor:YYSRGBColor(0, 0, 0, 1) forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        
    }];
    
    [self transitionFromVC:self.currentViewController toviewController:_businessListVc];
    [self fitFrameForChildViewController:_businessListVc];
    
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

-(UIView*)lineView{
    
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 48, SCREEN_WIDTH / 2, 1)];
        _lineView.backgroundColor = YYSRGBColor(196, 52, 28, 1);
    }
    
    return _lineView;
    
}

@end
