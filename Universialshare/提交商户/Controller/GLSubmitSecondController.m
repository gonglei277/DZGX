//
//  GLSubmitSecondController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLSubmitSecondController.h"
#import "GLCityModel.h"

@interface GLSubmitSecondController ()<UIPickerViewDelegate,UIPickerViewDataSource>

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


//模型
@property (nonatomic, strong)GLCityModel *model;

@end

@implementation GLSubmitSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = NO;
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
    
    [self initdatasource];
    
}

- (IBAction)chooseInfo:(id)sender {
    [self edtingInfo];
}

//筛选
-(void)edtingInfo{
    
    [self.view addSubview:self.pickerViewMask];
    [self.pickerViewMask addSubview:self.pickerView];
    
}
-(void)initdatasource{
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"user/getCityList" paramDic:@{} finish:^(id responseObject) {
        [_loadV removeloadview];
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue]==1) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                
            }
            
        }
        
        
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [MBProgressHUD showError:error.localizedDescription];
        
    }];
    
    
}
#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (self.dataarr.count > 0) {
        self.nodataV.hidden = YES;
    }else{
        self.nodataV.hidden = NO;
    }
    return 10;
}


#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    
    return SCREEN_WIDTH -20;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 50;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.messageType = row + 1;
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return self.messageArr[row];
}
-(NSMutableArray *)messageArr{
    
    if (!_messageArr) {
        _messageArr=[NSMutableArray array];
        _messageArr = [NSMutableArray arrayWithObjects:@"nidaye",@"nidaye1",@"niday2e",@"nidaye3",@"nidaye4",@"nidaye5",@"nidaye6",@"nidaye7",@"nidaye8",@"nidaye9", nil];
    }
    
    return _messageArr;
    
}
////重写方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH -20 , 50)];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


-(NSMutableArray *)dataarr{
    
    if (!_dataarr) {
        _dataarr=[NSMutableArray array];
    }
    
    return _dataarr;
    
}

//点击pickerViewMask
-(void)tapgestureMask{
    
    [self.pickerView removeFromSuperview];
    [self.pickerViewMask removeFromSuperview];
    //重新刷新
    _refreshType = NO;
    _page=1;
    [self.dataarr removeAllObjects];
    
//    [self initdatasource];
    
}

-(UIPickerView*)pickerView{
    
    if (!_pickerView) {
        _pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(10, (SCREEN_HEIGHT - 200)/2, SCREEN_WIDTH - 20, 200)];
        _pickerView.dataSource=self;
        _pickerView.delegate=self;
        _pickerView.backgroundColor=[UIColor whiteColor];
    }
    return _pickerView;
    
}

-(UIView*)pickerViewMask{
    
    if (!_pickerViewMask) {
        _pickerViewMask=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _pickerViewMask.backgroundColor= YYSRGBColor(0, 0, 0, 0.2);
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgestureMask)];
        [_pickerViewMask addGestureRecognizer:tap];
    }
    
    return _pickerViewMask;
}

-(NodataView*)nodataV{
    
    if (!_nodataV) {
        _nodataV=[[NSBundle mainBundle]loadNibNamed:@"NodataView" owner:self options:nil].firstObject;
        _nodataV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
    }
    return _nodataV;
    
}

@end
