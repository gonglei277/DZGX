//
//  LBMineStoreHistoryOrderingViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/14.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineStoreHistoryOrderingViewController.h"
#import "LBMineStoreOrderingTableViewCell.h"

@interface LBMineStoreHistoryOrderingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *taleview;
@property (strong, nonatomic)NSMutableArray *dataarr;
@property (strong, nonatomic)LoadWaitView *loadV;
@property (assign, nonatomic)NSInteger page;//页数默认为0
@property (assign, nonatomic)BOOL refreshType;//判断刷新状态 默认为no
@end

@implementation LBMineStoreHistoryOrderingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor=[UIColor whiteColor];
    self.taleview.tableFooterView = [UIView new];
    [self.taleview registerNib:[UINib nibWithNibName:@"LBMineStoreOrderingTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBMineStoreOrderingTableViewCell"];
    
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf loadNewData];
        
    }];
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf footerrefresh];
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
    }];
    
    
    // 设置文字
    
    [header setTitle:@"快扯我，快点" forState:MJRefreshStateIdle];
    
    [header setTitle:@"数据要来啦" forState:MJRefreshStatePulling];
    
    [header setTitle:@"服务器正在狂奔 ..." forState:MJRefreshStateRefreshing];
    
    
    self.taleview.mj_header = header;
    self.taleview.mj_footer = footer;
    
    [self initdatasource];
}

-(void)initdatasource{
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"user/order_list" paramDic:@{@"page":[NSNumber numberWithInteger:_page] , @"uid":[UserModel defaultUser].uid , @"token":[UserModel defaultUser].token ,@"tatus":[NSNumber numberWithInteger:0]} finish:^(id responseObject) {
        [_loadV removeloadview];
        [self.taleview.mj_header endRefreshing];
        [self.taleview.mj_footer endRefreshing];
        if ([responseObject[@"code"] integerValue]==1) {
            
            if ([responseObject[@"data"] isEqual:[NSArray array]]) {
                if (_refreshType == NO) {
                    
                    [self.dataarr removeAllObjects];
                    
                    [self.dataarr addObjectsFromArray:responseObject[@"data"]];
                    
                    [self.taleview reloadData];
                }else{
                    
                    [self.dataarr addObjectsFromArray:responseObject[@"data"]];
                    
                    [self.taleview reloadData];
                    
                }
            }
            
        }else{
            
            [MBProgressHUD showError:responseObject[@"message"]];
            [self.taleview reloadData];
        }
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [self.taleview.mj_header endRefreshing];
        [self.taleview.mj_footer endRefreshing];
        [MBProgressHUD showError:error.localizedDescription];
        
    }];
    
}

//下拉刷新
-(void)loadNewData{
    
    _refreshType = NO;
    _page=1;
    
    [self initdatasource];
}
//上啦刷新
-(void)footerrefresh{
    _refreshType = YES;
    _page++;
    
    [self initdatasource];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataarr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    LBMineStoreOrderingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBMineStoreOrderingTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *timestr=[NSString stringWithFormat:@"%@",self.dataarr[indexPath.row][@"time"]];
    
    NSArray *array = [timestr componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
    
    cell.timelb.text = [NSString stringWithFormat:@"%@",array[0]];
    cell.productLb.text = [NSString stringWithFormat:@"%@",self.dataarr[indexPath.row][@"goods_name"]];
    cell.numlb.text = [NSString stringWithFormat:@"%@",self.dataarr[indexPath.row][@"line_money"]];
    
    return cell;
    
    
}

-(NSMutableArray *)dataarr{
    
    if (!_dataarr) {
        _dataarr=[NSMutableArray array];
    }
    
    return _dataarr;
    
}

@end
