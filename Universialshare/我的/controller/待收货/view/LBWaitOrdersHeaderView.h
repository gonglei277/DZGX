//
//  LBWaitOrdersHeaderView.h
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/25.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBWaitOrdersModel.h"

typedef void(^GWHeadViewExpandCallback)(BOOL isExpanded);

@interface LBWaitOrdersHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy)GWHeadViewExpandCallback expandCallback;
@property (nonatomic, strong)LBWaitOrdersModel *sectionModel;

@property(nonatomic , strong) UILabel *orderCode;//订单号
@property(nonatomic , strong) UILabel *orderTime;//订单时间
@property(nonatomic , strong) UIView *lineview;
@end
