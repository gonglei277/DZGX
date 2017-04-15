//
//  GLBuyBackChooseController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/14.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLBuyBackChooseController.h"
#import "GLBankCardCellTableViewCell.h"
#import "GLBuyBackChooseCardController.h"

@interface GLBuyBackChooseController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *cardModels;
@end

static NSString *ID = @"GLBankCardCellTableViewCell";
@implementation GLBuyBackChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自定义导航栏右按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH - 60, 14, 30, 30);
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    
    [button setImage:[UIImage imageNamed:@"mine_add"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:self action:@selector(pushToAddVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];

    self.navigationItem.title = @"我的银行卡";
//    self.tableView.editing = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"GLBankCardCellTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    
}
- (void)pushToAddVC {
    GLBuyBackChooseCardController * vc = [[GLBuyBackChooseCardController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSMutableArray *)cardModels{
    if (!_cardModels) {
        _cardModels = [NSMutableArray array];
        for (int i = 0; i <5; i ++) {
            GLBankCardModel *model = [[GLBankCardModel alloc] init];
            model.bankName = @"中国工商银行";
            model.bankNum = [NSString stringWithFormat:@"**** **** **** 000%d",i];
            model.iconName = @"mine_icbc";
            [_cardModels addObject:model];
        }
    }
    return _cardModels;
}
#pragma UITableviewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cardModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLBankCardCellTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    cell.model = self.cardModels[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)returnModel:(ReturnBlock)block{
    self.returnBlock = block;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.returnBlock(self.cardModels[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ADAPT(70);
}

/**
 *  只要实现了这个方法，左滑出现按钮的功能就有了
 (一旦左滑出现了N个按钮，tableView就进入了编辑模式, tableView.editing = YES)
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/**
 *  左滑cell时出现什么按钮
 */
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self.cardModels removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self deleteCard];
    }];
    
    return @[action1];
}
- (void)deleteCard {
    
}
@end
