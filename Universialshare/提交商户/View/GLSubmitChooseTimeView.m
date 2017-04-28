//
//  GLSubmitChooseTimeView.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/28.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLSubmitChooseTimeView.h"

@interface GLSubmitChooseTimeView()
{
    LoadWaitView *_loadV;
}
@property (nonatomic, copy)NSString *currentChoose;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;


@end

@implementation GLSubmitChooseTimeView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.layer.cornerRadius = 5.f;
    self.clipsToBounds = YES;
    
}
- (IBAction)cancel:(id)sender {
}
- (IBAction)ensure:(id)sender {
    
}
#pragma  UIPickerViewDelegate UIPickerViewDataSource

// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.dataArr.count;
}


#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    
    return self.yy_width -20;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 50;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.currentChoose = self.dataArr[row];
    //    self.messageType = row + 1;
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //    NSString *content;
    //    if (_index == 0) {
    //        content = self.dataArr[row];
    //    }else if (_index == 1){
    //    }
    return self.dataArr[row];
}
//-(NSMutableArray *)messageArr{
//
//    if (!_messageArr) {
//        _messageArr=[NSMutableArray array];
//        _messageArr = [NSMutableArray arrayWithObjects:@"nidaye",@"nidaye1",@"niday2e",@"nidaye3",@"nidaye4",@"nidaye5",@"nidaye6",@"nidaye7",@"nidaye8",@"nidaye9", nil];
//    }
//
//    return _messageArr;
//
//}
////重写方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH -20 , 40)];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [pickerLabel setTextColor:[UIColor darkGrayColor]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}



- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithArray:@[@"0:00",@"0:30",@"1:00",@"1:30",@"2:00",@"2:30",@"3:00",@"3:30",@"0:00",@"0:00",@"0:00",@"0:00",@"0:00",@"0:00",@"0:00",@"0:00",@"0:00",@"0:00",@"0:00",@"0:00",@"0:00",@"0:00",@"0:00",@"0:00",]];
    }
    return _dataArr;
}
@end
