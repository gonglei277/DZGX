//
//  GLIntegralMallTopCell.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/1.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLIntegralMallTopCell.h"
@interface GLIntegralMallTopCell ()
@property (weak, nonatomic) IBOutlet UILabel *jifenLabel;
@property (weak, nonatomic) IBOutlet UILabel *jifenLabel2;
@property (weak, nonatomic) IBOutlet UILabel *jifenLabel3;


@end

@implementation GLIntegralMallTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self changeColor:self.jifenLabel rangeNumber:2666];
    [self changeColor:self.jifenLabel2 rangeNumber:2666];
    [self changeColor:self.jifenLabel3 rangeNumber:2666];
    
}

- (void)changeColor:(UILabel*)label rangeNumber:(NSInteger )rangeNum
{
    NSString *remainBeans = [NSString stringWithFormat:@"%lu",rangeNum];
    NSString *totalStr = [NSString stringWithFormat:@"%@积分",remainBeans];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:totalStr];
    NSRange rangel = [[textColor string] rangeOfString:remainBeans];
    [textColor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rangel];
    [textColor addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:rangel];
    [label setAttributedText:textColor];
}


@end
