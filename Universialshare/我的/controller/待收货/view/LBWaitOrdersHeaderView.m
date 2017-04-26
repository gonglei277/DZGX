//
//  LBWaitOrdersHeaderView.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/25.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBWaitOrdersHeaderView.h"
#import <Masonry/Masonry.h>

@implementation LBWaitOrdersHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initerface];
    }

    return self;
}

-(void)initerface{
 
    UITapGestureRecognizer *tapgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgestureSection)];
    [self addGestureRecognizer:tapgesture];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.orderCode];
    [self addSubview:self.orderTime];
    [self addSubview:self.lineview];
    
    [self.orderCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-10);
        make.leading.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.height.equalTo(@20);
    }];
    
    [self.orderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-10);
        make.leading.equalTo(self).offset(10);
        make.top.equalTo(self.orderCode.mas_bottom).offset(5);
        make.height.equalTo(@20);
    }];
    [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-10);
        make.leading.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-1);
        make.height.equalTo(@1);
    }];


    

}


-(void)setSectionModel:(LBWaitOrdersModel *)sectionModel{

    if (_sectionModel != sectionModel) {
        _sectionModel = sectionModel;
    }
    
    self.orderCode.text = [NSString stringWithFormat:@"订单号:%@",_sectionModel.order_number];
    self.orderTime.text = [NSString stringWithFormat:@"订单时间:%@",_sectionModel.creat_time];
    

}

-(void)tapgestureSection{
    self.sectionModel.isExpanded = !self.sectionModel.isExpanded;
    if (self.expandCallback) {
        self.expandCallback(self.sectionModel.isExpanded);
    }

}

-(UILabel*)orderCode{
    
    if (!_orderCode) {
        _orderCode=[[UILabel alloc]init];
        _orderCode.backgroundColor=[UIColor clearColor];
        _orderCode.textColor=[UIColor blackColor];
        _orderCode.font=[UIFont systemFontOfSize:13];
        _orderCode.text = @"订单号:";
    }
    
    return _orderCode;
    
}
-(UILabel*)orderTime{
    
    if (!_orderTime) {
        _orderTime=[[UILabel alloc]init];
        _orderTime.backgroundColor=[UIColor clearColor];
        _orderTime.textColor=[UIColor blackColor];
        _orderTime.font=[UIFont systemFontOfSize:13];
        _orderTime.text = @"订单时间:";
        
    }
    
    return _orderTime;
    
}
-(UIView*)lineview{
    
    if (!_lineview) {
        
        _lineview=[[UIView alloc]init];
        _lineview.backgroundColor=[UIColor groupTableViewBackgroundColor];
        
    }
    
    return _lineview;
}
@end
