//
//  LBMineMessageViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/28.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineMessageViewController.h"
#import "LBMineCenterMessageTableViewCell.h"
#import "LBMineMessageSeviceViewController.h"
#import "LBMineMessageHotPickViewController.h"
#import "LBMineCenterserviceNoticeViewController.h"
#import "LBMineCenterFlyNoticeViewController.h"
#import "LBMineMessageSetupViewController.h"

@interface LBMineMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)NSArray *titleArr;

@end

@implementation LBMineMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"消息中心";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableview.tableFooterView = [UIView new];
    
     [self.tableview registerNib:[UINib nibWithNibName:@"LBMineCenterMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBMineCenterMessageTableViewCell"];
    
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"LB设置"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(5, 13, 5, -5)];
    button.backgroundColor=[UIColor clearColor];
    [button addTarget:self action:@selector(infomationSetUp) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *ba=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = ba;
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LBMineCenterMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBMineCenterMessageTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.namelb.text=[NSString stringWithFormat:@"%@",self.titleArr[indexPath.row]];
    
    if (indexPath.row == 0) {
        cell.timelb.hidden = YES;
    }else if (indexPath.row == 1){
        cell.timelb.hidden = NO;
    
    }else if (indexPath.row == 2){
        cell.timelb.hidden = NO;
        
    }else if (indexPath.row == 3){
        cell.timelb.hidden = NO;
        
    }
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        self.hidesBottomBarWhenPushed = YES;
        LBMineMessageSeviceViewController *vc=[[LBMineMessageSeviceViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 1){
        self.hidesBottomBarWhenPushed = YES;
        LBMineMessageHotPickViewController *vc=[[LBMineMessageHotPickViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 2){
        self.hidesBottomBarWhenPushed = YES;
        LBMineCenterserviceNoticeViewController *vc=[[LBMineCenterserviceNoticeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 3){
        
        self.hidesBottomBarWhenPushed = YES;
        LBMineCenterFlyNoticeViewController *vc=[[LBMineCenterFlyNoticeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

        
    }


}

-(void)infomationSetUp{

    self.hidesBottomBarWhenPushed = YES;
    LBMineMessageSetupViewController *vc=[[LBMineMessageSetupViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];


}


-(NSArray*)titleArr{

    if (!_titleArr) {
        _titleArr=[NSArray arrayWithObjects:@"客户服务",@"热卖精选",@"服务通知",@"物流通知", nil];
    }
    
    return _titleArr;

}

@end
