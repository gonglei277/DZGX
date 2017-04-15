//
//  LBMyOrderPendingPaymentViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/1.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMyOrderPendingPaymentViewController.h"
#import "LBMyOrderListTableViewCell.h"

@interface LBMyOrderPendingPaymentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end

@implementation LBMyOrderPendingPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview.tableFooterView = [UIView new];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"LBMyOrderListTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBMyOrderListTableViewCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LBMyOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBMyOrderListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.payBt setTitle:@"去支付" forState:UIControlStateNormal];
    cell.index = indexPath.row;
    cell.deleteBt.hidden = YES;
    __weak typeof(self)  weakself = self;
    
    cell.retunpaybutton = ^(NSInteger index){
        
        
        
    };
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

@end
