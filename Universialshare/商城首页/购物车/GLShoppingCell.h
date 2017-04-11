//
//  GLShoppingCell.h
//  Universialshare
//
//  Created by 龚磊 on 2017/3/25.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GLShoppingCellDelegate <NSObject>

- (void)changeStatus:(NSInteger)index;

- (void)addNum:(NSInteger)index;

- (void)reduceNum:(NSInteger)index;

@end

@interface GLShoppingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (nonatomic, assign)NSInteger index;
@property (nonatomic, assign)id <GLShoppingCellDelegate>delegate;
@end
