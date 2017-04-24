//
//  LBMyBusinessListDetailViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMyBusinessListDetailViewController.h"
#import "LBMyBusinessListDetailTableViewCell.h"


@interface LBMyBusinessListDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *backtitle;
@property (weak, nonatomic) IBOutlet UILabel *numlb;
@property (weak, nonatomic) IBOutlet UILabel *rangliLb;
@property (weak, nonatomic) IBOutlet UIImageView *lineimage;
@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end

@implementation LBMyBusinessListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableview.tableFooterView = [UIView new];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"LBMyBusinessListDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBMyBusinessListDetailTableViewCell"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   self.navigationController.navigationBar.hidden = YES;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 150;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    LBMyBusinessListDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBMyBusinessListDetailTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


- (IBAction)backbutton:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
