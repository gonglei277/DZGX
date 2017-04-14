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

#import "GLFirstPageDailyModel.h"
#import "GLFirstPageRankingModel.h"

#import "LBUserKonwViewController.h"
#import "LBMoreOperateView.h"
#import "LBMerchantcreditViewController.h"
#import "LBConsumptionSeriesViewController.h"

//公告弹出框
#import "LBHomepopinfoView.h"


@interface GLFirstPageController ()

{
    UIImageView *_imageviewLeft , *_imageviewRight;
    
    LoadWaitView *_loadV;
    
}
@property (weak, nonatomic) IBOutlet UIButton *head_iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalSumLabel;

@property (weak, nonatomic) IBOutlet UIView *sidebarView;

@property (nonatomic, strong)GLDailyView *dailyContentView;
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

@property (strong, nonatomic)UIView *maskView;//遮罩
@property (strong, nonatomic)LBMoreOperateView *moreOperateView;//遮罩

@property (nonatomic, strong)NSMutableArray *dailyModels;
@property (nonatomic, strong)NSMutableArray *rankingModels;
@property (nonatomic, strong)NSMutableArray *rewardModels;

@property (strong, nonatomic)LBHomepopinfoView *homepopinfoView;
@property (strong, nonatomic)UIView *homepopinfoViewmask;

@end

static NSString *ID = @"GLFirstHeartCell";
static NSString *followID = @"GLFirstFollowCell";
@implementation GLFirstPageController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addMySelfPanGesture];
    

//    [self initInterDataSorceinfomessage];
    [self setupUI];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)setupUI{

    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    
    
    UITapGestureRecognizer *tapgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgestrueMsakView)];
    [self.maskView addGestureRecognizer:tapgesture];
    //点击用户须知
    [self.moreOperateView.userKnowBt addTarget:self action:@selector(userkonwbutton) forControlEvents:UIControlEventTouchUpInside];
    //点击运营公告
    [self.moreOperateView.OperationBt addTarget:self action:@selector(Operationbutton) forControlEvents:UIControlEventTouchUpInside];

    //点击消费系列
    [self.moreOperateView.consumptionBt addTarget:self action:@selector(consumptionbutton) forControlEvents:UIControlEventTouchUpInside];
    
    // 判断是否登录
    if ([UserModel defaultUser].loginstatus == YES) {
        NSString *imageName = [UserModel defaultUser].headPic;
        [self.head_iconBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        if (self.head_iconBtn.imageView.image == nil) {
            [self.head_iconBtn setImage:[UIImage imageNamed:@"mine_head"] forState:UIControlStateNormal];
        }
    }else{
//        [self.head_iconBtn setImage:[UIImage imageNamed:@"mine_head"] forState:UIControlStateNormal];
        [self.head_iconBtn setTitle:@"登录" forState:UIControlStateNormal];
    }

}

