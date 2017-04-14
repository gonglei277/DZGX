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

@interface GLMine_InfoController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>
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

@property (strong, nonatomic)UIImage *imagehead;//头像
@property (strong, nonatomic)NSString *username;//用户明
@property (strong, nonatomic)NSString *adress;//店铺地址
@property (strong, nonatomic)NSString *storeType;//商家类型
@property (strong, nonatomic)NSString *shenfCode;//身份证号
@property (strong, nonatomic)NSString *ID;//用户ID
@property (strong, nonatomic)NSString *recomendID;//推荐人ID
@property (strong, nonatomic)NSString *recomendName;//推荐姓名

@property (strong, nonatomic)UIButton *buttonedt;
@property (assign, nonatomic)BOOL EditBool;//判断是否可编辑

@end

static NSString *ID = @"GLMine_InfoCell";

@implementation GLMine_InfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"个人资料";
    _EditBool = NO;
    [self logoQrCode];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_InfoCell" bundle:nil] forCellReuseIdentifier:ID];
    
    _buttonedt=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 60)];
    [_buttonedt setTitle:@"编辑" forState:UIControlStateNormal];
    [_buttonedt setTitle:@"保存" forState:UIControlStateSelected];
    [_buttonedt setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
    _buttonedt.titleLabel.font = [UIFont systemFontOfSize:14];
    [_buttonedt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonedt addTarget:self action:@selector(edtingInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_buttonedt];
    
    [self updateInfo];
      
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)updateInfo{
    
    if ([[UserModel defaultUser].usrtype isEqualToString:@"6"]) {
        
        _titlesArr = @[@"头像",@"用户名",@"ID",@"店铺地址",@"商家类型",@"身份证号",@"推荐人ID",@"推荐人姓名"];
        
    }else if ([[UserModel defaultUser].usrtype isEqualToString:@"7"]) {
        
        _titlesArr = @[@"头像",@"用户名",@"ID",@"身份证号",@"推荐人ID",@"推荐人姓名"];
    }
    
  
    self.ID = [UserModel defaultUser].name;
    self.imagehead =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[UserModel defaultUser].headPic]]];
    

}
//编辑按钮
-(void)edtingInfo:(UIButton*)sender{
    sender.selected = !sender.selected;
    _EditBool = !_EditBool;
    [self.view endEditing:YES];
    
    if (sender.selected) {
        
        
    }else{//保存
    
    
    }
    
    [self.tableView reloadData];

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
    cell.index = indexPath.row;
    
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
                if (_EditBool == NO) {
                    cell.textTf.enabled = NO;
                }else{
                    cell.textTf.enabled = YES;
                }

            }
            //设置初始值
            if (indexPath.row == 1) {
                cell.textTf.text = self.username;
            }else if (indexPath.row == 2){
                cell.textTf.text = self.ID;
            }else if (indexPath.row == 3){
                cell.textTf.text = self.adress;
            }else if (indexPath.row == 4){
                cell.textTf.text = self.storeType;
            }else if (indexPath.row == 5){
                cell.textTf.text = self.shenfCode;
            }else if (indexPath.row == 6){
                cell.textTf.text = self.recomendID;
            }else if (indexPath.row == 7){
                cell.textTf.text = self.recomendName;
            }
            
            
            
            __weak typeof(self) weakself = self;
            //编辑赋值
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
            
            //弹出键盘
            cell.returnkeyBoard = ^(NSInteger index){
                
                if (index == 1) {
                    NSIndexPath *indexPath =  [NSIndexPath indexPathForRow:3 inSection:0];
                    GLMine_InfoCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
                    [cell.textTf becomeFirstResponder];
                }else if (index == 3){
                    
                    NSIndexPath *indexPath =  [NSIndexPath indexPathForRow:4 inSection:0];
                    GLMine_InfoCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
                    [cell.textTf becomeFirstResponder];
                }else if (index == 4){
                    
                    NSIndexPath *indexPath =  [NSIndexPath indexPathForRow:5 inSection:0];
                    GLMine_InfoCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
                    [cell.textTf becomeFirstResponder];
                }else if (index == 5){
                    [weakself.view endEditing:YES];
                }
                
                
            };
            
            
        }
        
    }else if ([[UserModel defaultUser].usrtype isEqualToString:@"7"]) {
        
        if (indexPath.row == 0) {
            cell.headimage.hidden = NO;
            cell.imageW.constant = 30;
            cell.textTf.enabled = NO;
            cell.headimage.image = self.imagehead;
            if (!cell.headimage.image) {
                cell.headimage.image = [UIImage imageNamed:@"mine_head"];
            }
            
        }else{
            cell.headimage.hidden = YES;
            cell.imageW.constant = 0;
            
            if (indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 5) {
                cell.textTf.enabled = NO;
            }else{
                if (_EditBool == NO) {
                    cell.textTf.enabled = NO;
                }else{
                    cell.textTf.enabled = YES;
                }
            }
            
        }
        
        //设置初始值
        if (indexPath.row == 1) {
            cell.textTf.text = self.username;
        }else if (indexPath.row == 2){
            cell.textTf.text = self.ID;
        }else if (indexPath.row == 3){
            cell.textTf.text = self.shenfCode;
        }else if (indexPath.row == 4){
            cell.textTf.text = self.recomendID;
        }else if (indexPath.row == 5){
            cell.textTf.text = self.recomendName;
        }
        
        
        __weak typeof(self) weakself = self;
        // 赋值
        cell.returnEditing = ^(NSString *content , NSInteger index){
        
            if (index == 1) {
                weakself.username = content;
            }else if (index == 3){
            
                self.shenfCode = content;
            
            }
        
        };
        
        //弹出键盘
        cell.returnkeyBoard = ^(NSInteger index){

            if (index == 1) {
                NSIndexPath *indexPath =  [NSIndexPath indexPathForRow:3 inSection:0];
                GLMine_InfoCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
                [cell.textTf becomeFirstResponder];
            }else if (index == 3){
                
                [weakself.view endEditing:YES];
            }
            
            
        };

        
        
    }
    

    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"去相册选择",@"用相机拍照", nil];
        [actionSheet showInView:self.view];
    }

    
    if ([[UserModel defaultUser].usrtype isEqualToString:@"6"]) {
        
        if (indexPath.row == 3) {//选择地址
//                self.hidesBottomBarWhenPushed = YES;
//                LBBaiduMapViewController *mapVC = [[LBBaiduMapViewController alloc] init];
//                mapVC.returePositon = ^(NSString *strposition,NSString *pro,NSString *city,NSString *area,CLLocationCoordinate2D coors){
//                    self.adress = strposition;
//                    [self.tableView reloadData];
//                };
                //[self.navigationController pushViewController:mapVC animated:YES];
        }
        
    }else if ([[UserModel defaultUser].usrtype isEqualToString:@"7"]) {
        
        
    }

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            [self getpicture];//获取相册
        }break;
            
        case 1:{
            [self getcamera];//获取照相机
        }break;
        default:
            break;
    }
}

-(void)getpicture{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //    // 设置选择后的图片可以被编辑
    //    picker.allowsEditing = YES;
    //    [self presentViewController:picker animated:YES completion:nil];
    //1.获取媒体支持格式
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.mediaTypes = @[mediaTypes[0]];
    //5.其他配置
    //allowsEditing是否允许编辑，如果值为no，选择照片之后就不会进入编辑界面
    picker.allowsEditing = YES;
    //6.推送
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)getcamera{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        // 设置拍照后的图片可以被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        // 先把图片转成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil) {
            
            data = UIImageJPEGRepresentation(image, 0.1);
        }else {
            data=    UIImageJPEGRepresentation(image, 0.1);
        }
        //#warning 这里来做操作，提交的时候要上传
        // 图片保存的路径
        self.imagehead = [UIImage imageWithData:data];
        [self.tableView reloadData];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
}


@end
