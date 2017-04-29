//
//  GLSubmitSecondController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLSubmitSecondController.h"
#import "GLCityModel.h"
#import "LBMerchantSubmissionThreeViewController.h"
#import "LBAddrecomdManChooseAreaViewController.h"
#import "editorMaskPresentationController.h"

@interface GLSubmitSecondController ()<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
{
    int _index;
    NSInteger _provinceIndex;
    NSInteger _cityIndex;
    NSInteger _countryIndex;
    
    BOOL      _ishidecotr;//判断是否隐藏弹出控制器
}

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;

@property (strong, nonatomic)NSMutableArray *dataarr;
@property (strong, nonatomic)LoadWaitView *loadV;
@property (assign, nonatomic)NSInteger page;//页数默认为0
@property (assign, nonatomic)BOOL refreshType;//判断刷新状态 默认为no
@property (strong, nonatomic)UIPickerView *pickerView;
@property (strong, nonatomic)UIView *pickerViewMask;
@property (strong, nonatomic)NodataView *nodataV;

@property (assign, nonatomic)NSInteger messageType;//消息类型 默认为1
@property (strong, nonatomic)NSMutableArray *messageArr;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;


@property (weak, nonatomic) IBOutlet UIButton *provinceBtn;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIButton *countryBtn;
@property (weak, nonatomic) IBOutlet UIButton *classifyOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *classifyTwoBtn;

@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;

@property (strong, nonatomic)UIView *incentiveModelMaskV;

//省市区选择
@property (nonatomic, strong)NSMutableArray *provinceArr;
@property (nonatomic, strong)NSMutableArray *cityArr;
@property (nonatomic, strong)NSMutableArray *countryArr;
@property (nonatomic, assign)NSInteger ischosePro;//记录选择省的第几行
@property (nonatomic, assign)NSInteger ischoseCity;//记录选择市的第几行
@property (nonatomic, assign)NSInteger ischoseArea;//记录选择区的第几行

@end

@implementation GLSubmitSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提交商户";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.topView.layer.cornerRadius = 5.f;
    self.topView.layer.masksToBounds = YES;
    
    self.middleView.layer.cornerRadius = 5.f;
    self.middleView.layer.masksToBounds = YES;

    self.bottomView.layer.cornerRadius = 5.f;
    self.bottomView.layer.masksToBounds = YES;
    
    self.contentViewHeight.constant = SCREEN_HEIGHT;
    self.contentViewWidth.constant = SCREEN_WIDTH;
    
    self.nextBtn.layer.cornerRadius = 5.f;
    self.nextBtn.clipsToBounds = YES;
    
    self.provinceArr = [NSMutableArray array];
    self.cityArr = [NSMutableArray array];
    self.countryArr = [NSMutableArray array];
    
    
    [self getPickerData];
}

#pragma mark - get data
- (void)getPickerData {
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:[UIApplication sharedApplication].keyWindow];
    [NetworkManager requestPOSTWithURLStr:@"user/getCityList" paramDic:@{} finish:^(id responseObject) {
        [_loadV removeloadview];
        if ([responseObject[@"code"] integerValue]==1) {
            self.provinceArr = responseObject[@"data"];
        }
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [MBProgressHUD showError:error.localizedDescription];
        
    }];
    
}

//选择等级
//- (IBAction)chooseLevel:(UITapGestureRecognizer *)sender {
//    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
//    CGRect rect=[self.levelView convertRect: self.levelView.bounds toView:window];
//    
//    self.incentiveModelV.frame=CGRectMake(SCREEN_WIDTH-130, rect.origin.y+20, 120, 80);
//    
//    [self.view addSubview:self.incentiveModelMaskV];
//    [self.incentiveModelMaskV addSubview:self.incentiveModelV];
//    
//    UITapGestureRecognizer *incentiveModelMaskVgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(incentiveModelMaskVtapgestureLb)];
//    [self.incentiveModelMaskV addGestureRecognizer:incentiveModelMaskVgesture];
//    
//}

//选择省份
- (IBAction)choseProvince:(id)sender {
    
    LBAddrecomdManChooseAreaViewController *vc=[[LBAddrecomdManChooseAreaViewController alloc]init];
    vc.provinceArr = self.provinceArr;
    vc.titlestr = @"请选择省份";
    vc.returnreslut = ^(NSInteger index){
        _ischosePro = index;
        _provinceLabel.text = _provinceArr[index][@"province_name"];
        _provinceLabel.textColor = [UIColor blackColor];
    };
    vc.transitioningDelegate=self;
    vc.modalPresentationStyle=UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
    
}

