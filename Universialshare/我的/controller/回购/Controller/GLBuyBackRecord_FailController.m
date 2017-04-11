//
//  GLBuyBackRecord_FailController.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLBuyBackRecord_FailController.h"
#import "GLBuyBackRecordCell.h"
#import "GLBuyBackRecordModel.h"
//#import <MJRefresh/MJRefresh.h>

@interface GLBuyBackRecord_FailController()<UITableViewDelegate,UITableViewDataSource>
{
    LoadWaitView *_loadV;
}
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *models;

@property (nonatomic,assign)NSInteger page;

@property (nonatomic,strong)NodataView *nodataV;

@end

static NSString *ID = @"GLBuyBackRecordCell";
@implementation GLBuyBackRecord_FailController


- (NSMutableArray *)models{
    if (_models == nil) {
        _models = [NSMutableArray array];
        
    }
    return _models;
}

-(UITableView*)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 114)];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.nodataV];
    self.nodataV.hidden = YES;
//    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"GLBuyBackRecordCell" bundle:nil] forCellReuseIdentifier:ID];
    
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf updateData:YES];
        
    }];
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf updateData:NO];
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
    }];
    
    // 设置文字
    [header setTitle:@"快扯我，快点" forState:MJRefreshStateIdle];
    
    [header setTitle:@"数据要来啦" forState:MJRefreshStatePulling];
    
    [header setTitle:@"服务器正在狂奔 ..." forState:MJRefreshStateRefreshing];
    
    
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
    [self updateData:YES];
}
- (void)updateData:(BOOL)status {
    
    if (status) {
        
        self.page = 1;
        [self.models removeAllObjects];
        
    }else{
        _page ++;
        
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"token"] = [UserModel defaultUser].aukeyValue;
    dict[@"page"] = [NSString stringWithFormat:@"%ld",_page];
    dict[@"status"] = @"2";
    /*
     status:0 申请中
     1 完成
     2 失败
     */
    
    _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    
    [NetworkManager requestPOSTWithURLStr:@"Index/record_recover" paramDic:dict finish:^(id responseObject) {
        
        [_loadV removeloadview];
        [self endRefresh];
        if ([responseObject[@"code"] integerValue] == 0){
            
            for (NSDictionary *dict in responseObject[@"data"][@"rows"]) {
                
                GLBuyBackRecordModel *model = [GLBuyBackRecordModel mj_objectWithKeyValues:dict];
                [_models addObject:model];
            }
        }else{
            if (_models.count != 0){
                [MBProgressHUD showError:@"已经没有更多数据了!"];
            }
        }
        if (_models.count <= 0 ) {
            self.nodataV.hidden = NO;
        }else{
            self.nodataV.hidden = YES;
        }
        [self.tableView reloadData];
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [self endRefresh];
        self.nodataV.hidden = NO;
    }];
}
- (void)endRefresh {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
-(NodataView*)nodataV{
    
    if (!_nodataV) {
        _nodataV=[[NSBundle mainBundle]loadNibNamed:@"NodataView" owner:self options:nil].firstObject;
        _nodataV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114-49);
    }
    return _nodataV;
    
}

#pragma  UITableviewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLBuyBackRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.model = self.models[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 30)];
    customView.backgroundColor = YYSRGBColor(244,248, 250,1);
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor darkGrayColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    //    headerLabel.shadowColor = [UIColor lightGrayColor];
    headerLabel.font = [UIFont systemFontOfSize:14];
    headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 30);
    
    if (section == 0) {
        headerLabel.text =  @"本月";
    }else {
        headerLabel.text = @"上月";
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
