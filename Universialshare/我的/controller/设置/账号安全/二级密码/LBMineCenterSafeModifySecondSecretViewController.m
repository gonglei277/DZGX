//
//  LBMineCenterSafeModifySecondSecretViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/31.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineCenterSafeModifySecondSecretViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LBMineCenterSafeModifySecondSecretViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewW;
@property (weak, nonatomic) IBOutlet UIView *baseviewT;
@property (weak, nonatomic) IBOutlet UIView *baseviewO;

@property (weak, nonatomic) IBOutlet UITextField *bseTsecret;

@property (weak, nonatomic) IBOutlet UITextField *basTRepSecTf;

@property (weak, nonatomic) IBOutlet UIButton *donebt;
@property (weak, nonatomic) IBOutlet UIButton *netbutton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baseTW;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baseOW;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UIView *secretView;

@property (weak, nonatomic) IBOutlet UIImageView *imageOne;

@property (weak, nonatomic) IBOutlet UIImageView *imageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imagethree;
@property (weak, nonatomic) IBOutlet UIImageView *imageFour;
@property (weak, nonatomic) IBOutlet UIImageView *imagefive;
@property (weak, nonatomic) IBOutlet UIImageView *imagesix;

@property (weak, nonatomic) IBOutlet UITextField *soldecretTf;

@property (strong, nonatomic)NSString *sixSecret;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secretViewH;

@end

@implementation LBMineCenterSafeModifySecondSecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.soldecretTf rac_textSignal] subscribeNext:^(id x) {
        
        
        if (_sixSecret.length > 6) {
            _sixSecret = [_sixSecret substringToIndex:6];
        }else{
            _sixSecret = [NSString stringWithFormat:@"%@",x];
        }
        
        if (_sixSecret.length == 0) {
           
            [self showimageone:@"" imagetwo:@"" imagethree:@"" imagefour:@"" imagefive:@"" imagesix:@""];
            
        }else if (_sixSecret.length == 1){
            
            [self showimageone:@"XRPlaceholder" imagetwo:@"" imagethree:@"" imagefour:@"" imagefive:@"" imagesix:@""];
        
        }else if (_sixSecret.length == 2){
            
            [self showimageone:@"XRPlaceholder" imagetwo:@"XRPlaceholder" imagethree:@"" imagefour:@"" imagefive:@"" imagesix:@""];
            
        }else if (_sixSecret.length == 3){
            
            [self showimageone:@"XRPlaceholder" imagetwo:@"XRPlaceholder" imagethree:@"XRPlaceholder" imagefour:@"" imagefive:@"" imagesix:@""];
            
        }else if (_sixSecret.length == 4){
            
            [self showimageone:@"XRPlaceholder" imagetwo:@"XRPlaceholder" imagethree:@"XRPlaceholder" imagefour:@"XRPlaceholder" imagefive:@"" imagesix:@""];
            
        }else if (_sixSecret.length == 5){
            
            [self showimageone:@"XRPlaceholder" imagetwo:@"XRPlaceholder" imagethree:@"XRPlaceholder" imagefour:@"XRPlaceholder" imagefive:@"XRPlaceholder" imagesix:@""];
            
        }else if (_sixSecret.length == 6){
            
            [self showimageone:@"XRPlaceholder" imagetwo:@"XRPlaceholder" imagethree:@"XRPlaceholder" imagefour:@"XRPlaceholder" imagefive:@"XRPlaceholder" imagesix:@"XRPlaceholder"];
            
        }
        
    }];
    
}

-(void)showimageone:(NSString*)imageone imagetwo:(NSString*)imagetwo imagethree:(NSString*)imagethree imagefour:(NSString*)imagefour imagefive:(NSString*)imagefive imagesix:(NSString*)imagesix{

    _imageOne.image = [UIImage imageNamed:imageone];
    _imageTwo.image = [UIImage imageNamed:imagetwo];
    _imagethree.image = [UIImage imageNamed:imagethree];
    _imageFour.image = [UIImage imageNamed:imagefour];
    _imagefive.image = [UIImage imageNamed:imagefive];
    _imagesix.image = [UIImage imageNamed:imagesix];


}


- (IBAction)clickNextBt:(UIButton *)sender {
    
    [self.view endEditing:YES];
     [self.scrollview setContentOffset:CGPointMake(SCREEN_WIDTH - 60, 0) animated:YES];
}

- (IBAction)ClickDonebt:(UIButton *)sender {
    

    [[NSNotificationCenter defaultCenter]postNotificationName:@"LoveConsumptionVC" object:nil];
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.donebt.layer.cornerRadius = 4;
    self.donebt.clipsToBounds = YES;
    
    self.netbutton.layer.cornerRadius = 4;
    self.netbutton.clipsToBounds = YES;
    
    self.bseTsecret.layer.cornerRadius = 4;
    self.bseTsecret.clipsToBounds = YES;
    
    self.basTRepSecTf.layer.cornerRadius = 4;
    self.basTRepSecTf.clipsToBounds = YES;
    
    self.bseTsecret.layer.borderWidth = 1;
    self.bseTsecret.layer.borderColor = YYSRGBColor(233, 233, 233, 1).CGColor;
    
    self.basTRepSecTf.layer.borderWidth = 1;
    self.basTRepSecTf.layer.borderColor = YYSRGBColor(233, 233, 233, 1).CGColor;
    
    self.contentViewW.constant = (SCREEN_WIDTH - 60)*2;
    
    self.baseOW.constant = SCREEN_WIDTH - 60;
    self.baseTW.constant = SCREEN_WIDTH - 60;
    
    self.secretView.layer.borderWidth = 1;
    self.secretView.layer.borderColor = YYSRGBColor(203, 203, 203, 1).CGColor;
    
    self.secretViewH.constant = (SCREEN_WIDTH - 105)/6;

}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.soldecretTf && [string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    else if (textField == self.bseTsecret && [string isEqualToString:@"\n"]) {
        [self.basTRepSecTf becomeFirstResponder];
        return NO;
    }else if (textField == self.basTRepSecTf && [string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    
    return YES;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.soldecretTf becomeFirstResponder];

}

@end
