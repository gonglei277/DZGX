//
//  LBMineCenterReceivingGoodsTableViewCell.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/1.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineCenterReceivingGoodsTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LBWaitOrdersListModel.h"

@implementation LBMineCenterReceivingGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.buyBt.layer.borderWidth = 1;
    self.buyBt.layer.borderColor = YYSRGBColor(191, 0, 0, 1).CGColor;
    
    self.SeeBt.layer.borderWidth = 1;
    self.SeeBt.layer.borderColor = YYSRGBColor(191, 0, 0, 1).CGColor;
}





-(void)setWaitOrdersModel:(LBWaitOrdersListModel *)WaitOrdersModel{
    if (_WaitOrdersModel != WaitOrdersModel) {
        _WaitOrdersModel = WaitOrdersModel;
    }
    
    [self.imagev sd_setImageWithURL:[NSURL URLWithString:_WaitOrdersModel.image_cover] placeholderImage:[UIImage imageNamed:@""]];
    
    self.cartype.text = [NSString stringWithFormat:@"%@",_WaitOrdersModel.goods_name];
    self.numlb.text = [NSString stringWithFormat:@"数量:%@",_WaitOrdersModel.goods_num];
    self.cartype.text = [NSString stringWithFormat:@"价格:%@",_WaitOrdersModel.goods_price];


}


- (IBAction)buyevent:(UIButton *)sender {
    
    [self.delegete BuyAgain:self.index];
}

- (IBAction)SeeEvent:(UIButton *)sender {
    
    [self.delegete checklogistics:self.index];
    
}



@end
