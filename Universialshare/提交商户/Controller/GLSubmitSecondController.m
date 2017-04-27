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

@interface GLSubmitSecondController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    int _index;
    NSInteger _provinceIndex;
    NSInteger _cityIndex;
    NSInteger _countryIndex;
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

//模型
//@property (nonatomic, strong)GLCityModel *model;

@property (nonatomic, strong)NSMutableArray *dataArr;

@property (nonatomic, strong)NSMutableArray *provinceArr;
@property (nonatomic, strong)NSMutableArray *cityArr;
@property (nonatomic, strong)NSMutableArray *countryArr;

@end

@implementation GLSubmitSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提交商户";
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
    
    self.provinceArr = [NSMutableArray array];
    self.cityArr = [NSMutableArray array];
    self.countryArr = [NSMutableArray array];
    
    [self initdatasource];
    
}

- (IBAction)chooseInfo:(id)sender {
    [self edtingInfo];
    if (sender == self.provinceBtn) {
        self.cityLabel.text = @"请选择城市";
        self.countryLabel.text = @"请选择区域";
        _index = 0;
        _provinceIndex = 0;
        _cityIndex = 0;
    }else if (sender == self.cityBtn){
        if (_provinceIndex == 0) {
            return;
        }
        self.countryLabel.text = @"请选择区域";
        _cityIndex = 0;
        _index = 1;
        
    }else if (sender == self.countryBtn){
        if (_provinceIndex == 0) {
            return;
        }
        if (_cityIndex == 0) {
            return;
        }
        _index = 2;

    }else if (sender == self.classifyOneBtn){
        _index = 3;

    }else {
        _index = 4;
    }
    [self currentDataArr];
    [self.pickerView reloadAllComponents];
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
//        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue]==1) {
            GLCityModel * model = [GLCityModel mj_objectWithKeyValues:responseObject];
            for (Data *data in model.data) {
                [self.provinceArr addObject:data.province_name];
                
                NSMutableArray *cityA = [NSMutableArray array];
                NSMutableArray *countryB = [NSMutableArray array];
                for (City *city in data.city) {

                    [cityA addObject:city.city_name];
                    
                    NSMutableArray *countryA = [NSMutableArray array];
                    for (Country *country in city.country) {
                        
                        [countryA addObject:country.country_name];
                    }
                    [countryB addObject:countryA];
                }
                [self.countryArr addObject:countryB];
                [self.cityArr addObject:cityA];
                
            }
            
        }
        
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [MBProgressHUD showError:error.localizedDescription];
        
    }];
    
}
- (id)currentDataArr {
    if (_index == 0) {
        self.dataArr = self.provinceArr;
        
    }else if (_index == 1){
        self.dataArr = self.cityArr[_provinceIndex - 1];
    }else if (_index == 2){
        self.dataArr = self.countryArr[_provinceIndex - 1][_cityIndex - 1];
    }

    return self.dataArr;
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
 
    return self.dataArr.count;
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
    if (_index == 0) {
        _provinceIndex = row + 1;
        self.provinceLabel.text = self.provinceArr[row];
    }else if(_index == 1){
        _cityIndex = row + 1;
        self.cityLabel.text = self.cityArr[_provinceIndex - 1][row];
        
    }else if (_index == 2){
        _countryIndex = row + 1;
        self.countryLabel.text = self.countryArr[_provinceIndex - 1][_cityIndex - 1][row];
    }else if (_index == 3){
        
    }else{
        
    }
//    self.messageType = row + 1;
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
//    NSString *content;
//    if (_index == 0) {
//        content = self.dataArr[row];
//    }else if (_index == 1){
//    }
    return self.dataArr[row];
}
//-(NSMutableArray *)messageArr{
//    
//    if (!_messageArr) {
//        _messageArr=[NSMutableArray array];
//        _messageArr = [NSMutableArray arrayWithObjects:@"nidaye",@"nidaye1",@"niday2e",@"nidaye3",@"nidaye4",@"nidaye5",@"nidaye6",@"nidaye7",@"nidaye8",@"nidaye9", nil];
//    }
//    
//    return _messageArr;
//    
//}
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
//点击下一步
- (IBAction)nextbuttonevent:(UIButton *)sender {
    self.hidesBottomBarWhenPushed = YES;
    LBMerchantSubmissionThreeViewController *vc=[[LBMerchantSubmissionThreeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
    
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
