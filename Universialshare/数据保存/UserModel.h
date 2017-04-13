//
//  UserModel.h
//  813DeepBreathing
//
//  Created by rimi on 15/8/13.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>
@property (nonatomic, assign) BOOL needAutoLogin;

@property (nonatomic, assign)BOOL   loginstatus;//登陆状态

@property (nonatomic, copy)NSString  *uid;//用户uid
@property (nonatomic, copy)NSString  *phone;//用户手机号
@property (nonatomic, copy)NSString  *name;//用户ID
@property (nonatomic, copy)NSString  *banknumber;//默认银行卡
@property (nonatomic, copy)NSString  *groupId;//用户组id
@property (nonatomic, copy)NSString  *regTime;//注册时间
@property (nonatomic, copy)NSString  *lastTime;//上次登录时间
@property (nonatomic, copy)NSString  *token;//token 校验码
@property (nonatomic, copy)NSString  *headPic;//头像地址
@property (nonatomic, copy)NSString  *mark;//积分
@property (nonatomic, copy)NSString  *loveNum;//爱心数量
@property (nonatomic, copy)NSString  *ketiBean;//志愿豆 可提豆
@property (nonatomic, copy)NSString  *recommendMark;//推荐提成 注册奖励
@property (nonatomic, copy)NSString  *lastFanLiTime;//上次返利时间
@property (nonatomic, copy)NSString  *giveMeMark;//获赠的豆豆
@property (nonatomic, copy)NSString  *version;//版本号
@property (nonatomic, copy)NSString  *vsnUpdateTime;//版本上次更新时间
@property (nonatomic, copy)NSString  *vsnAddress;//版本地址
@property (nonatomic, copy)NSString  *counta;//



+(UserModel*)defaultUser;

@end
