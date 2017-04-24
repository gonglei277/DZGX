//
//  LBMerchantSubmissionFourViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMerchantSubmissionFourViewController.h"

@interface LBMerchantSubmissionFourViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UIImageView *handImage;
@property (weak, nonatomic) IBOutlet UIImageView *positiveImage;
@property (weak, nonatomic) IBOutlet UIImageView *otherSideImage;
@property (weak, nonatomic) IBOutlet UIImageView *licenseImage;
@property (weak, nonatomic) IBOutlet UIImageView *undertakingOne;
@property (weak, nonatomic) IBOutlet UIImageView *undertakingTwo;
@property (weak, nonatomic) IBOutlet UIImageView *doorplateImage;
@property (weak, nonatomic) IBOutlet UIImageView *DoorplateOneimage;
@property (weak, nonatomic) IBOutlet UIImageView *InteriorImage;
@property (weak, nonatomic) IBOutlet UIImageView *InteriorOneImage;
@property (weak, nonatomic) IBOutlet UIView *baseview;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentH;

@property (assign, nonatomic)NSInteger tapIndex;//判断点击的是那个图片

@end

@implementation LBMerchantSubmissionFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
//手持身份证
- (IBAction)tapgesturehandimage:(UITapGestureRecognizer *)sender {
    _tapIndex = 1;
    
    [self tapgesturephotoOrCamera];
    
}
// 身份证正面照
- (IBAction)tapgesturepositiveimage:(UITapGestureRecognizer *)sender {
    _tapIndex = 2;
    [self tapgesturephotoOrCamera];
    
}
//身份证反面照
- (IBAction)tapgestureothersideimage:(UITapGestureRecognizer *)sender {
    _tapIndex = 3;
    [self tapgesturephotoOrCamera];
    
}

//点击营业执照
- (IBAction)tapgestureBusinesslicense:(UITapGestureRecognizer *)sender {
    _tapIndex = 4;
    [self tapgesturephotoOrCamera];
    
    
}
//商家承诺书
- (IBAction)tapgestureBusinessUndertaking:(UITapGestureRecognizer *)sender {
    _tapIndex = 5;
    [self tapgesturephotoOrCamera];
    
    
    
}
- (IBAction)tapgestureBusinessUndertakingOne:(UITapGestureRecognizer *)sender {
    _tapIndex = 6;
    [self tapgesturephotoOrCamera];
}
//点击门牌照
- (IBAction)tapgestureDoorPlate:(UITapGestureRecognizer *)sender {
    _tapIndex = 7;
    [self tapgesturephotoOrCamera];
    
    
}

- (IBAction)tapgestureDoorPlateOne:(UITapGestureRecognizer *)sender {
    _tapIndex = 8;
    [self tapgesturephotoOrCamera];
    
    
}
//门店内景图
- (IBAction)tapgestureStoreInterior:(UITapGestureRecognizer *)sender {
    _tapIndex = 9;
    [self tapgesturephotoOrCamera];
    
    
}

- (IBAction)tapgestureStoreInteriorOne:(UITapGestureRecognizer *)sender {
    _tapIndex = 10;
    
    [self tapgesturephotoOrCamera];
    
    
}

//选择图片来源
-(void)tapgesturephotoOrCamera{

    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"去相册选择",@"用相机拍照", nil];
    [actionSheet showInView:self.view];


}


//提交
- (IBAction)submitinfo:(UIButton *)sender {
    
    
    
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
        switch (self.tapIndex) {
            case 1:
            {
                self.handImage.image = [UIImage imageWithData:data];
            }
                break;
            case 2:
            {
                self.positiveImage.image = [UIImage imageWithData:data];
            }
                break;
            case 3:
            {
                self.otherSideImage.image = [UIImage imageWithData:data];
            }
                break;
            case 4:
            {
                self.licenseImage.image = [UIImage imageWithData:data];
            }
                break;
            case 5:
            {
                self.undertakingOne.image = [UIImage imageWithData:data];
            }
                break;
            case 6:
            {
                self.undertakingTwo.image = [UIImage imageWithData:data];
            }
                break;
            case 7:
            {
                self.doorplateImage.image = [UIImage imageWithData:data];
            }
                break;
            case 8:
            {
                self.DoorplateOneimage.image = [UIImage imageWithData:data];
            }
                break;
            case 9:
            {
                self.InteriorImage.image = [UIImage imageWithData:data];
            }
                break;
            case 10:
            {
                self.InteriorOneImage.image = [UIImage imageWithData:data];
            }
                break;
                
            default:
                break;
        }
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
}



-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.submit.layer.cornerRadius = 4;
    self.submit.clipsToBounds = YES;
    
    self.baseview.layer.cornerRadius = 4;
    self.baseview.clipsToBounds = YES;
    
    self.contentW.constant = SCREEN_WIDTH;
    self.contentH.constant = 830;


}
@end
