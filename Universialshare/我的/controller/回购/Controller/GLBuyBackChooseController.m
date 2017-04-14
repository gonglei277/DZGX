//
//  GLBuyBackChooseController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/14.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLBuyBackChooseController.h"
#import "GLBankCardCellTableViewCell.h"

@interface GLBuyBackChooseController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSString *ID = @"GLBankCardCellTableViewCell";
@implementation GLBuyBackChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的银行卡";
    [self.tableView registerNib:[UINib nibWithNibName:@"GLBankCardCellTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
}

#pragma UITableviewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLBankCardCellTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ADAPT(70);
}
@end
