//
//  GLSubmitSecondController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLSubmitSecondController.h"

@interface GLSubmitSecondController ()

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation GLSubmitSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topView.layer.cornerRadius = 5.f;
    self.topView.layer.masksToBounds = YES;
    
    self.middleView.layer.cornerRadius = 5.f;
    self.middleView.layer.masksToBounds = YES;

    self.bottomView.layer.cornerRadius = 5.f;
    self.bottomView.layer.masksToBounds = YES;
}

@end
