//
//  GLIntegraClassifyController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/21.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLIntegraClassifyController.h"
#import "GLClassifyCell.h"

@interface GLIntegraClassifyController ()<UICollectionViewDelegate,UICollectionViewDataSource>
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
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GLClassifyCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    self.searchView.layer.cornerRadius = 5.f;
    self.searchView.clipsToBounds = YES;
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//排序
- (IBAction)sortClick:(UIButton *)sender {
    [self.defaultSortBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.integralBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

//筛选
- (IBAction)filterBtn:(id)sender {
    
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
