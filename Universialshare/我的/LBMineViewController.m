//
//  LBMineViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineViewController.h"
#import "MineCollectionHeaderV.h"
#import "LBMineCenterCollectionViewCell.h"
#import "UIButton+SetEdgeInsets.h"
#import "LBSetUpViewController.h"
#import "LBMineMessageViewController.h"
#import "LBMineCenterReceivingGoodsViewController.h"
#import "LBMineCenterMyOrderViewController.h"
#import "LBMineCenterMyBalanceViewController.h"

#import "GLMyHeartController.h"
#import "GLDirectDonationController.h"
#import "GLMine_MyBeansController.h"
#import "GLBuyBackController.h"
#import "GLDonationController.h"
#import "GLRecommendController.h"
#import "GLMine_InfoController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GLNoneOfDonationController.h"

@interface LBMineViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UIImageView *_imageviewLeft;
}

@property(nonatomic,strong)UICollectionView *collectionV;
@property(nonatomic,strong) MineCollectionHeaderV *headview;
@property(nonatomic,strong)NSArray *titlearr;
@property(nonatomic,strong)NSArray *imageArr;

@end

@implementation LBMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addMySelfPanGesture];
    
    // 注册表头
    [self.collectionV registerClass:[MineCollectionHeaderV class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MineCollectionHeaderV"];
    [self.collectionV registerNib:[UINib nibWithNibName:@"LBMineCenterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LBMineCenterCollectionViewCell"];
    
    [self.view addSubview:self.collectionV];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
     self.navigationController.navigationBar.hidden = YES;


}
-(void)pushToInfoVC{
    self.hidesBottomBarWhenPushed=YES;
    GLMine_InfoController *infoVC = [[GLMine_InfoController alloc] init];
    [self.navigationController pushViewController:infoVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.titlearr.count;
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LBMineCenterCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"LBMineCenterCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    
    [cell.button setImage:[UIImage imageNamed:self.imageArr[indexPath.row]] forState:UIControlStateNormal];
    [cell.button setTitle:[NSString stringWithFormat:@"%@",self.titlearr[indexPath.row]] forState:UIControlStateNormal];
    
    [cell.button verticalCenterImageAndTitle:15];
   
    return cell;
    
}

//UICollectionViewCell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH-3)/3, ((SCREEN_WIDTH-3)/3)+13);

    
}

//选择cell时
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            self.hidesBottomBarWhenPushed=YES;
            
            if ([[UserModel defaultUser].groupId isEqualToString:OrdinaryUser]) {
                
                GLMyHeartController *vc=[[GLMyHeartController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                GLNoneOfDonationController *vc = [[GLNoneOfDonationController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            self.hidesBottomBarWhenPushed=NO;
           
        }
        
            break;
        case 1:
        {
            self.hidesBottomBarWhenPushed=YES;
            GLDirectDonationController *vc=[[GLDirectDonationController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
            
            break;
        case 2:
        {
            self.hidesBottomBarWhenPushed=YES;
            GLMine_MyBeansController *vc=[[GLMine_MyBeansController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed=NO;
            
        }
            break;
        case 3:
        {
            self.hidesBottomBarWhenPushed=YES;
            GLBuyBackController *vc=[[GLBuyBackController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
            break;
        case 4:
        {
            self.hidesBottomBarWhenPushed=YES;
            GLDonationController *vc=[[GLDonationController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
            break;
        case 5:
        {
            self.hidesBottomBarWhenPushed=YES;
            GLRecommendController *vc=[[GLRecommendController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
            break;
        case 6:
            
        {
            self.hidesBottomBarWhenPushed=YES;
            LBMineCenterMyBalanceViewController *vc=[[LBMineCenterMyBalanceViewController alloc]init];
            vc.vcIndex = 1;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed=NO;
            
        }
            
            break;
        case 7:
        {
            {
                self.hidesBottomBarWhenPushed=YES;
                LBMineCenterMyBalanceViewController *vc=[[LBMineCenterMyBalanceViewController alloc]init];
                vc.vcIndex = 2;
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed=NO;
                
            }
        
        }
            break;
        case 8:
        {
            self.hidesBottomBarWhenPushed=YES;
            LBMineCenterMyBalanceViewController *vc=[[LBMineCenterMyBalanceViewController alloc]init];
            vc.vcIndex = 3;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed=NO;
            
        }
            break;
       
            
        default:
            break;
    }
}
-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if (!_headview) {
        _headview = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                       withReuseIdentifier:@"MineCollectionHeaderV"
                                                              forIndexPath:indexPath];
        
        //待收货
        __weak typeof(self)  weakself = self;
        _headview.returnCollectinGoodsBt = ^(){
            
            weakself.hidesBottomBarWhenPushed=YES;
            LBMineCenterReceivingGoodsViewController *vc=[[LBMineCenterReceivingGoodsViewController alloc]init];
            [weakself.navigationController pushViewController:vc animated:YES];
            weakself.hidesBottomBarWhenPushed=NO;
            
        };
        //    购物车
        _headview.returnShoppingCartBt = ^(){
            

        };
        //    订单
        _headview.returnOrderBt = ^(){
            
            weakself.hidesBottomBarWhenPushed=YES;
            LBMineCenterMyOrderViewController *vc=[[LBMineCenterMyOrderViewController alloc]init];
            [weakself.navigationController pushViewController:vc animated:YES];
            weakself.hidesBottomBarWhenPushed=NO;

        };
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToInfoVC)];
        [_headview.headimage addGestureRecognizer:tap];
        
        [_headview.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[UserModel defaultUser].headPic]]];
        
        if (!_headview.headimage.image) {
            
            _headview.headimage.image = [UIImage imageNamed:@"mine_head"];
        }
        
        _headview.namelebel.text = [NSString stringWithFormat:@"%@",[UserModel defaultUser].name];
        
        if (_headview.namelebel.text.length <= 0) {
            
            _headview.namelebel.text = @"用户名";
        }
    }
    
    return _headview;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 1, 0);
}



#pragma mark ---- button
//设置
- (IBAction)setupevent:(UIButton *)sender {
    
    self.hidesBottomBarWhenPushed=YES;
    LBSetUpViewController *vc=[[LBSetUpViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

//消息
- (IBAction)messagebutton:(UIButton *)sender {
    
    self.hidesBottomBarWhenPushed=YES;
    LBMineMessageViewController *vc=[[LBMineMessageViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
}



#pragma mark 懒加载

-(UICollectionView *)collectionV{

    if (!_collectionV) {
        
         UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
         [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 10, 0)];
        [flowLayout setHeaderReferenceSize:CGSizeMake(SCREEN_WIDTH, (SCREEN_HEIGHT - 64) * 0.4)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [flowLayout setMinimumInteritemSpacing:0.0];
        [flowLayout setMinimumLineSpacing:0.0];
        
        _collectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64 - 50)collectionViewLayout:flowLayout];
        _collectionV.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _collectionV.alwaysBounceVertical = YES;
        _collectionV.showsVerticalScrollIndicator = NO;
        //设置代理
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
    }
    return _collectionV;
}

-(NSArray*)titlearr{

    if (!_titlearr) {
        if ([[UserModel defaultUser].usrtype isEqualToString:Retailer]) {
            _titlearr=[NSArray arrayWithObjects:@"米粒",@"米仓",@"米袋",@"米券",@"转赠",@"我要推荐",@"营业额",@"我的返利",@"我的积分", nil];
        }else if ([[UserModel defaultUser].usrtype isEqualToString:OrdinaryUser]) {
           _titlearr=[NSArray arrayWithObjects:@"米粒",@"米仓",@"米袋",@"米券",@"转赠",@"我要推荐",@"我的余额",@"我的返利",@"我的积分", nil];
        }
    }
    return _titlearr;

}

-(NSArray*)imageArr{

    if (!_imageArr) {
        _imageArr=[NSArray arrayWithObjects:@"圆角矩形-2（合并）",@"直捐",@"我的信使豆",@"回购",@"转赠",@"我要推荐",@"余额",@"我的返利",@"我的积分", nil];
    }
    return _imageArr;

}

#pragma mark ------------------self.view的滑动手势
#pragma mark 添加手势
-(void)addMySelfPanGesture{
    
    //添加左右滑动手势pan
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:pan];
    
}


- (void)viewDidAppear:(BOOL)animated{
    /********用于创建pan********/       //将左右的tab页面绘制出来，并把UIView添加到当前的self.view中
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    UIViewController* v1 = [self.tabBarController.viewControllers objectAtIndex:selectedIndex-1];
    UIImage* image1 = [self imageByCropping:v1.view toRect:v1.view.bounds];
    _imageviewLeft = [[UIImageView alloc] initWithImage:image1];
    _imageviewLeft.frame = CGRectMake(_imageviewLeft.frame.origin.x - [UIScreen mainScreen].bounds.size.width, _imageviewLeft.frame.origin.y , _imageviewLeft.frame.size.width, _imageviewLeft.frame.size.height);
    [self.view addSubview:_imageviewLeft];
    
    /********用于创建pan********/
}

- (void)viewDidDisappear:(BOOL)animated{
    /********用于移除pan时的左右两边的view********/
    [_imageviewLeft removeFromSuperview];
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
    
    
    if (recongizer.view.center.x + point.x <  [UIScreen mainScreen].bounds.size.width/2) {
        recongizer.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, recongizer.view.center.y);
    } else {
        recongizer.view.center = CGPointMake(recongizer.view.center.x + point.x, recongizer.view.center.y);
    }
    [recongizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recongizer.state == UIGestureRecognizerStateEnded) {
        if (recongizer.view.center.x <= [UIScreen mainScreen].bounds.size.width && recongizer.view.center.x >= 0 ) {
            [UIView animateWithDuration:timea delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                recongizer.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }completion:^(BOOL finished) {
                
            }];
        } else if (recongizer.view.center.x <= 0 ){
            
        } else {
            [UIView animateWithDuration:timea delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                recongizer.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width*1.5 ,[UIScreen mainScreen].bounds.size.height/2);
            }completion:^(BOOL finished) {
                [self.tabBarController setSelectedIndex:index-1];
                recongizer.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }];
        }
    }
}


@end
