//
//  LBMyBusinessListViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMyBusinessListViewController.h"
#import "LBNybusinessListTableViewCell.h"
#import "LBMyBusinessListDetailViewController.h"

@interface LBMyBusinessListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tapH;


@end

@implementation LBMyBusinessListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.hidden = NO;
//    self.navigationItem.title = @"商家列表";
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.tableview.tableFooterView = [UIView new];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"LBNybusinessListTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBNybusinessListTableViewCell"];

    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.HideNavB == YES) {
        self.navigationController.navigationBar.hidden = NO;
        self.navigationItem.title = @"商家列表";
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.bottomH.constant = 0;
        self.tapH.constant = 64;
    }else{
        self.navigationController.navigationBar.hidden = YES;
        self.navigationItem.title = @"商家列表";
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.bottomH.constant = 49;
        self.tapH.constant = 0;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    return 125;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        LBNybusinessListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBNybusinessListTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.index = indexPath.row;
    
    __weak typeof(self) weakself =self;
    cell.returnGowhere = ^(NSInteger index){
        if (weakself.returnpushinfovc) {
            weakself.returnpushinfovc(index);
        }
        
    };
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (self.HideNavB == YES) {
        self.hidesBottomBarWhenPushed = YES;
        LBMyBusinessListDetailViewController *vc=[[LBMyBusinessListDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];

    }else{
        if (self.returnpushvc) {
            self.returnpushvc();
        }
    
    }
    
    
}


@end
