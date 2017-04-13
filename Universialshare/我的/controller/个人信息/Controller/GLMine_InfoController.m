//
//  GLMine_InfoController.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLMine_InfoController.h"
#import "GLMine_InfoCell.h"
//#import "LBBaiduMapViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GLMine_InfoController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_titlesArr;
    NSMutableArray *_valuesArr;
    NSString *_address;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *codeImageV;
@property (weak, nonatomic) IBOutlet UILabel *userStyleLabel;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTop;

@property (strong, nonatomic)UIImageView *headimage;//头像
@property (strong, nonatomic)NSString *username;//用户明
@property (strong, nonatomic)NSString *adress;//店铺地址
@property (strong, nonatomic)NSString *storeType;//商家类型
@property (strong, nonatomic)NSString *shenfCode;//身份证号

@end

static NSString *ID = @"GLMine_InfoCell";

@implementation GLMine_InfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"个人资料";
    [self logoQrCode];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_InfoCell" bundle:nil] forCellReuseIdentifier:ID];
      
}
- (void)viewWillAppear:(BOOL)animated{
    [self updateInfo];
}
- (void)updateInfo{
    
    if ([[UserModel defaultUser].usrtype isEqualToString:@"6"]) {
        
        _titlesArr = @[@"头像",@"用户名",@"ID",@"店铺地址",@"商家类型",@"身份证号",@"推荐人ID",@"推荐人姓名"];
        
    }else if ([[UserModel defaultUser].usrtype isEqualToString:@"7"]) {
        
        _titlesArr = @[@"头像",@"用户名",@"ID",@"身份证号",@"推荐人ID",@"推荐人姓名"];
    }

}

//MARK: 二维码中间内置图片,可以是公司logo
-(void)logoQrCode{
    
    //二维码过滤器
    CIFilter *qrImageFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //设置过滤器默认属性 (老油条)
    [qrImageFilter setDefaults];
    
    //将字符串转换成 NSdata (虽然二维码本质上是 字符串,但是这里需要转换,不转换就崩溃)
    NSData *qrImageData = [[UserModel defaultUser].name dataUsingEncoding:NSUTF8StringEncoding];
 
    //设置过滤器的 输入值  ,KVC赋值
    [qrImageFilter setValue:qrImageData forKey:@"inputMessage"];
    
    //取出图片
    CIImage *qrImage = [qrImageFilter outputImage];
    
    //但是图片 发现有的小 (27,27),我们需要放大..我们进去CIImage 内部看属性
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    
    //转成 UI的 类型
    UIImage *qrUIImage = [UIImage imageWithCIImage:qrImage];
    
    
    //----------------给 二维码 中间增加一个 自定义图片----------------
    //开启绘图,获取图形上下文  (上下文的大小,就是二维码的大小)
    UIGraphicsBeginImageContext(qrUIImage.size);
    
    //把二维码图片画上去. (这里是以,图形上下文,左上角为 (0,0)点)
    [qrUIImage drawInRect:CGRectMake(0, 0, qrUIImage.size.width, qrUIImage.size.height)];
    
    
    //再把小图片画上去
    UIImage *sImage = [UIImage imageNamed:@""];
    
    CGFloat sImageW = 100;
    CGFloat sImageH= sImageW;
    CGFloat sImageX = (qrUIImage.size.width - sImageW) * 0.5;
    CGFloat sImgaeY = (qrUIImage.size.height - sImageH) * 0.5;
    
    [sImage drawInRect:CGRectMake(sImageX, sImgaeY, sImageW, sImageH)];
    
    //获取当前画得的这张图片
    UIImage *finalyImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();

    //设置图片
    self.codeImageV.image = finalyImage;
}
//添加地址
- (void)addAddress {
//    self.hidesBottomBarWhenPushed = YES;
//    LBBaiduMapViewController *mapVC = [[LBBaiduMapViewController alloc] init];
//    
//    mapVC.returePositon = ^(NSString *strposition,NSString *pro,NSString *city,NSString *area,CLLocationCoordinate2D coors){
//        [UserModel defaultUser].address = strposition;
//        if ([[UserModel defaultUser].userLogin integerValue] == 1) {
//            [_valuesArr replaceObjectAtIndex:4 withObject:[UserModel defaultUser].address];
//        }else if ([[UserModel defaultUser].userLogin integerValue] == 29){
//            [_valuesArr replaceObjectAtIndex:3 withObject:[UserModel defaultUser].address];
//        }
//        [usermodelachivar achive];
//        [self.tableView reloadData];
//    };
//    [self.navigationController pushViewController:mapVC animated:YES];
}

#pragma UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _titlesArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_InfoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",_titlesArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //@[@"头像",@"用户名",@"ID",@"店铺地址",@"商家类型",@"身份证号",@"推荐人ID",@"推荐人姓名"]
    if ([[UserModel defaultUser].usrtype isEqualToString:@"6"]) {
        
        if (indexPath.row == 0) {
            cell.headimage.hidden = NO;
            cell.imageW.constant = 30;
            cell.textTf.enabled = NO;
            
        }else{
            cell.headimage.hidden = YES;
            cell.imageW.constant = 0;
            
            if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 7) {
                cell.textTf.enabled = NO;
            }else{
                cell.textTf.enabled = YES;
            }
            
            __weak typeof(self) weakself = self;
            cell.returnEditing = ^(NSString *content , NSInteger index){
                
                if (index == 1) {
                    weakself.username = content;
                }else if (index == 3){
                    
                    self.adress = content;
                    
                }else if (index == 4){
                    
                    self.storeType = content;
                    
                }else if (index == 5){
                    
                    self.shenfCode = content;
                    
                }
                
            };
            
        }
        
    }else if ([[UserModel defaultUser].usrtype isEqualToString:@"7"]) {
        
        if (indexPath.row == 0) {
            cell.headimage.hidden = NO;
            cell.imageW.constant = 30;
            cell.textTf.enabled = NO;
            
        }else{
            cell.headimage.hidden = YES;
            cell.imageW.constant = 0;
            
            if (indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 5) {
                cell.textTf.enabled = NO;
            }else{
                cell.textTf.enabled = YES;
            }
            
        }
        __weak typeof(self) weakself = self;
        cell.returnEditing = ^(NSString *content , NSInteger index){
        
            if (index == 1) {
                weakself.username = content;
            }else if (index == 3){
            
                self.shenfCode = content;
            
            }
        
        };
        
        
    }
    

    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


}



@end
