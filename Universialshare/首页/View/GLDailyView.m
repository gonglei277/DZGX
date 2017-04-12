//
//  GLDailyView.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/11.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLDailyView.h"
#import "GLFirstHeartCell.h"

@interface GLDailyView()


@end

static NSString *ID = @"GLFirstHeartCell";
@implementation GLDailyView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.tableView registerNib:[UINib nibWithNibName:@"GLFirstHeartCell" bundle:nil] forCellReuseIdentifier:ID];
}

#pragma UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLFirstHeartCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.models[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ADAPT(100);
}

@end
