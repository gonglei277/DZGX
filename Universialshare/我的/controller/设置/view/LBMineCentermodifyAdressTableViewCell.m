//
//  LBMineCentermodifyAdressTableViewCell.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/30.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineCentermodifyAdressTableViewCell.h"

@implementation LBMineCentermodifyAdressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)setupevent:(UIButton *)sender {
    
    [self.subject sendNext:self.setupBt];
    
}

- (IBAction)deleteEvent:(UIButton *)sender {
    
    [self.subject sendNext:self.deleteBt];
    
}

- (IBAction)editEvent:(UIButton *)sender {
    
    [self.subject sendNext:self.editbt];
    
    
}

// 懒加载
- (RACSubject *)subject {
    if (_subject == nil) {
        _subject = [RACSubject subject];
    }
    
    return _subject;
}

@end
