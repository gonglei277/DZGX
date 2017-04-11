//
//  GLFirstPageController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/7.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLFirstPageController.h"
#import "GLFirstHeartCell.h"
#import "GLFirstFollowCell.h"

#import "GLDailyView.h"
#import "GLRankingView.h"
#import "GLRewardView.h"

@interface GLFirstPageController ()

{
    UIImageView *_imageviewLeft , *_imageviewRight;
}

@property (weak, nonatomic) IBOutlet UIView *sidebarView;

@property (nonatomic, strong) GLDailyView*dailyContentView;
@property (nonatomic, strong)GLRankingView *rankingContentView;
@property (nonatomic, strong)GLRewardView *rewardContentView;

@property (weak, nonatomic) IBOutlet UIView *dailyView;
@property (weak, nonatomic) IBOutlet UIView *rankingView;
@property (weak, nonatomic) IBOutlet UIView *rewardView;
@property (weak, nonatomic) IBOutlet UILabel *dailyLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankingLabel;
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *bgView2;
@property (weak, nonatomic) IBOutlet UIView *bgView3;

@end

static NSString *ID = @"GLFirstHeartCell";
static NSString *followID = @"GLFirstFollowCell";
@implementation GLFirstPageController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addMySelfPanGesture];
    
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
    //自定义导航栏右按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH - 60, 14, 60, 30);
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [button setTitle:@"回购记录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];

}

- (GLDailyView *)dailyContentView{
    if (!_dailyContentView) {
        _dailyContentView = [[NSBundle mainBundle] loadNibNamed:@"GLDailyView" owner:nil options:nil].lastObject;
    }
    return _dailyContentView;
}
- (GLRankingView *)rankingContentView{
    if (!_rankingContentView) {
        _rankingContentView =  [[NSBundle mainBundle] loadNibNamed:@"GLRankingView" owner:nil options:nil].lastObject;
    }
    return _rankingContentView;
}
- (GLRewardView *)rewardContentView{
    if (!_rewardContentView) {
        _rewardContentView =  [[NSBundle mainBundle] loadNibNamed:@"GLRewardView" owner:nil options:nil].lastObject;
    }
    return _rewardContentView;
}
- (void)setupUI{

    
    self.sidebarView.layer.cornerRadius = 5.f;
    self.sidebarView.layer.masksToBounds = YES;
    
    self.contentView.layer.cornerRadius = 5.f;
    self.contentView.layer.masksToBounds = YES;
    
    self.dailyLabel.text = @"善心\n日值";
    self.rankingLabel.text = @"善心\n排行";
    self.rewardLabel.text = @"注册\n奖励";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeView:)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeView:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeView:)];
    [self.dailyView addGestureRecognizer:tap];
    [self.rankingView addGestureRecognizer:tap1];
    [self.rewardView addGestureRecognizer:tap2];
    
//    self.dailyContentView.frame = CGRectMake(0, 0, self.contentView.yy_width, self.contentView.yy_height);
    [self.contentView addSubview:self.dailyContentView];
    [self.contentView addSubview:self.rankingContentView];
    [self.contentView addSubview:self.rewardContentView];
    
    self.dailyContentView.alpha = 0;
    self.rankingContentView.alpha = 0;
    self.rewardContentView.alpha = 0;
    
    [self changeView:tap];
    
    self.bgView.backgroundColor = YYSRGBColor(179, 179, 179, 0.3);
    self.bgView2.backgroundColor = YYSRGBColor(179, 179, 179, 0.3);
    self.bgView3.backgroundColor = YYSRGBColor(179, 179, 179, 0.3);

}
- (void)changeView:(UITapGestureRecognizer *)tap {
    
    if (tap.view == self.dailyView) {
        if (self.dailyContentView.alpha == 0) {
            
            self.dailyContentView.alpha = 1;
            self.rankingContentView.alpha = 0;
            self.rewardContentView.alpha = 0;
            
            
            CATransition *animation = [CATransition animation];
            animation.duration = 0.6;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = @"rippleEffect";
            self.dailyContentView.frame = CGRectMake(0, 0, self.contentView.yy_width, self.contentView.yy_height);
            
            [self.dailyContentView.layer addAnimation:animation forKey:nil];
//            [UIView animateWithDuration:0.3 animations:^{
//                self.dailyContentView.frame = CGRectMake(0, 0, self.contentView.yy_width, self.contentView.yy_height);
//            }];
        }
        
    }else if(tap.view == self.rankingView){
        if (self.rankingContentView.alpha == 0) {
            
            self.dailyContentView.alpha = 0;
            self.rankingContentView.alpha = 1;
            self.rewardContentView.alpha = 0;
            
            CATransition *animation = [CATransition animation];
            animation.duration = 0.5;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = @"cube";
            self.rankingContentView.frame = CGRectMake(0, 0, self.contentView.yy_width, self.contentView.yy_height);
            
            [self.rankingContentView.layer addAnimation:animation forKey:nil];
//            self.rankingContentView.frame = CGRectMake(-SCREEN_WIDTH, 0, self.contentView.yy_width, self.contentView.yy_height);
//            [UIView animateWithDuration:0.3 animations:^{
//                self.rankingContentView.frame = CGRectMake(0, 0, self.contentView.yy_width, self.contentView.yy_height);
//            }];
        }

    }else{
        if (self.rewardContentView.alpha == 0) {
            
            self.dailyContentView.alpha = 0;
            self.rankingContentView.alpha = 0;
            self.rewardContentView.alpha = 1;
            
            CATransition *animation = [CATransition animation];
            animation.duration = 0.4;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = @"oglFlip";
            self.rewardContentView.frame = CGRectMake(0, 0, self.contentView.yy_width, self.contentView.yy_height);
            
            [self.rewardContentView.layer addAnimation:animation forKey:nil];
//            self.rewardContentView.frame = CGRectMake(-SCREEN_WIDTH, 0, self.contentView.yy_width, self.contentView.yy_height);
//            [UIView animateWithDuration:0.3 animations:^{
//                self.rewardContentView.frame = CGRectMake(0, 0, self.contentView.yy_width, self.contentView.yy_height);
//            }];
        }

    }
}

