//
//  GLSubmitFirstController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLSubmitFirstController.h"
#import "GLSubmitSecondController.h"

@interface GLSubmitFirstController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextF;
@property (weak, nonatomic) IBOutlet UITextField *farenNameTextF;
@property (weak, nonatomic) IBOutlet UITextField *farenIDTextF;
@property (weak, nonatomic) IBOutlet UITextField *mailboxTextF;
@property (weak, nonatomic) IBOutlet UITextField *mianjiTextF;
@property (weak, nonatomic) IBOutlet UIView *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextV;
@property (weak, nonatomic) IBOutlet UITextField *startSellTextF;
@property (weak, nonatomic) IBOutlet UITextField *endSellTextF;

@end

@implementation GLSubmitFirstController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"提交商户";
    self.topView.layer.cornerRadius = 5.f;
    self.topView.clipsToBounds = YES;
    
    self.middleView.layer.cornerRadius = 5.f;
    self.middleView.clipsToBounds = YES;
    
    self.bottomView.layer.cornerRadius = 5.f;
    self.bottomView.clipsToBounds = YES;
    
    self.contentViewWidth.constant = SCREEN_WIDTH;
    self.contentViewHeight.constant = SCREEN_HEIGHT;
    
    self.nextBtn.layer.cornerRadius = 5.f;
    self.nextBtn.clipsToBounds = YES;
    
    UIGestureRecognizer *tap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTime:)];
    [self.startSellTextF addGestureRecognizer:tap];
    
    UIGestureRecognizer *tap1 = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTime:)];
    [self.endSellTextF addGestureRecognizer:tap1];
}

- (void)chooseTime:(UIGestureRecognizer *)tap {
    
    if (tap.view == self.startSellTextF) {
        
    }else{
        
    }
}

- (IBAction)nextClick:(id)sender {
    self.hidesBottomBarWhenPushed = YES;

    GLSubmitSecondController *secondVC = [[GLSubmitSecondController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
}


@end
