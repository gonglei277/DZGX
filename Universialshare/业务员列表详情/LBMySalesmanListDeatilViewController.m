//
//  LBMySalesmanListDeatilViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMySalesmanListDeatilViewController.h"
#import "LBMySalesmanListDeatilTableViewCell.h"
#import "LBMyBusinessListViewController.h"

@interface LBMySalesmanListDeatilViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *backtitle;
@property (weak, nonatomic) IBOutlet UILabel *numlb;


@end

@implementation LBMySalesmanListDeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];

        self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableview.tableFooterView = [UIView new];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"LBMySalesmanListDeatilTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBMySalesmanListDeatilTableViewCell"];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
     self.navigationController.navigationBar.hidden = YES;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 130;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    LBMySalesmanListDeatilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBMySalesmanListDeatilTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.index = indexPath.row;
    
    __weak typeof(self) waekself = self;
    cell.returnbusiness = ^(NSInteger index){
        waekself.hidesBottomBarWhenPushed = YES;
        LBMyBusinessListViewController *vc = [[LBMyBusinessListViewController alloc]init];
        vc.HideNavB = YES;
        [waekself.navigationController pushViewController:vc animated:YES];
    };
    cell.returnsaleman = ^(NSInteger index){
        
    };
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


- (IBAction)backEvent:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
