//
//  GLMyBeanCell.h
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLMyBeanModel.h"

@interface GLMyBeanCell : UITableViewCell

@property (nonatomic ,strong)GLMyBeanModel *model;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *persentLabel;

@end
