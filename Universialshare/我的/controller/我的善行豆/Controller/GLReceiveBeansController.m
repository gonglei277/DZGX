//
//  GLReceiveBeansController.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLReceiveBeansController.h"
#import "GLMyBeanCell.h"

@interface GLReceiveBeansController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_return_timeArr;
    NSMutableArray *_returnamountArr;
    LoadWaitView *_loadV;
    float _beanSum;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NodataView *nodataV;
@end
static NSString *ID = @"GLMyBeanCell";
@implementation GLReceiveBeansController

-(UITableView*)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-154)];
        
          }
    return _tableView;
}
-(NodataView*)nodataV{
    
    if (!_nodataV) {
        _nodataV=[[NSBundle mainBundle]loadNibNamed:@"NodataView" owner:self options:nil].firstObject;
        _nodataV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
    }
    return _nodataV;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.nodataV];
    self.nodataV.hidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMyBeanCell" bundle:nil] forCellReuseIdentifier:ID];
    
    _return_timeArr = [NSMutableArray array];
    _returnamountArr = [NSMutableArray array];
    
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf updateData:YES];
        
    }];
    // 设置文字
    [header setTitle:@"快扯我，快点" forState:MJRefreshStateIdle];
    
    [header setTitle:@"数据要来啦" forState:MJRefreshStatePulling];
    
    [header setTitle:@"服务器正在狂奔 ..." forState:MJRefreshStateRefreshing];
    
    
    self.tableView.mj_header = header;
    
    [self updateData:YES];
    
}

- (void)updateData:(BOOL)status {
    

    if (status) {
        
        [_return_timeArr removeAllObjects];
        [_returnamountArr removeAllObjects];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"token"] = [UserModel defaultUser].aukeyValue;
    
    _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"Index/volunteerBean2" paramDic:dict finish:^(id responseObject) {
        [self endRefresh];
        [_loadV removeloadview];
//        NSLog(@"%@",responseObject);
        
        NSDate *date = [NSDate date];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString *DateTime = [formatter stringFromDate:date];
        
        if ([responseObject[@"code"] integerValue]==0) {
            
            for (NSDictionary *dict in responseObject[@"data"][@"rows"]) {
                [_return_timeArr addObject:dict[@"donationtime"]];
                [_returnamountArr addObject:dict[@"beannum"]];

                if ([dict[@"donationtime"] isEqualToString:DateTime]) {
                    
                    _beanSum += [dict[@"beannum"] floatValue];
                  
                }
            }
        }
        if (_return_timeArr.count <= 0 ) {
            self.nodataV.hidden = NO;
        }else{
            self.nodataV.hidden = YES;
        }
        //赋值
        if (self.retureValue) {
            self.retureValue([NSString stringWithFormat:@"%.2f",_beanSum]);
        }
        _beanSum = 0;
        
        [self.tableView reloadData];
        
    } enError:^(NSError *error) {
        
        if (self.retureValue) {
            self.retureValue(@"0");
        }

        [_loadV removeloadview];
        [self endRefresh];
        self.nodataV.hidden = NO;
    }];
    
}
- (void)endRefresh {
    [self.tableView.mj_header endRefreshing];
    
}

#pragma  UITableviewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _return_timeArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMyBeanCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.dateLabel.text = _return_timeArr[indexPath.row];
    cell.numberLabel.text = _returnamountArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 30)];
    customView.backgroundColor = YYSRGBColor(244,248, 250,1);
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor darkGrayColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
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
