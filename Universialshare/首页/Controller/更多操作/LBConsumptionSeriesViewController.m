//
//  LBConsumptionSeriesViewController.m
//  PovertyAlleviation
//
//  Created by 四川三君科技有限公司 on 2017/2/22.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBConsumptionSeriesViewController.h"
#import "LBConsumptionSeriesViewTableViewCell.h"

@interface LBConsumptionSeriesViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)NSArray *imageArr;

@property (strong, nonatomic)NSArray *dataDic;
@property (strong, nonatomic)LoadWaitView *loadV;

@end

@implementation LBConsumptionSeriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.title=@"消费系列";
    
    self.tableview.tableFooterView=[UIView new];
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.bounces=NO;
    // 注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"LBConsumptionSeriesViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBConsumptionSeriesViewTableViewCell"];
    
    [self loadData];//加载数据
    
}

-(void)loadData{
   
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"user/index_alert" paramDic:@{@"type":@"4"} finish:^(id responseObject) {
        [_loadV removeloadview];
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue]==1) {
            
            self.dataDic = responseObject[@"data"];
            
            [self.tableview reloadData];
            
        }else{
            
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [MBProgressHUD showError:error.localizedDescription];
    }];


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataDic.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LBConsumptionSeriesViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBConsumptionSeriesViewTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.imageV.image=[UIImage imageNamed:self.imageArr[indexPath.row]];
    if ([self.dataDic[indexPath.row][@"drivetype"] integerValue] == 6) {
        if (indexPath.row == 0) {
            cell.xiaoFLb.text=[NSString stringWithFormat:@"消费金额: %@元",self.dataDic[indexPath.row][@"amount"]];
            cell.heartLb.text=[NSString stringWithFormat:@"善心总数: %@颗",self.dataDic[indexPath.row][@"lovenumber"]];
            cell.beanLB.text=[NSString stringWithFormat:@"总善行豆: %@颗",self.dataDic[indexPath.row][@"beannum"]];
        }
        
    }else if ([self.dataDic[indexPath.row][@"drivetype"] integerValue] == 12 && indexPath.row == 1){
        
        cell.xiaoFLb.text=[NSString stringWithFormat:@"消费金额: %@元",self.dataDic[indexPath.row][@"amount"]];
        cell.heartLb.text=[NSString stringWithFormat:@"善心总数: %@颗",self.dataDic[indexPath.row][@"lovenumber"]];
        cell.beanLB.text=[NSString stringWithFormat:@"总善行豆: %@颗",self.dataDic[indexPath.row][@"beannum"]];
    
    }else if ([self.dataDic[indexPath.row][@"drivetype"] integerValue] == 24 && indexPath.row == 2){
        
        cell.xiaoFLb.text=[NSString stringWithFormat:@"消费金额: %@元",self.dataDic[indexPath.row][@"amount"]];
        cell.heartLb.text=[NSString stringWithFormat:@"善心总数: %@颗",self.dataDic[indexPath.row][@"lovenumber"]];
        cell.beanLB.text=[NSString stringWithFormat:@"总善行豆: %@颗",self.dataDic[indexPath.row][@"beannum"]];
        
    }
    NSDate * date = [NSDate date];//当前时间
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-MM-dd";//指定转date得日期格式化形式
    NSString *datestr=[dateFormatter stringFromDate:lastDay];
    
    cell.timeLb.text=datestr;
    
    return cell;
    
    
}

-(NSArray*)imageArr{

    if (!_imageArr) {
        _imageArr=[NSArray arrayWithObjects:@"consumption_dirtype_6",@"consumption_dirtype_12",@"consumption_dirtype_24", nil];
    }

    return _imageArr;
}

-(NSArray*)dataDic{
    
    if (!_dataDic) {
        _dataDic=[[NSArray alloc]init];
    }
    
    return _dataDic;
    
}

@end
