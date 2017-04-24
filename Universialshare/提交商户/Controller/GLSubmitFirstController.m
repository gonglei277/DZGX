//
//  GLSubmitFirstController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLSubmitFirstController.h"

@interface GLSubmitFirstController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation GLSubmitFirstController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"提交商户";
    self.topView.layer.cornerRadius = 5.f;
    self.topView.layer.masksToBounds = YES;
    
    self.middleView.layer.cornerRadius = 5.f;
    self.middleView.layer.masksToBounds = YES;
    
    self.bottomView.layer.cornerRadius = 5.f;
    self.bottomView.layer.masksToBounds = YES;
    
}



@end
