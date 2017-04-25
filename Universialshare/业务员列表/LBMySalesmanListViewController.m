//
//  LBMySalesmanListViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMySalesmanListViewController.h"
#import "LBMySalesmanListTableViewCell.h"
#import "LBMySalesmanListDeatilViewController.h"
#import "LBSaleManPersonInfoViewController.h"

@interface LBMySalesmanListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end

@implementation LBMySalesmanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tableview.tableFooterView = [UIView new];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"LBMySalesmanListTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBMySalesmanListTableViewCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    LBMySalesmanListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBMySalesmanListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath.row;
    
    __weak typeof(self) weakself =self;
    cell.returntapgestureimage = ^(NSInteger index){
    
        if (weakself.returnpushinfovc) {
            weakself.returnpushinfovc(index);
        }
    
    };
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.returnpushvc) {
        self.returnpushvc();
    }
    
}


@end
