//
//  LBMineCentermodifyAdressViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/30.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineCentermodifyAdressViewController.h"
#import "LBMineCentermodifyAdressTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/NSObject+RACKVOWrapper.h>
#import "LBMineCenterEditAdressViewController.h"
#import "LBMineCenterAddAdreassViewController.h"

@interface LBMineCentermodifyAdressViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)UIButton *rightBt;

@end

@implementation LBMineCentermodifyAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"修改收货地址";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableview.tableFooterView = [UIView new];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"LBMineCentermodifyAdressTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBMineCentermodifyAdressTableViewCell"];
    
    UIBarButtonItem *ba=[[UIBarButtonItem alloc]initWithCustomView:self.rightBt];
    
    self.navigationItem.rightBarButtonItem = ba;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LBMineCentermodifyAdressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBMineCentermodifyAdressTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    [[cell rac_signalForSelector:@selector(setupevent:)] subscribeNext:^(id x) {
        
    }];
    
    [[cell rac_signalForSelector:@selector(deleteEvent:)] subscribeNext:^(id x) {
       
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定删除地址吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];

    }];
    
    [[cell rac_signalForSelector:@selector(editEvent:)] subscribeNext:^(id x) {
        
        self.hidesBottomBarWhenPushed = YES;
        LBMineCenterEditAdressViewController *vc=[[LBMineCenterEditAdressViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
//添加地址
-(void)addAdressEvent{

    self.hidesBottomBarWhenPushed = YES;
    LBMineCenterAddAdreassViewController *vc=[[LBMineCenterAddAdreassViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];


}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    //确定
    if (buttonIndex == 1) {
        
    }

}

-(UIButton*)rightBt{

    if (!_rightBt) {
        _rightBt=[UIButton buttonWithType:UIButtonTypeContactAdd];
        _rightBt.frame = CGRectMake(0, 0, 30, 30);
        _rightBt.backgroundColor=[UIColor clearColor];
        [_rightBt addTarget:self action:@selector(addAdressEvent) forControlEvents:UIControlEventTouchUpInside];
        [_rightBt setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    }
    
    return _rightBt;

}

@end
