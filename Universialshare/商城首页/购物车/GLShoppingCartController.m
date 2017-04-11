//
//  GLShoppingCartController.m
//  PublicSharing
//
//  Created by 龚磊 on 2017/3/23.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLShoppingCartController.h"
#import "GLShoppingCell.h"

@interface GLShoppingCartController ()<UITableViewDelegate,UITableViewDataSource,GLShoppingCellDelegate>
{
    NSMutableArray *_numArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *clearingBtn;

@property (nonatomic, assign)BOOL isSelectedRightBtn;

@property (nonatomic, strong)NSMutableArray *selectArr;

@property (nonatomic, strong)UIButton *seleteAllBtn;
@property (nonatomic, strong)UIButton *rightBtn;

@property (nonatomic, strong)NSMutableArray *dataSource;

@property (nonatomic, assign)NSInteger totalPrice;
@property (nonatomic, assign)NSInteger totalNum;
@end

static NSString *ID = @"GLShoppingCell";
@implementation GLShoppingCartController

- (UIView *)headerView {
    
    if(_headerView == nil){
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        _seleteAllBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 30, 30)];
        _seleteAllBtn.backgroundColor = [UIColor lightGrayColor];
        [_seleteAllBtn addTarget:self action:@selector(selectAll) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_seleteAllBtn.frame) + 10, _seleteAllBtn.yy_y, 80, _seleteAllBtn.yy_height)];
        label.text = @"全选";
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), SCREEN_WIDTH, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        lineView.alpha = 0.3;
        
        
        [_headerView addSubview:_seleteAllBtn];
        [_headerView addSubview:label];
        [_headerView addSubview:lineView];
    }
    return  _headerView;
    
}

- (NSMutableArray *)selectArr {
    if (_selectArr == nil) {
        _selectArr = [NSMutableArray array];
        _numArr = [NSMutableArray array];
        for (int  i = 0; i < 6; i ++) {
            BOOL isSelected = NO;
            [_selectArr addObject:@(isSelected)];
        
            NSInteger num = 1;
            [_numArr addObject:@(num)];
            
            
        }
        
    }
    return _selectArr;
}
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (int i = 0; i < self.selectArr.count; i ++) {
            NSString *str = [NSString stringWithFormat:@"%d",i + 1];
            [_dataSource addObject:str];
        }
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"GLShoppingCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.tableHeaderView = self.headerView;
    //自定义导航栏右按钮
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 80, 44);
    // 让按钮内部的所有内容左对齐
    _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _isSelectedRightBtn = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    
     [self.clearingBtn addTarget:self action:@selector(clearingMore:) forControlEvents:UIControlEventTouchUpInside];
