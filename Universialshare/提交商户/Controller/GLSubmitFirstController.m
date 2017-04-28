//
//  GLSubmitFirstController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLSubmitFirstController.h"
#import "GLSubmitSecondController.h"
#import "SYDatePicker.h"
#import "GLSet_MaskVeiw.h"

@interface GLSubmitFirstController ()<SYDatePickerDelegate>
{
    SYDatePicker *_contentView;
    GLSet_MaskVeiw * _maskV;
    int _whichOne;//区分两个时间
}
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

@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTime:)];
    [self.startTimeLabel addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTime:)];
    [self.endTimeLabel addGestureRecognizer:tap1];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:@"maskView_dismiss" object:nil];
}
//移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)chooseTime:(UIGestureRecognizer *)tap {
    _maskV = [[GLSet_MaskVeiw alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _maskV.bgView.alpha = 0.1;
    //
    if (!_contentView) {
        _contentView = [[SYDatePicker alloc] init];
    }
    
    [_contentView showInView:self.view withFrame:CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 200) andDatePickerMode:UIDatePickerModeTime];
    _contentView.delegate = self;
    
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[self.startTimeLabel convertRect: self.startTimeLabel.bounds toView:window];
    
    _contentView.frame = CGRectMake(10,CGRectGetMaxY(rect) + 10, SCREEN_WIDTH - 20, SCREEN_HEIGHT - (CGRectGetMaxY(rect) + 10));
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 4;
    _contentView.layer.masksToBounds = YES;
    
    [_maskV showViewWithContentView:_contentView];
    
    if (tap.view == self.startTimeLabel) {
        _whichOne = 1;
    }else{
        _whichOne = 2;
    }
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        _maskV.alpha = 0;
    } completion:^(BOOL finished) {
        [_maskV removeFromSuperview];
        
    }];
}
- (void)ensureBtnClick {
    [self dismiss];
}
- (void)picker:(UIDatePicker *)picker ValueChanged:(NSDate *)date{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"HH:mm";
    if (_whichOne == 1) {
        self.startTimeLabel.text = [fm stringFromDate:date];
    }else{
        self.endTimeLabel.text = [fm stringFromDate:date];
    }

    
    
}
- (IBAction)nextClick:(id)sender {
    self.hidesBottomBarWhenPushed = YES;

    GLSubmitSecondController *secondVC = [[GLSubmitSecondController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
}


@end
