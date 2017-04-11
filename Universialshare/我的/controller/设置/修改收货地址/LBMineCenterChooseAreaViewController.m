//
//  LBMineCenterChooseAreaViewController.m
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/30.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "LBMineCenterChooseAreaViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LBMineCenterChooseAreaViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerview;
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;

@property (strong, nonatomic)NSString *resultStr;
@end

@implementation LBMineCenterChooseAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPickerData];
}

#pragma mark - get data
- (void)getPickerData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}

- (IBAction)canelbutton:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LoveConsumptionVC" object:nil];
    
}

- (IBAction)ensurebutton:(UIButton *)sender {
    
    if ([[self.townArray objectAtIndex:[self.pickerview selectedRowInComponent:2]] isEqualToString:@"香港"] ) {
        
        _resultStr = [self.townArray objectAtIndex:[self.pickerview selectedRowInComponent:2]];
    }
  else  if ([[self.townArray objectAtIndex:[self.pickerview selectedRowInComponent:2]] isEqualToString:@"台湾"] ) {
        
        _resultStr = [self.townArray objectAtIndex:[self.pickerview selectedRowInComponent:2]];
    }
  else  if ([[self.townArray objectAtIndex:[self.pickerview selectedRowInComponent:2]] isEqualToString:@"澳门"] ) {
        
        _resultStr = [self.townArray objectAtIndex:[self.pickerview selectedRowInComponent:2]];
    }
    
   else if ([[self.provinceArray objectAtIndex:[self.pickerview selectedRowInComponent:0]] isEqualToString:[self.cityArray objectAtIndex:[self.pickerview selectedRowInComponent:1]]] ) {
        
         _resultStr = [NSString stringWithFormat:@"%@%@",[self.cityArray objectAtIndex:[self.pickerview selectedRowInComponent:1]],[self.townArray objectAtIndex:[self.pickerview selectedRowInComponent:2]]];
    }
   else{
   
       
       _resultStr = [NSString stringWithFormat:@"%@%@%@",[self.provinceArray objectAtIndex:[self.pickerview selectedRowInComponent:0]],[self.cityArray objectAtIndex:[self.pickerview selectedRowInComponent:1]],[self.townArray objectAtIndex:[self.pickerview selectedRowInComponent:2]]];

   }
    
    if (self.returnreslut) {
        self.returnreslut(_resultStr);
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LoveConsumptionVC" object:nil];
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

/**< 行*/
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }    return 0;
}
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *displaylable;
    
    displaylable=[[UILabel alloc]initWithFrame:CGRectMake(0, 1, self.view.bounds.size.width/3+10, 48)];
    displaylable.textAlignment=NSTextAlignmentCenter;
    displaylable.backgroundColor=[UIColor whiteColor];
    displaylable.textColor=[UIColor darkGrayColor];
    displaylable.font=[UIFont boldSystemFontOfSize:14];
    displaylable.numberOfLines=0;
    
    if (component == 0) {
        displaylable.text = [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        displaylable.text = [self.cityArray objectAtIndex:row];
    } else {
        displaylable.text = [self.townArray objectAtIndex:row];
    }
    
    UIView *maskview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/3+10, 50)];
    maskview.backgroundColor=[UIColor whiteColor];
    [maskview addSubview:displaylable];
    
    
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = YYSRGBColor(40, 150, 58, 1);
        }
    }
    
    return maskview;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return self.view.bounds.size.width/3;/**< 宽度*/
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 50;/**< 高度*/
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
    
}


@end
