//
//  Header.h
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

#define timea 0.3f

#define YYSRGBColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define TABBARTITLE_COLOR YYSRGBColor(53, 166, 97 , 1.0)

#define autoSizeScaleX (SCREEN_WIDTH/320.f)
#define autoSizeScaleY (SCREEN_HEIGHT/568.f)

#define ADAPT(x) SCREEN_WIDTH / 375 *(x)

#define URL_Base @"http://192.168.0.111/DZGX/api/"
//#define URL_Base @"http://dzgx.joshuaweb.cn/api/"

#define DOWNLOAD_URL @"www.baidu.com"
//米家
#define OrdinaryUser @"10"
//米商
#define Retailer @"9"
//一级销售员
#define ONESALER @"6"
//二级销售员
#define TWOSALER @"7"
//三级销售员
#define THREESALER @"8"


//http://dzgx.joshuaweb.cn/index.php/Home/Regist/index.html
//分享
#define SHARE_URL @"http://dzgx.joshuaweb.cn/index.php/Home/Regist/index.html?mod=member&act=register&username="
#define UMSHARE_APPKEY @"58cf31dcf29d982906001f63"
//微信分享
#define WEIXI_APPKEY @"wx313142c8c6334365"
#define WEIXI_SECRET @"c8b9f2b283c9f50bd61aebed1f04b442"
//微博分享
//#define WEIBO_APPKEY @"2203958313"
//#define WEIBO_SECRET @"9a911777f4b18555cd2b42a9bc186389"
#define WEIBO_APPKEY @"688497271"
#define WEIBO_SECRET @"5d4df0f912e9af331adaf718a357176f"
//虚拟货币名称
#define NormalMoney @"米子"
#define SpecialMoney @"代缴税米子"
//公钥RSA
#define public_RSA @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDF4IeiOMGVERr/4oTZWuthQx+eesKBx70SH5xPavN8s07rFbPf3VQ8yhqsX2TuBhsVz5PDjFyn3NgfJPXr5uVCSu3nONGttK3pnYsIlkHLOQAq3uDl3UwvuDnz6j7Urjxkkonh011o8FZ5pGMSSmGkMVyJ8RVTUIKgcQhNk4VXwIDAQAB"

#define NMUBERS @"0123456789./*-+~!@#$%^&()_+-=,./;'[]{}:<>?`"

#endif /* Header_h */
