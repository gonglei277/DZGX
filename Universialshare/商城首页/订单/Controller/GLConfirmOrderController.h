//
//  GLConfirmOrderController.h
//  Universialshare
//
//  Created by 龚磊 on 2017/4/1.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "ViewController.h"

@interface GLConfirmOrderController : ViewController

@property (nonatomic, copy)NSString * goods_count;
//订单类型  1:积分订单
@property (nonatomic, assign)int orderType;

@property (nonatomic, copy)NSString * goods_id;

@property (nonatomic, copy)NSString * cart_id;


@end