//选择城市
- (IBAction)choseCity:(id)sender {
    if ([self.provinceLabel.text isEqualToString:@"请选择省份"]) {
        [MBProgressHUD showError:@"请选择省份"];
        return;
    }
    
    LBAddrecomdManChooseAreaViewController *vc=[[LBAddrecomdManChooseAreaViewController alloc]init];
    vc.provinceArr = self.provinceArr[_ischosePro][@"city"];
    vc.titlestr = @"请选择城市";
    vc.returnreslut = ^(NSInteger index){
        _ischoseCity = index;
        _cityLabel.text = _provinceArr[_ischosePro][@"city"][index][@"city_name"];
        _cityLabel.textColor = [UIColor blackColor];
        
    };
    vc.transitioningDelegate=self;
    vc.modalPresentationStyle=UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
    

}


//选择区域
- (IBAction)choseArea:(id)sender {
    
    if ([self.cityLabel.text isEqualToString:@"请选择城市"]) {
        [MBProgressHUD showError:@"请选择城市"];
        return;
    }
    
    LBAddrecomdManChooseAreaViewController *vc=[[LBAddrecomdManChooseAreaViewController alloc]init];
    vc.provinceArr = self.provinceArr[_ischosePro][@"city"][_ischoseCity][@"country"];
    vc.titlestr = @"请选择区域";
    vc.returnreslut = ^(NSInteger index){
        _ischoseArea = index;
        _countryLabel.text = _provinceArr[_ischosePro][@"city"][_ischoseCity][@"country"][index][@"country_name"];
        _countryLabel.textColor = [UIColor blackColor];
        
    };
    vc.transitioningDelegate=self;
    vc.modalPresentationStyle=UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];

}


//点击下一步
- (IBAction)nextbuttonevent:(UIButton *)sender {
    self.hidesBottomBarWhenPushed = YES;
    LBMerchantSubmissionThreeViewController *vc=[[LBMerchantSubmissionThreeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    
    return [[editorMaskPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    
}
//控制器创建执行的动画（返回一个实现UIViewControllerAnimatedTransitioning协议的类）
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    _ishidecotr=YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _ishidecotr=NO;
    return self;
}
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    return 0.5;
    
}
-(void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (_ishidecotr==YES) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        toView.frame=CGRectMake(-SCREEN_WIDTH, (SCREEN_HEIGHT - 300)/2, SCREEN_WIDTH - 40, 280);
        toView.layer.cornerRadius = 6;
        toView.clipsToBounds = YES;
        [transitionContext.containerView addSubview:toView];
        [UIView animateWithDuration:0.3 animations:^{
            
            toView.frame=CGRectMake(20, (SCREEN_HEIGHT - 300)/2, SCREEN_WIDTH - 40, 280);
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES]; //这个必须写,否则程序 认为动画还在执行中,会导致展示完界面后,无法处理用户的点击事件
            
        }];
    }else{
        
        UIView *toView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            toView.frame=CGRectMake(20 + SCREEN_WIDTH, (SCREEN_HEIGHT - 300)/2, SCREEN_WIDTH - 40, 280);
            
        } completion:^(BOOL finished) {
            if (finished) {
                [toView removeFromSuperview];
                [transitionContext completeTransition:YES]; //这个必须写,否则程序 认为动画还在执行中,会导致展示完界面后,无法处理用户的点击事件
            }
            
        }];
        
    }
    
}

//点击maskview
-(void)incentiveModelMaskVtapgestureLb{
    
    [self.incentiveModelMaskV removeFromSuperview];

    
}
-(UIView*)incentiveModelMaskV{
    
    if (!_incentiveModelMaskV) {
        _incentiveModelMaskV=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _incentiveModelMaskV.backgroundColor=[UIColor clearColor];
    }
    
    return _incentiveModelMaskV;
    
}


-(NodataView*)nodataV{
    
    if (!_nodataV) {
        _nodataV=[[NSBundle mainBundle]loadNibNamed:@"NodataView" owner:self options:nil].firstObject;
        _nodataV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
    }
    return _nodataV;
    
}

@end
