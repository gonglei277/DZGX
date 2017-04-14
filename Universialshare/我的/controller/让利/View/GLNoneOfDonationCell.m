//
//  GLNoneOfDonationCell.m
//  PovertyAlleviation
//
//  Created by gonglei on 17/2/24.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLNoneOfDonationCell.h"

@interface GLNoneOfDonationCell ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *rangliLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;



@end


@implementation GLNoneOfDonationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(GLNoneOfDonationModel *)model {
    _model = model;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *currentDate = [dateFormatter dateFromString:model.time];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSString *timeStr = [dateFormatter1 stringFromDate:currentDate];
    
    self.dateLabel.text = timeStr;
    self.sellNumLabel.text = model.market;
    self.rangliLabel.text = model.rl_money;
   
    
    if([model.status isEqualToString:@""]){
        
    }
}


@end
