//
//  GLEncourageBeansController.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLEncourageBeansController.h"
#import "GLMyBeanCell.h"
#import <MJRefresh/MJRefresh.h>

@interface GLEncourageBeansController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_return_timeArr;
    NSMutableArray *_returnamountArr;
    NSMutableArray *_persentArr;
    LoadWaitView *_loadV;

    float _beanSum;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NodataView *nodataV;


@end

static NSString *ID = @"GLMyBeanCell";
@implementation GLEncourageBeansController

-(UITableView*)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-154)];
        
           }
    return _tableView;
}
-(NodataView*)nodataV{
    
    if (!_nodataV) {
        _nodataV=[[NSBundle mainBundle]loadNibNamed:@"NodataView" owner:self options:nil].firstObject;
        _nodataV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 114);
    }
    return _nodataV;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.nodataV];
    self.nodataV.hidden = YES;
    //    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMyBeanCell" bundle:nil] forCellReuseIdentifier:ID];
    
    _return_timeArr = [NSMutableArray array];
    _returnamountArr = [NSMutableArray array];
    _persentArr = [NSMutableArray array];
    
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
        [_persentArr removeAllObjects];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"token"] = [UserModel defaultUser].aukeyValue;
    
    _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"Index/volunteerBean" paramDic:dict finish:^(id responseObject) {
 
        [_loadV removeloadview];
        [self endRefresh];

        NSDate *date = [NSDate date];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        
        [formatter setDateFormat:@"YYYY-MM-dd"];
        
//        NSLog(@"%@",responseObject);
        NSString *DateTime = [formatter stringFromDate:date];
        if ([responseObject[@"code"] integerValue]==0) {
            
            for (NSDictionary *dict in responseObject[@"data"][@"rows"]) {
//                [_return_timeArr addObject:[NSString stringWithFormat:@"%@",dict[@"return_date"]]];
                NSArray *array = [dict[@"return_date"] componentsSeparatedByString:@"/"]; //从字符A中分隔成2个元素的数组
                [_return_timeArr addObject:array[0]];
                if (array.count == 1) {
                    [_persentArr addObject:@""];
                }else{
                    
                    [_persentArr addObject:array[1]];
                }
                [_returnamountArr addObject: [NSString stringWithFormat:@"%@",dict[@"returnamount"]]];
                if ([array[0] isEqualToString:DateTime]) {
                    
                    _beanSum += [dict[@"returnamount"] floatValue];
                }
            }
        }
        
        if (_returnamountArr.count <= 0 ) {
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
        //赋值
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
    if (_return_timeArr.count == 0) {
        return 0;
    }else{
        
        return _return_timeArr.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMyBeanCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.dateLabel.text = _return_timeArr[indexPath.row];
    cell.numberLabel.text = _returnamountArr[indexPath.row];
    cell.persentLabel.text = _persentArr[indexPath.row];
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
