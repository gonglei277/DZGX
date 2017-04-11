//
//  GLPersentController.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLTweleveFourController.h"
#import "GLMine_MyHeartCell.h"

@interface GLTweleveFourController ()<UITableViewDelegate,UITableViewDataSource>
{
    LoadWaitView *_loadV;
}
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *models;

@end

static NSString *ID = @"GLMine_MyHeartCell";
@implementation GLTweleveFourController

- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [NSMutableArray array];
        
//        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//        dict[@"token"] = [UserModel defaultUser].aukeyValue;
//        dict[@"drivetype"] = @"6";
//        dict[@"page"] = @"1";
//        
//        _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
//        [NetworkManager requestPOSTWithURLStr:@"Index/mylove" paramDic:dict finish:^(id responseObject) {
//            
//            [_loadV removeloadview];
//            if ([responseObject[@"code"] integerValue]==0) {
//                
//                GLMyheartModel *model = [GLMyheartModel mj_objectWithKeyValues:responseObject[@"data"][@"rows"]];
//                [self.models addObject:model];
//                
//                [self.tableView reloadData];
//                
//            }else{
//                
//                [MBProgressHUD showError:responseObject[@"msg"]];
//            }
//            
//        } enError:^(NSError *error) {
//            
//            [_loadV removeloadview];
//            [MBProgressHUD showError:error.localizedDescription];
//            
//        }];
    }
    return _models;
}
-(UITableView*)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_MyHeartCell" bundle:nil] forCellReuseIdentifier:ID];
   
   
}

#pragma  UITableviewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.models.count == 0) {
        return 0;
    }else{
        
        return self.models.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_MyHeartCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    cell.model = self.models[indexPath.row];
    GLMyheartModel *model = self.models[indexPath.row];
    if ([model.expensetime rangeOfString:@"null"].location != NSNotFound) {
        model.expensetime = @"1970-01-01";
    }
    if ([model.gather_date rangeOfString:@"null"].location != NSNotFound) {
        model.gather_date = @"1970-01-01";
    }
    if ([model.amount rangeOfString:@"null"].location != NSNotFound) {
        model.amount = @"0.00";
    }
    if ([model.tax rangeOfString:@"null"].location != NSNotFound) {
        model.tax = @"0.00";
    }
    if ([model.lovevalue rangeOfString:@"null"].location != NSNotFound) {
        model.lovevalue = @"0.00";
    }
    if ([model.endnumber rangeOfString:@"null"].location != NSNotFound) {
        model.endnumber = @"0.00";
    }
    if ([model.returnvalue rangeOfString:@"null"].location != NSNotFound) {
        model.returnvalue = @"0.00";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 30)];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor darkGrayColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.shadowColor = [UIColor lightGrayColor];
    headerLabel.font = [UIFont systemFontOfSize:14];
    headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 30);
    
    if (section == 0) {
        headerLabel.text =  @"本月";
    }else {
        headerLabel.text = @"";
    }
    
    [customView addSubview:headerLabel];
    
    return customView;
}
//别忘了设置高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

@end