//    self.selectedNumLabel.text = [NSString stringWithFormat:@"已选中%ld件商品",_totalNum];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"总金额¥ %ld元",_totalPrice];
    [self updateTitleNum];
}
//编辑
- (void)edit {
    self.rightBtn.selected = !self.rightBtn.selected;
    if (self.rightBtn.selected) {
        
        [_rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        self.totalPriceLabel.hidden = YES;
        [self.clearingBtn setTitle:@"删除" forState:UIControlStateNormal];
    
    }else{
        [_rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        self.totalPriceLabel.hidden = NO;
        [self.clearingBtn setTitle:@"去结算" forState:UIControlStateNormal];
      
    }
    self.totalPriceLabel.text = [NSString stringWithFormat:@"总金额¥ %ld元",_totalPrice];
    self.selectedNumLabel.text = [NSString stringWithFormat:@"已选中%ld件商品",_totalNum];
    
    [self.tableView reloadData];
}
//批量删除
- (void)clearingMore:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"去结算"]) {
         NSLog(@"结算%ld件商品",_totalNum);
    }else{
        NSLog(@"删除%ld件商品",_totalNum);
        
        NSMutableIndexSet *indexs = [NSMutableIndexSet indexSet];
        // 遍历选中的数据源的index并添加到set里面
        for (int i = 0; i < self.selectArr.count; i ++) {
            if ([self.selectArr[i] boolValue] == YES) {
                [indexs addIndex:i];
                _totalPrice -= [_dataSource[i] integerValue] * [_numArr[i] integerValue];
            }
        }
        _totalNum = 0;
        self.selectedNumLabel.text = [NSString stringWithFormat:@"已选中%ld件商品",_totalNum];
        self.totalPriceLabel.text = [NSString stringWithFormat:@"总金额¥ %ld元",_totalPrice];
        //  删除选中数据源 并更新tableView
//        [dataSource removeObjectsAtIndexes:indexs];
        [self.selectArr removeObjectsAtIndexes:indexs];
        [self.dataSource removeObjectsAtIndexes:indexs];
        [_numArr removeObjectsAtIndexes:indexs];
        
        [self updateTitleNum];
        
        [self.tableView reloadData];
        
    }
}
//全选
- (void)selectAll {
    self.seleteAllBtn.selected = !self.seleteAllBtn.selected;
    _totalPrice = 0;
    _totalNum = 0;
    for (int i = 0; i< self.selectArr.count; i ++) {
        
        BOOL tempBool = [self.selectArr[i] boolValue];
        
        if (self.seleteAllBtn.selected) {
            tempBool = YES;
            _totalPrice += [self.dataSource[i] integerValue] * [_numArr[i] integerValue];
            _totalNum += [_numArr[i] integerValue];
        }else{
            tempBool = NO;
        }
        
        [self.selectArr replaceObjectAtIndex:i withObject:@(tempBool)];
        
    }

    if(self.seleteAllBtn.selected){
        
        self.seleteAllBtn.backgroundColor = [UIColor orangeColor];
        self.selectedNumLabel.text = [NSString stringWithFormat:@"已选中%lu件商品",_totalNum];
        self.totalPriceLabel.text = [NSString stringWithFormat:@"总金额¥ %ld元",_totalPrice];
        
        
    }else{
        
        self.selectedNumLabel.text = [NSString stringWithFormat:@"已选中0件商品"];
        self.totalPriceLabel.text = @"总金额¥ 0元";
        self.seleteAllBtn.backgroundColor = [UIColor lightGrayColor];
        _totalNum = 0;
        _totalPrice = 0;
        
    }
    [self updateTitleNum];
    [self.tableView reloadData];
}
//选中,取消选中
- (void)changeStatus:(NSInteger)index {
    
    BOOL isSelected = [self.selectArr[index] boolValue];

    isSelected = !isSelected;
    
    if (isSelected) {
        _totalNum += [_numArr[index] integerValue];
        _totalPrice += [self.dataSource[index] integerValue] * [_numArr[index] integerValue];
    }else{
        _totalNum -= [_numArr[index] integerValue];
        _totalPrice -= [self.dataSource[index] integerValue]* [_numArr[index] integerValue];
    }
    NSLog(@"_totalNum = %ld",_totalNum);
    NSLog(@"_totalPrice = %ld",_totalPrice);
    self.selectedNumLabel.text = [NSString stringWithFormat:@"已选中%ld件商品",_totalNum];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"总金额%ld元",_totalPrice];
    [self.selectArr replaceObjectAtIndex:index withObject:@(isSelected)];
    [self updateTitleNum];
    [self.tableView reloadData];

}

- (void)updateTitleNum {
    self.navigationItem.title = [NSString stringWithFormat:@"购物车(%ld)",_totalNum];
}
//加减数量
- (void)addNum:(NSInteger)index {
    
    NSInteger num = [_numArr[index] integerValue];
    num += 1;
    [_numArr replaceObjectAtIndex:index withObject:@(num)];
    
    if ([self.selectArr[index] boolValue]) {
        _totalNum += 1;
        _totalPrice += [self.dataSource[index] integerValue];
    }
    [self updateTitleNum];
    self.selectedNumLabel.text = [NSString stringWithFormat:@"已选中%ld件商品",_totalNum];
    [self.tableView reloadData];
}
- (void)reduceNum:(NSInteger)index {
    
    NSInteger num = [_numArr[index] integerValue];
    num -= 1;
    
    [_numArr replaceObjectAtIndex:index withObject:@(num)];
    
    if ([self.selectArr[index] boolValue]) {
        _totalNum -= 1;
        _totalPrice -= [self.dataSource[index] integerValue];
    }
    if (num <= 0) {
        num = 0;
    }
    [self updateTitleNum];
    self.selectedNumLabel.text = [NSString stringWithFormat:@"已选中%ld件商品",_totalNum];
     [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma  UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GLShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.index = indexPath.row;
    cell.priceLabel.text = self.dataSource[indexPath.row];
//    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",[_numArr[indexPath.row] integerValue]];
    
    
    
    if (self.rightBtn.selected) {
        cell.bottomView.hidden = NO;
        cell.amountLabel.hidden = YES;
        cell.numberLabel.text = [NSString stringWithFormat:@"%@",_numArr[indexPath.row]];
    }else{
        cell.bottomView.hidden = YES;
        cell.amountLabel.hidden = NO;
        cell.amountLabel.text = [NSString stringWithFormat:@"x %@",_numArr[indexPath.row]];

    }
    
    if ([self.selectArr[indexPath.row] boolValue] == NO) {
        
        cell.selectedBtn.backgroundColor = [UIColor lightGrayColor];
        
    }else{
        cell.selectedBtn.backgroundColor = [UIColor orangeColor];
       
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    WS(weakself);
    [tableView setEditing:NO animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定删除该消息？" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alertController removeFromParentViewController];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [self.selectArr removeObjectAtIndex:indexPath.row];
            [self.dataSource removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