#pragma mark ------------------self.view的滑动手势
#pragma mark 添加手势
-(void)addMySelfPanGesture{
    
    //添加左右滑动手势pan
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:pan];
    
}

- (void)viewDidAppear:(BOOL)animated{
    /********用于创建pan********/    //将左右的tab页面绘制出来，并把UIView添加到当前的self.view中
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    UIViewController* v2 = [self.tabBarController.viewControllers objectAtIndex:selectedIndex+1];
    UIImage* image2 = [self imageByCropping:v2.view toRect:v2.view.bounds];
    _imageviewRight = [[UIImageView alloc] initWithImage:image2];
    _imageviewRight.frame = CGRectMake(_imageviewRight.frame.origin.x + [UIScreen mainScreen].bounds.size.width, 0, _imageviewRight.frame.size.width, _imageviewRight.frame.size.height);
    [self.view addSubview:_imageviewRight];
    /********用于创建pan********/
}

- (void)viewDidDisappear:(BOOL)animated{
    /********用于移除pan时的左右两边的view********/
    [_imageviewRight removeFromSuperview];
    /********用于移除pan时的左右两边的view********/
}

#pragma mark 绘制图片
//与pan结合使用 截图方法，图片用来做动画
-(UIImage*)imageByCropping:(UIView*)imageToCrop toRect:(CGRect)rect
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize pageSize = CGSizeMake(scale*rect.size.width, scale*rect.size.height) ;
    UIGraphicsBeginImageContext(pageSize);
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), scale, scale);
    
    CGContextRef resizedContext =UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(resizedContext,-1*rect.origin.x,-1*rect.origin.y);
    [imageToCrop.layer renderInContext:resizedContext];
    UIImage*imageOriginBackground =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageOriginBackground = [UIImage imageWithCGImage:imageOriginBackground.CGImage scale:scale orientation:UIImageOrientationUp];
    
    return imageOriginBackground;
}

#pragma mark Pan手势
- (void) handlePan:(UIPanGestureRecognizer*)recongizer{
    
    
    NSUInteger index = [self.tabBarController selectedIndex];
    
    CGPoint point = [recongizer translationInView:self.view];
    
    
    if (recongizer.view.center.x + point.x >  [UIScreen mainScreen].bounds.size.width/2) {
        recongizer.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, recongizer.view.center.y);
    } else {
        recongizer.view.center = CGPointMake(recongizer.view.center.x + point.x, recongizer.view.center.y);
    }
    [recongizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recongizer.state == UIGestureRecognizerStateEnded) {
        if (recongizer.view.center.x <= [UIScreen mainScreen].bounds.size.width && recongizer.view.center.x > 0 ) {
            [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                recongizer.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }completion:^(BOOL finished) {
                
            }];
        } else if (recongizer.view.center.x <= 0 ){
            [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                recongizer.view.center = CGPointMake(-[UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }completion:^(BOOL finished) {
                [self.tabBarController setSelectedIndex:index+1];
                recongizer.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }];
        } else {
            
        }
    }
}


@end
