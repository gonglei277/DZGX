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
}

- (IBAction)nextClick:(id)sender {
    self.hidesBottomBarWhenPushed = YES;

    GLSubmitSecondController *secondVC = [[GLSubmitSecondController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
}


@end
