//
//  LBMineCenterPayPagesViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/21.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineCenterPayPagesViewController.h"
#import "LBMineCenterPayPagesTableViewCell.h"
#import "LBIntegralMallViewController.h"

@interface LBMineCenterPayPagesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    LoadWaitView *_loadV;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UIButton *sureBt;

@property (strong, nonatomic)  NSArray *dataarr;
@property (strong, nonatomic)  NSMutableArray *selectB;
@property (assign, nonatomic)  NSInteger selectIndex;
@property (weak, nonatomic) IBOutlet UILabel *orderType;
@property (weak, nonatomic) IBOutlet UILabel *ordercode;
@property (weak, nonatomic) IBOutlet UILabel *orderMoney;
@property (weak, nonatomic) IBOutlet UILabel *orderMTitleLb;

@end

@implementation LBMineCenterPayPagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"支付页面";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.selectIndex = -1;

    self.tableview.tableFooterView = [UIView new];
    [self.tableview registerNib:[UINib nibWithNibName:@"LBMineCenterPayPagesTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBMineCenterPayPagesTableViewCell"];
    
    self.ordercode.text = self.orderNum;
    self.orderMoney.text = self.orderScore;
    
    if (self.payType == 1) {
        self.orderMTitleLb.text = @"订单金额:";
        self.orderType.text = @"消费订单";
    }else{
        self.orderMTitleLb.text = @"订单积分:";
        self.orderType.text = @"积分订单";
    }
    for (int i=0; i<_dataarr.count; i++) {
        
        [self.selectB addObject:@NO];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataarr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    LBMineCenterPayPagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBMineCenterPayPagesTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.payimage.image = [UIImage imageNamed:_dataarr[indexPath.row][@"image"]];
    cell.paytitile.text = _dataarr[indexPath.row][@"title"];
    
    if([self.useableScore integerValue] > 10000){
        
        cell.reuseScoreLabel.text  = [NSString stringWithFormat:@"剩余积分:%.2f万分",[self.useableScore floatValue]/10000];
    }else{
         cell.reuseScoreLabel.text  = [NSString stringWithFormat:@"剩余积分:%@分",self.useableScore];
    }
    
    if ([self.selectB[indexPath.row]boolValue] == NO) {
        
        cell.selectimage.image = [UIImage imageNamed:@"支付未选中"];
    }else{
    
        cell.selectimage.image = [UIImage imageNamed:@"支付选中"];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.selectIndex == -1) {
        BOOL a=[self.selectB[indexPath.row]boolValue];
        [self.selectB replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:!a]];
        self.selectIndex = indexPath.row;
        
    }else{
    
        if (self.selectIndex == indexPath.row) {
            return;
        }
        BOOL a=[self.selectB[indexPath.row]boolValue];
        [self.selectB replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:!a]];
        [self.selectB replaceObjectAtIndex:self.selectIndex withObject:[NSNumber numberWithBool:NO]];
        self.selectIndex = indexPath.row;
    
    }
    
    [self.tableview reloadData];
}

- (IBAction)surebutton:(UIButton *)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    
//    NSString *orderID = [RSAEncryptor encryptString:self.orderNum publicKey:public_RSA];
//    NSString *uid = [RSAEncryptor encryptString:[UserModel defaultUser].uid publicKey:public_RSA];
//    dict[@"uid"] = uid;
//    dict[@"order_id"] = orderID;
    
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"order_id"] = self.order_id;

    _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"shop/markPay" paramDic:dict finish:^(id responseObject) {
        
        [_loadV removeloadview];
        
        if ([responseObject[@"code"] integerValue] == 1){
            
            NSLog(@"message = %@",responseObject[@"message"]);
            [MBProgressHUD showSuccess:@"付款成功"];
            
//            self.hidesBottomBarWhenPushed = YES;
//            LBIntegralMallViewController *homeVC = [[LBIntegralMallViewController alloc] init];
//            
            [self.navigationController popToRootViewControllerAnimated:YES];

//            self.hidesBottomBarWhenPushed = NO;
        }
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        
    }];

    
}


-(NSArray*)dataarr{

    if (!_dataarr) {
        
        if (self.payType == 1) {
            _dataarr=[NSArray arrayWithObjects:@{@"image":@"余额",@"title":@"余额支付"},@{@"image":@"支付宝",@"title":@"支付宝支付"},@{@"image":@"微信",@"title":@"微信支付"}, nil];
        }else if (self.payType == 2){
        
           _dataarr=[NSArray arrayWithObjects:@{@"image":@"支付积分",@"title":@"积分支付"}, nil];
        }
    }

    return _dataarr;
}

-(NSMutableArray*)selectB{

    if (!_selectB) {
        _selectB=[NSMutableArray array];
    }
    
    return _selectB;

}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.sureBt.layer.cornerRadius = 4;
    self.sureBt.clipsToBounds = YES;

}

@end