- (IBAction)head_iconClick:(id)sender {
    
    
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

        }
        
    }else if(tap.view == self.rankingView){
        if (self.rankingContentView.alpha == 0) {
            
            self.dailyContentView.alpha = 0;
            self.rankingContentView.alpha = 1;
            self.rewardContentView.alpha = 0;
            
            CATransition *animation = [CATransition animation];
            animation.duration = 0.5;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = @"rippleEffect";
            self.rankingContentView.frame = CGRectMake(0, 0, self.contentView.yy_width, self.contentView.yy_height);
            
            [self.rankingContentView.layer addAnimation:animation forKey:nil];

        }

    }else{
        if (self.rewardContentView.alpha == 0) {
            
            self.dailyContentView.alpha = 0;
            self.rankingContentView.alpha = 0;
            self.rewardContentView.alpha = 1;
            
            CATransition *animation = [CATransition animation];
            animation.duration = 0.5;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = @"rippleEffect";
            self.rewardContentView.frame = CGRectMake(0, 0, self.contentView.yy_width, self.contentView.yy_height);
            
            [self.rewardContentView.layer addAnimation:animation forKey:nil];

        }

    }
}
-(void)initInterDataSorceinfomessage{
    
    [NetworkManager requestPOSTWithURLStr:@"index/notice" paramDic:nil finish:^(id responseObject) {
        NSLog(@"%@",responseObject);
//        [_loadV removeFromSuperview];
        if ([responseObject[@"code"] integerValue] == 1) {
            
            NSString *strtitle=[NSString stringWithFormat:@"%@",responseObject[@"data"][@"title"]];
            NSString *strcontent=[NSString stringWithFormat:@"%@",responseObject[@"data"][@"content"]];
            NSString *strtime=[NSString stringWithFormat:@"%@",responseObject[@"data"][@"release_time"]];
            
            if ([strtitle rangeOfString:@"null"].location == NSNotFound) {
                self.homepopinfoView.titlename.text = strtitle;
            }else{
                self.homepopinfoView.titlename.text = @"";
            }
            if ([strcontent rangeOfString:@"null"].location == NSNotFound) {
                 self.homepopinfoView.infoLb.attributedText = [self strToAttriWithStr:strcontent];
//                self.homepopinfoView.infoLb.attributedText
                
//                NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:strcontent];
//                NSLog(@"attributedText = %@",attributedText);
            }else{
                self.homepopinfoView.infoLb.text = @"";
            }
            if ([strtime rangeOfString:@"null"].location == NSNotFound) {
                self.homepopinfoView.timeLb.text = strtime;
            }else{
                
                self.homepopinfoView.timeLb.text = @"";
            }

            if (self.homepopinfoView.infoLb.text.length<=1) {
                return ;
            }
            
            CGRect sizetitle=[self.homepopinfoView.titlename.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
            
            CGRect sizecontent=[self.homepopinfoView.infoLb.attributedText  boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
            
//            NSLog(@"%@",NSStringFromCGRect(sizecontent));
            
            if ((110 + sizetitle.size.height + sizecontent.size.height) >= ((SCREEN_HEIGHT/2) - 30)) {
                
                self.homepopinfoView.frame = CGRectMake(20, (SCREEN_HEIGHT - ((SCREEN_HEIGHT/2) - 30)) / 2, SCREEN_WIDTH - 40, ((SCREEN_HEIGHT/2) - 30));
                
                self.homepopinfoView.scrollViewH.constant = (SCREEN_HEIGHT/2) - 105;
                self.homepopinfoView.contentW.constant = SCREEN_WIDTH - 80;
                self.homepopinfoView.contentH.constant = sizetitle.size.height + sizecontent.size.height + 20;
                
            }else{
                
                self.homepopinfoView.frame = CGRectMake(20, (SCREEN_HEIGHT - (110 + sizetitle.size.height + sizecontent.size.height)) / 2, SCREEN_WIDTH - 40, 110 + sizetitle.size.height + sizecontent.size.height);
                
                self.homepopinfoView.scrollViewH.constant = 110 + sizetitle.size.height + sizecontent.size.height - 80;
                self.homepopinfoView.scrollView.scrollEnabled = NO;
                self.homepopinfoView.contentW.constant = SCREEN_WIDTH - 80;
                self.homepopinfoView.contentH.constant = 110 + sizetitle.size.height + sizecontent.size.height - 80;
                
            }
            
            
            [self.view addSubview:self.homepopinfoViewmask];
            [self.homepopinfoViewmask addSubview:self.homepopinfoView];
            
        }

    } enError:^(NSError *error) {
        NSLog(@"%@",error);
    }];
   
}
//关闭
-(void)closeinfobutton{
    //
    [UIView animateWithDuration:0.5 animations:^{
        
        self.homepopinfoViewmask.transform = CGAffineTransformMakeScale(0.07, 0.07);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.homepopinfoViewmask.center = CGPointMake(SCREEN_WIDTH - 30,30);
        } completion:^(BOOL finished) {
            [self.homepopinfoViewmask removeFromSuperview];
        }];
    }];
    
}
-(UIView*)homepopinfoViewmask{
    if (!_homepopinfoViewmask) {
        _homepopinfoViewmask=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _homepopinfoViewmask.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    }
    
    return _homepopinfoViewmask;
    
}
-(LBHomepopinfoView*)homepopinfoView{
    if (!_homepopinfoView) {
        _homepopinfoView=[[NSBundle mainBundle]loadNibNamed:@"LBHomepopinfoView" owner:self options:nil].firstObject;
        _homepopinfoView.layer.cornerRadius=5;
        _homepopinfoView.clipsToBounds=YES;
        _homepopinfoView.closeBt.layer.cornerRadius=5;
        _homepopinfoView.clipsToBounds=YES;
        [_homepopinfoView.closeBt addTarget:self action:@selector(closeinfobutton) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _homepopinfoView;
}

/**
 *  字符串转富文本
 */
- (NSMutableAttributedString *)strToAttriWithStr:(NSString *)htmlStr{
    
    NSMutableAttributedString *AttributedString=[[NSMutableAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding]
                                                                                        options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                                             documentAttributes:nil
                                                                                          error:nil];
    
    [AttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, [AttributedString length])];//设置字体大小
    
    return AttributedString;
}

- (IBAction)showMoreButton:(UIButton *)sender {
    
    [self.view addSubview:self.maskView];
    [self.maskView addSubview:self.moreOperateView];
    [UIView animateWithDuration:0.3 animations:^{
        self.moreOperateView.frame=CGRectMake(SCREEN_WIDTH-65, 64, 65, 200);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 点击更多操作

-(void)userkonwbutton{
    self.hidesBottomBarWhenPushed = YES;
    LBUserKonwViewController *vc=[[LBUserKonwViewController alloc]init];
    vc.titlestr=@"用户须知";
    vc.indexType=@"2";
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

-(void)Operationbutton{
    
    self.hidesBottomBarWhenPushed = YES;
    LBUserKonwViewController *vc=[[LBUserKonwViewController alloc]init];
    vc.titlestr=@"运营.公告";
    vc.indexType=@"3";
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

//-(void)merchantbutton{
//    
//    self.hidesBottomBarWhenPushed = YES;
//    LBMerchantcreditViewController *vc=[[LBMerchantcreditViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
//    
//}

-(void)consumptionbutton{
    
    self.hidesBottomBarWhenPushed = YES;
    LBConsumptionSeriesViewController *vc=[[LBConsumptionSeriesViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
   
    self.hidesBottomBarWhenPushed = NO;
    
}


-(UIView*)maskView{
    
    if (!_maskView) {
        _maskView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor=[UIColor clearColor];
    }
    
    return _maskView;
    
}

-(LBMoreOperateView*)moreOperateView{
    
    if (!_moreOperateView) {
        _moreOperateView=[[NSBundle mainBundle]loadNibNamed:@"LBMoreOperateView" owner:self options:nil].firstObject;
        _moreOperateView.frame=CGRectMake(SCREEN_WIDTH+65, 64, 65, 200);
    }
    return _moreOperateView;
}



- (NSMutableArray *)dailyModels{
    if (!_dailyModels) {
        _dailyModels = [NSMutableArray array];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"type"] = @"1";
        
         _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
        [NetworkManager requestPOSTWithURLStr:@"index/index" paramDic:dic finish:^(id responseObject) {
            [_loadV removeFromSuperview];
            if ([responseObject[@"code"] intValue] == 1) {
                
                NSArray *dicArr = responseObject[@"data"][@"head"];
                for (int i = 0; i < dicArr.count; i ++) {
                    GLFirstPageDailyModel *model = [[GLFirstPageDailyModel alloc] init];
                    model = [GLFirstPageDailyModel mj_objectWithKeyValues:dicArr[i]];
                    [_dailyModels addObject:model];
                    
                }
                CGFloat sum = [responseObject[@"zjz"] floatValue];
                NSString *sumStr = [NSString stringWithFormat:@"%.2f万",sum/10000];
                _totalSumLabel.text = [NSString stringWithFormat:@"全联盟昨日消费:%@元",sumStr];
            }
            
            [_dailyContentView.tableView reloadData];
        } enError:^(NSError *error) {
            [_loadV removeFromSuperview];
            NSLog(@"%@",error);
            
        }];
    }
    return _dailyModels;
}
- (NSMutableArray *)rankingModels{
    
    if (!_rankingModels) {
        
        _rankingModels = [NSMutableArray array];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"type"] = @"2";
//         _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
        [NetworkManager requestPOSTWithURLStr:@"index/index" paramDic:dic finish:^(id responseObject) {
            [_loadV removeFromSuperview];
             if ([responseObject[@"code"] intValue] == 1) {
            NSArray *dicArr = responseObject[@"data"][@"head2"];
            for (int i = 0; i < dicArr.count; i ++) {
                
                GLFirstPageRankingModel *model = [GLFirstPageRankingModel mj_objectWithKeyValues:dicArr[i]];
                [_rankingModels addObject:model];
                
                }
             }
            
            [_rankingContentView.tableView reloadData];
        } enError:^(NSError *error) {
            [_loadV removeFromSuperview];
            NSLog(@"%@",error);
            
        }];
    }
    return _rankingModels;
}
- (GLDailyView *)dailyContentView{
    if (!_dailyContentView) {
        _dailyContentView = [[NSBundle mainBundle] loadNibNamed:@"GLDailyView" owner:nil options:nil].lastObject;
        _dailyContentView.models = self.dailyModels;
        
    }
    return _dailyContentView;
}
- (GLRankingView *)rankingContentView{
    if (!_rankingContentView) {
        _rankingContentView =  [[NSBundle mainBundle] loadNibNamed:@"GLRankingView" owner:nil options:nil].lastObject;
        _rankingContentView.models = self.rankingModels;
    }
    return _rankingContentView;
}
- (GLRewardView *)rewardContentView{
    if (!_rewardContentView) {
        _rewardContentView =  [[NSBundle mainBundle] loadNibNamed:@"GLRewardView" owner:nil options:nil].lastObject;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"type"] = @"3";
//         _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
        [NetworkManager requestPOSTWithURLStr:@"index/index" paramDic:dic finish:^(id responseObject) {
            //            NSLog(@"%@",responseObject);
            [_loadV removeFromSuperview];
            if ([responseObject[@"code"] intValue] == 1) {
                
                _rewardContentView.label.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"head3"][@"djz"]];
                _rewardContentView.label2.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"head3"][@"zjz"]];
                _rewardContentView.label3.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"head3"][@"ltime"]];
                _rewardContentView.label4.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"head3"][@"money"]];
                _rewardContentView.label5.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"head3"][@"sh_sum"]];
                _rewardContentView.label6.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"head3"][@"people"]];
                
                _rewardContentView.timeLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"head3"][@"time"]];
            }
            
        } enError:^(NSError *error) {
            [_loadV removeFromSuperview];
            NSLog(@"%@",error);
            
        }];
        
    }
    return _rewardContentView;
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
            [UIView animateWithDuration:timea delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                recongizer.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }completion:^(BOOL finished) {
                
            }];
        } else if (recongizer.view.center.x <= 0 ){
            [UIView animateWithDuration:timea delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                recongizer.view.center = CGPointMake(-[UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }completion:^(BOOL finished) {
                [self.tabBarController setSelectedIndex:index+1];
                recongizer.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }];
        } else {
            
        }
    }
}

-(void)tapgestrueMsakView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.moreOperateView.frame=CGRectMake(SCREEN_WIDTH + 65, 64, 65, 200);
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
    }];
}


@end
