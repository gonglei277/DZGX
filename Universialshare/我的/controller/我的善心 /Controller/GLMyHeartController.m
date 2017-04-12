//
//  GLMyHeartController.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLMyHeartController.h"
#import "GLSixPersentController.h"
#import "GLTwelevePersentController.h"
#import "GLTweleveFourController.h"

@interface GLMyHeartController ()
{
    UIButton *_tmpBtn;
}

@property (nonatomic, strong)GLSixPersentController *sixPersentVC;
@property (nonatomic, strong)GLTwelevePersentController *twelvePercentVC;
@property (nonatomic, strong)GLTweleveFourController *twentyfourPercentVC;
@property (nonatomic, strong)UIViewController *currentViewController;
@property (nonatomic, strong)UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *sixBtn;
@property (weak, nonatomic) IBOutlet UIButton *twelveBtn;
@property (weak, nonatomic) IBOutlet UIButton *twelveFourBtn;
@property (nonatomic, strong)UIButton *currentButton;

@property (nonatomic,strong)NSMutableArray *models;

@end

@implementation GLMyHeartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的爱心";
    
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor=[UIColor whiteColor];
    
    _sixPersentVC = [[GLSixPersentController alloc]init];
    _twelvePercentVC = [[GLTwelevePersentController alloc]init];
    _twentyfourPercentVC = [[GLTweleveFourController alloc]init];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-114)];
    [self.view addSubview:_contentView];
    
    [self addChildViewController:_sixPersentVC];
    [self addChildViewController:_twelvePercentVC];
    [self addChildViewController:_twentyfourPercentVC];
    
    
    self.currentViewController = _sixPersentVC;
    [self fitFrameForChildViewController:_sixPersentVC];
    [self.contentView addSubview:_sixPersentVC.view];
    
    self.currentButton = self.sixBtn;
    self.sixBtn.selected = YES;
    self.twelveBtn.selected = NO;
    self.twelveFourBtn.selected = NO;
    
    
       
}
- (void)fitFrameForChildViewController:(UIViewController *)childViewController{
    CGRect frame = self.contentView.frame;
    frame.origin.y = 0;
    childViewController.view.frame = frame;
}

//百分之六激励
- (IBAction)buttonEvent:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    if (sender.selected == NO) {
//        sender.selected = YES;
//        return;
//    }
        if (_tmpBtn == nil){
            sender.selected = YES;
            _tmpBtn = sender;
        }
        else if (_tmpBtn !=nil && _tmpBtn == sender){
            sender.selected = YES;
    
            sender.titleLabel.backgroundColor = [UIColor redColor];
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
        }
        else if (_tmpBtn!= sender && _tmpBtn!=nil){
            _tmpBtn.selected = NO;
            _tmpBtn.titleLabel.backgroundColor = [UIColor whiteColor];
//            _tmpBtn.titleLabel.textColor = [UIColor darkGrayColor];
            [sender setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
            sender.selected = YES;
            sender.titleLabel.backgroundColor = [UIColor redColor];
//            sender.titleLabel.textColor = [UIColor whiteColor];
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            _tmpBtn = sender;
        }
    
//        [UIView animateWithDuration:0.2 animations:^{
//
//        } completion:^(BOOL finished) {
//            self.currentButton = sender;
//            sender.selected = !sender.selected;
//        }];
    
    if (sender == self.sixBtn) {
//        self.twelveBtn.selected = NO;
//        self.twelveFourBtn.selected = NO;
        [self transitionFromVC:self.currentViewController toviewController:_sixPersentVC];
        [self fitFrameForChildViewController:_sixPersentVC];
    }else if (sender == self.twelveBtn){
//        self.sixBtn.selected = NO;
//        self.twelveFourBtn.selected = NO;
        [self transitionFromVC:self.currentViewController toviewController:_twelvePercentVC];
        [self fitFrameForChildViewController:_twelvePercentVC];
    }else{
//        self.sixBtn.selected = NO;
//        self.twelveBtn.selected = NO;
        [self transitionFromVC:self.currentViewController toviewController:_twentyfourPercentVC];
        [self fitFrameForChildViewController:_twentyfourPercentVC];
    }
    
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


@end
