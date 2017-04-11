//
//  LBMineCenterReceivingGoodsViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/1.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineCenterReceivingGoodsViewController.h"
#import "LBMineCenterReceivingGoodsTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LBMineCenterFlyNoticeDetailViewController.h"

@interface LBMineCenterReceivingGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end

@implementation LBMineCenterReceivingGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"待收货";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableview.tableFooterView = [UIView new];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"LBMineCenterReceivingGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBMineCenterReceivingGoodsTableViewCell"];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 210;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LBMineCenterReceivingGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBMineCenterReceivingGoodsTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self)  weakself = self;
    [[cell rac_signalForSelector:@selector(buyevent:)] subscribeNext:^(id x) {
        

    }];
    
    [[cell rac_signalForSelector:@selector(SeeEvent:)] subscribeNext:^(id x) {
        
        weakself.hidesBottomBarWhenPushed=YES;
        LBMineCenterFlyNoticeDetailViewController *vc=[[LBMineCenterFlyNoticeDetailViewController alloc]init];
        [weakself.navigationController pushViewController:vc animated:YES];
        
    }];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}



@end
