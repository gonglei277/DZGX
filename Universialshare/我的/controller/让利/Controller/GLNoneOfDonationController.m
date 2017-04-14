//
//  GLNoneOfDonationController.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLNoneOfDonationController.h"
#import "NodataView.h"
#import "GLNoneOfDonationCell.h"

@interface GLNoneOfDonationController ()<UITableViewDelegate,UITableViewDataSource>
{
    LoadWaitView *_loadV;
    int _page;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic ,strong)NSMutableArray *models;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (nonatomic ,strong)NodataView *nodataV;

@end

static NSString *ID = @"GLNoneOfDonationCell";
@implementation GLNoneOfDonationController

- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray array];
   

        
    }
    return _models;
}
-(NodataView*)nodataV{
    
    if (!_nodataV) {
        _nodataV=[[NSBundle mainBundle]loadNibNamed:@"NodataView" owner:self options:nil].firstObject;
        _nodataV.frame = CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT - 114);
    }
    return _nodataV;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"让利捐赠";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"GLNoneOfDonationCell" bundle:nil] forCellReuseIdentifier:ID];
    _page = 1;
    
    [self.view addSubview:self.nodataV];
    self.nodataV.hidden = YES;
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
        [_models removeAllObjects];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"page"] = [NSString stringWithFormat:@"%d", _page];
    
    _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"user/myRl_list" paramDic:dict finish:^(id responseObject) {
        [_loadV removeloadview];
        [self endRefresh];
//        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue] == 1) {
            
            for (NSDictionary *dict in responseObject[@"data"]) {
                GLNoneOfDonationModel *model = [GLNoneOfDonationModel mj_objectWithKeyValues:dict];
                [_models addObject:model];
            }

            
        }
        if (_models.count <= 0 ) {
            self.nodataV.hidden = NO;
            self.totalLabel.text = @"0";
        }else{
            self.nodataV.hidden = YES;
            self.totalLabel.text = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"donationamt"]];
        }
        
        [self.tableView reloadData];
    } enError:^(NSError *error) {
        [self endRefresh];
        [_loadV removeloadview];
        self.nodataV.hidden = NO;
        [MBProgressHUD showError:error.localizedDescription];
    }];
}
- (void)endRefresh {
    [self.tableView.mj_header endRefreshing];
    
}
- (void)viewWillAppear:(BOOL)animated{
   

    self.tabBarController.tabBar.hidden = YES;
}
#pragma  UITableviewDatasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLNoneOfDonationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.model = self.models[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
@end
