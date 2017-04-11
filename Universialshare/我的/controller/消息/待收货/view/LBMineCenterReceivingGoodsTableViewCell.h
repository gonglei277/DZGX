//
//  LBMineCenterReceivingGoodsTableViewCell.h
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/1.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LBMineCenterReceivingGoodsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imagev;

@property (weak, nonatomic) IBOutlet UILabel *cartype;

@property (weak, nonatomic) IBOutlet UILabel *numlb;

@property (weak, nonatomic) IBOutlet UILabel *pricelb;

@property (weak, nonatomic) IBOutlet UIButton *buyBt;
@property (weak, nonatomic) IBOutlet UIButton *SeeBt;

@property (strong, nonatomic) RACSubject *subject;

@end
