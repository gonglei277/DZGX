//
//  GLIntegraClassifyController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/21.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLIntegraClassifyController.h"
#import "GLClassifyCell.h"
#import "GLSet_MaskVeiw.h"
#import "GLClassifyView.h"

@interface GLIntegraClassifyController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    GLSet_MaskVeiw *_maskV;
    GLClassifyView *_contentV;
    
}
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *searchView;


@property (weak, nonatomic) IBOutlet UIButton *defaultSortBtn;
@property (weak, nonatomic) IBOutlet UIButton *integralBtn;

@end

static NSString *ID = @"GLClassifyCell";
@implementation GLIntegraClassifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.backBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 20)];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH /2 - 0.5, 230 * autoSizeScaleY);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    self.collectionView.collectionViewLayout = layout;
    
    self.searchView.layer.cornerRadius = self.searchView.yy_height / 2;
    self.searchView.clipsToBounds = YES;
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GLClassifyCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:@"maskView_dismiss" object:nil];
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        _contentV.frame = CGRectMake(SCREEN_WIDTH, 64, 0, SCREEN_HEIGHT - 64);
        
    }completion:^(BOOL finished) {
        
        [_maskV removeFromSuperview];
    }];

}
//排序
- (IBAction)sortClick:(UIButton *)sender {
    [self.defaultSortBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.integralBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

//筛选
- (IBAction)filterBtn:(id)sender {
    _maskV = [[GLSet_MaskVeiw alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _maskV.bgView.alpha = 0.3;
    
    _contentV = [[NSBundle mainBundle] loadNibNamed:@"GLClassifyView" owner:nil options:nil].lastObject;
    _contentV.block = ^(NSArray *arr){
        NSLog(@"arr =  == = = =  = ===%@",arr);
    };
//    [_contentV.ensureBtn addTarget:self action:@selector(ensureClassify) forControlEvents:UIControlEventTouchUpInside];
    
    _contentV.frame = CGRectMake(SCREEN_WIDTH, 64, 0, SCREEN_HEIGHT - 64);
    [_maskV showViewWithContentView:_contentV];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        _contentV.frame = CGRectMake(64, 64 , SCREEN_WIDTH - 64, SCREEN_HEIGHT - 64);
        
    }];
    
}

#pragma UICollectionDelegate UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GLClassifyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    return cell;
}
@end
