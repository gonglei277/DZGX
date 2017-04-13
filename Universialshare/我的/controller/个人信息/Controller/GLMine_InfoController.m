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

@end

static NSString *ID = @"GLMine_InfoCell";

@implementation GLMine_InfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人资料";
    [self logoQrCode];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

//    [self updateInfo];
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_InfoCell" bundle:nil] forCellReuseIdentifier:ID];
      
}
- (void)viewWillAppear:(BOOL)animated{
    [self updateInfo];
}
- (void)updateInfo{
    
//    if ([[UserModel defaultUser].usernumber rangeOfString:@"null"].location != NSNotFound){
//        [UserModel defaultUser].usernumber = @"";
//    }
//    if ([[UserModel defaultUser].picture rangeOfString:@"null"].location != NSNotFound){
//        [UserModel defaultUser].picture = @"";
//    }
//    if ([[UserModel defaultUser].username rangeOfString:@"null"].location != NSNotFound){
//        [UserModel defaultUser].username = @"";
//    }
//    if ([[UserModel defaultUser].realname rangeOfString:@"null"].location != NSNotFound){
//        [UserModel defaultUser].realname = @"";
//    }
//    if ([[UserModel defaultUser].address rangeOfString:@"null"].location != NSNotFound){
//        [UserModel defaultUser].address = @"";
//    }
//    if ([[UserModel defaultUser].idcard rangeOfString:@"null"].location != NSNotFound){
//        [UserModel defaultUser].idcard = @"0";
//    }
//    if ([[UserModel defaultUser].referrer_name rangeOfString:@"null"].location != NSNotFound){
//        [UserModel defaultUser].referrer_name = @"";
//    }
//    if ([[UserModel defaultUser].referrer_usernumber rangeOfString:@"null"].location != NSNotFound){
//        [UserModel defaultUser].referrer_usernumber = @"";
//    }
//    if ([[UserModel defaultUser].industry rangeOfString:@"null"].location != NSNotFound){
//        [UserModel defaultUser].industry = @"";
//    }
//    if ([[UserModel defaultUser].shopname rangeOfString:@"null"].location != NSNotFound){
//        [UserModel defaultUser].shopname = @"";
//    }
//    if ([[UserModel defaultUser].principal rangeOfString:@"null"].location != NSNotFound || [[UserModel defaultUser].principal isEqualToString:@"0"]) {
//        [UserModel defaultUser].principal = @"";
//    }
//    if ([[UserModel defaultUser].size rangeOfString:@"null"].location != NSNotFound||[[UserModel defaultUser].size isEqualToString:@"0"]) {
//        [UserModel defaultUser].size = @"0人";
//    }
//
//    if ([[UserModel defaultUser].userLogin integerValue] == 1) {
//
//        _titlesArr = @[@"志愿者ID",@"我的头像",@"用户名",@"姓名",@"地区",@"身份证号",@"推荐人姓名",@"推荐人ID"];
//        
//        _valuesArr = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%@",[UserModel defaultUser].usernumber],
//                      [NSString stringWithFormat:@"%@",[UserModel defaultUser].picture],
//                      [NSString stringWithFormat:@"%@",[UserModel defaultUser].username],
//                      [NSString stringWithFormat:@"%@",[UserModel defaultUser].realname],
//                      [NSString stringWithFormat:@"%@",[UserModel defaultUser].address],
//                      [NSString stringWithFormat:@"%@",[UserModel defaultUser].idcard],
//                      [NSString stringWithFormat:@"%@",[UserModel defaultUser].referrer_name],
//                      [NSString stringWithFormat:@"%@",[UserModel defaultUser].referrer_usernumber], nil];
//    }else{
//        self.tableViewTop.constant = -CGRectGetMaxY(self.myLabel.frame) + 74;
//        
//        self.codeImageV.hidden = YES;
//        self.userStyleLabel.hidden = YES;
//        self.myLabel.hidden = YES;
//        
//        
//        _titlesArr = @[@"我的头像",@"用户名",@"ID",@"商家地址",@"行业类别",@"规模",@"负责人",@"店铺名"];
//        
//        _valuesArr = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%@",[UserModel defaultUser].picture],
//                      [NSString stringWithFormat:@"%@",[UserModel defaultUser].username],
//                      [NSString stringWithFormat:@"%@",[UserModel defaultUser].usernumber],
//                      [NSString stringWithFormat:@"%@",[UserModel defaultUser].address],
//                      [NSString stringWithFormat:@"%@",[UserModel defaultUser].industry],
//                      [NSString stringWithFormat:@"%@",[UserModel defaultUser].size],
//                      [NSString stringWithFormat:@"%@",[UserModel defaultUser].principal],
//                      [NSString stringWithFormat:@"%@",[UserModel defaultUser].shopname],nil
//                      ];
//    }
//    NSString *userType;
//    if([[UserModel defaultUser].userLogin integerValue] == 1){
//        userType = @"志愿者";
//    }else {
//        userType = @"商家";
//    }
//    self.userStyleLabel.text = [NSString stringWithFormat:@"%@信息",userType];
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
    UIImage *sImage = [UIImage imageNamed:@"mine_logo"];
    
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
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if ([[UserModel defaultUser].userLogin integerValue] == 1) {
//        cell.addBtn.hidden = YES;
//        if (indexPath.row == 1) {
//            cell.imageV.hidden = NO;
//            [cell.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_valuesArr[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"mine_head"]];
//            cell.valueLabel.hidden = YES;
//            
//        }else{
//            cell.imageV.hidden = YES;
//            cell.valueLabel.hidden = NO;
//        }
//
//    }else {
//        if (indexPath.row == 0) {
////            cell.addBtn.hidden = YES;
//            cell.imageV.hidden = NO;
//            cell.valueLabel.hidden = YES;
//            [cell.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_valuesArr[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"mine_head"]];
//            //            cell.backgroundColor= [UIColor redColor];
//        }else if (indexPath.row == 3) {
////            cell.addBtn.hidden = YES;
//            cell.imageV.hidden = YES;
//            cell.valueLabel.hidden = NO;
//            
////            [cell.addBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
//                cell.valueLabel.textAlignment = NSTextAlignmentLeft;
//            cell.valueLabelLeftConstraint.constant = 45;
//            
//        }else {
////            cell.addBtn.hidden = YES;
//            cell.imageV.hidden = YES;
//            cell.valueLabel.hidden = NO;
//
//        }
//    }
//    cell.titleLabel.text = _titlesArr[indexPath.row];
//    cell.valueLabel.text = _valuesArr[indexPath.row];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if ([[UserModel defaultUser].userLogin integerValue] == 1) {
//        
//        if (indexPath.row == 1) {
//            return 70;
//        }
//    }else{
//        if (indexPath.row == 0) {
//            return 70;
//        }
//    }
    
    return 50;
}
@end
