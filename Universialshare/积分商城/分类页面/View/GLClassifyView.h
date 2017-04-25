//
//  GLClassifyView.h
//  Universialshare
//
//  Created by 龚磊 on 2017/4/25.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnStringBlock)(NSArray *arr);

@interface GLClassifyView : UIView

@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;

@property (nonatomic, copy) ReturnStringBlock block;

@end
