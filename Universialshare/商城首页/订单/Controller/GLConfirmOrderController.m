//
//  GLConfirmOrderController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/1.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLConfirmOrderController.h"
#import "GLOrderDetailController.h"
#import "GLOrderPayView.h"
#import "GLSet_MaskVeiw.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LBMineCentermodifyAdressViewController.h"

#import "LBMineCenterPayPagesViewController.h"
#import "GLOrderGoodsCell.h"
#import "GLConfirmOrderModel.h"

@interface GLConfirmOrderController ()<UITableViewDelegate,UITableViewDataSource>
{
    int _sumNum;
//    GLSet_MaskVeiw *_maskV;
    LoadWaitView * _loadV;
}

@property (nonatomic, strong)GLSet_MaskVeiw *maskV;
@property (nonatomic, strong)GLOrderPayView *payV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewH;

@property (weak, nonatomic) IBOutlet UIView *addressView;

@property (weak, nonatomic) IBOutlet UILabel *yunfeiLabel;//运费Label
@property (weak, nonatomic) IBOutlet UILabel *totalSumLabel;//实付总价

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray  *models;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

//收货人信息
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

static NSString *ID = @"GLOrderGoodsCell";
@implementation GLConfirmOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"确认订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    self.contentViewW.constant = SCREEN_WIDTH;
    self.contentViewH.constant = SCREEN_HEIGHT + 49;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeAddress)];
    [self.addressView addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(dismiss) name:@"maskView_dismiss" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(ensurePassword:) name:@"input_PasswordNotification" object:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GLOrderGoodsCell" bundle:nil] forCellReuseIdentifier:ID];
     [self postRequest];
    
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)postRequest {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"goods_id"] = @1;
    dict[@"goods_count"] = @1;
    
    _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"shop/placeOrderBefore" paramDic:dict finish:^(id responseObject) {
        
        [_loadV removeloadview];
//        NSLog(@"dict = %@",dict);
//        NSLog(@"responseObject = %@",responseObject);
        if ([responseObject[@"code"] integerValue] == 1){
            
            self.totalSumLabel.text = [NSString stringWithFormat:@"合计:¥%@",responseObject[@"data"][@"all_realy_price"]];
            self.yunfeiLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"all_delivery"]];
            
            for (NSDictionary *dic in responseObject[@"data"][@"goods_list"]) {
                GLConfirmOrderModel *model = [GLConfirmOrderModel mj_objectWithKeyValues:dic];
                [_models addObject:model];
            }
            self.tableViewHeight.constant = _models.count * 150 * autoSizeScaleY;
            [self.tableView reloadData];
            
//            self.hidesBottomBarWhenPushed = YES;
//            LBMineCenterPayPagesViewController *payVC = [[LBMineCenterPayPagesViewController alloc] init];
//            [self.navigationController pushViewController:payVC animated:YES];
        }
        
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
    }];
}

- (void)changeAddress{
    LBMineCentermodifyAdressViewController *modifyAD = [[LBMineCentermodifyAdressViewController alloc] init];
    modifyAD.block = ^(NSString *name,NSString *phone,NSString *address){
        self.nameLabel.text = [NSString stringWithFormat:@"收货人:%@",name];
        self.phoneLabel.text = [NSString stringWithFormat:@"电话号码:%@",phone];
        self.addressLabel.text = [NSString stringWithFormat:@"收货地址:%@",address];
    };
    
    [self.navigationController pushViewController:modifyAD animated:YES];
}
- (void)dismiss {
    [_payV.passwordF resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        _payV.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT *0.5);

    }completion:^(BOOL finished) {

        [_maskV removeFromSuperview];
    }];
}

- (void)ensurePassword:(NSNotification *)userInfo{
    [self dismiss];
   
    NSLog(@"userinfo = %@",userInfo.userInfo[@"password"]);
}
  

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
- (IBAction)submitOrder:(UIButton *)sender {

    
}
//- (IBAction)changeNum:(id)sender {
//    
//    if (sender == self.reduceBtn) {
//        _sumNum -= 1;
//        if(_sumNum < 1){
//            _sumNum = 1;
//        }
//    }else{
//        _sumNum += 1;
//    }
//    self.numberLabel.text = [NSString stringWithFormat:@"%d",_sumNum];
//    
//}

#pragma  UITableveiwdelegate UITableviewdatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GLOrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.model = self.models[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150 *autoSizeScaleY;
}

#pragma 懒加载
- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray array];
        
    }
    return _models;
}
@end
