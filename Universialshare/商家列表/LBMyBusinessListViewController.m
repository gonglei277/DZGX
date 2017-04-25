//
//  LBMyBusinessListViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMyBusinessListViewController.h"
#import "LBNybusinessListTableViewCell.h"
#import "LBMyBusinessListDetailViewController.h"
#import <MapKit/MapKit.h>

@interface LBMyBusinessListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tapH;

@property (weak, nonatomic) IBOutlet UIView *navgationView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navigationH;

@end

@implementation LBMyBusinessListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.hidden = NO;
//    self.navigationItem.title = @"商家列表";
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.tableview.tableFooterView = [UIView new];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"LBNybusinessListTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBNybusinessListTableViewCell"];

    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.HideNavB == YES) {
        self.navigationController.navigationBar.hidden = NO;
        self.navigationItem.title = @"商家列表";
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.bottomH.constant = 0;
        self.tapH.constant = 64;
    }else{
        self.navigationController.navigationBar.hidden = YES;
        self.navigationItem.title = @"商家列表";
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.bottomH.constant = 49;
        self.tapH.constant = 0;
    }
    
    if ([[UserModel defaultUser].usrtype isEqualToString:THREESALER]) {
        
        self.navgationView.hidden = NO;
        self.navigationH.constant = 64;
    }else{
        
        if (self.HideNavB == YES) {
            self.navgationView.hidden = YES;
            self.navigationH.constant = 64;
        }else{
            self.navgationView.hidden = YES;
            self.navigationH.constant = 0;
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    return 125;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        LBNybusinessListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBNybusinessListTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.index = indexPath.row;
    
    __weak typeof(self) weakself =self;
    cell.returnGowhere = ^(NSInteger index){
        if (self.HideNavB == YES) {
            double lat = 100.0;double lng = 100.0;
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])// -- 使用 canOpenURL 判断需要在info.plist 的 LSApplicationQueriesSchemes 添加 baidumap 。
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"baidumap://map/geocoder?location=%f,%f&coord_type=bd09ll&src=webapp.rgeo.yourCompanyName.yourAppName",lat,lng]]];
            }else{
                //使用自带地图导航
                
                CLLocationCoordinate2D destCoordinate;
                // 将数据传到反地址编码模型
                destCoordinate = CLLocationCoordinate2DMake(lat,lng);
                
                MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];
                
                MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:destCoordinate addressDictionary:nil]];
                
                [MKMapItem openMapsWithItems:@[currentLocation,toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                                                                           MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
            }

        }else{
        
            if (weakself.returnpushinfovc) {
                weakself.returnpushinfovc(index);
            }
        }
        
    };
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (self.HideNavB == YES) {
        self.hidesBottomBarWhenPushed = YES;
        LBMyBusinessListDetailViewController *vc=[[LBMyBusinessListDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];

    }else{
        if (self.returnpushvc) {
            self.returnpushvc();
        }
    
    }
    
    
}


@end
