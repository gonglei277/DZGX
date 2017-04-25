//
//  GLClassifyView.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/25.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLClassifyView.h"
#import "GLClassifyRecommendCell.h"

@interface GLClassifyView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

static NSString *ID = @"GLClassifyRecommendCell";
@implementation GLClassifyView

- (void)awakeFromNib {
    [super awakeFromNib];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 64 - 40) / 3 , 30);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.headerReferenceSize = CGSizeMake(0, SCREEN_HEIGHT / 4);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);//设置section的编距
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"GLClassifyRecommendCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma  UICollectionDelegate UICollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GLClassifyRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    return  cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GLClassifyRecommendCell *cell = (GLClassifyRecommendCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell.titleLabel setTextColor:[UIColor redColor]];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor redColor].CGColor;
}

@end
