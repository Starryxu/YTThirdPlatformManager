//
//  PTConstants.h
//  Plush
//
//  Created by yuan he on 2017/9/18.
//  Copyright © 2017年 qingot. All rights reserved.
//

#ifndef PTConstants_h
#define PTConstants_h

#define kTopBarHeight               (kNavHeight+kStatBarHeight)
#define kNavHeight                  (44)
#define kSegmentHeaderHeight        (44)
#define kTabbarHeight               (49)
#define kStatBarHeight              (20)
#define kDefaultCellHeight          (60)
#define kDefaultCellFontSize        (16)
#define kDefaultSeparatorLeftMargin (20)
#define kDefaultCellContentMargin   (30)
#define kDefaultSeparatorWidth      (kScreenWidth-2*kDefaultSeparatorLeftMargin)

#define kArrowImageName             @"cell_arrow_right"
#define kPlushPlaceholder           @"roomList_placeholder"
#define kAvatarPlaceholder          @"account_defaultHeader"

#define kCheckImageWidth            (18)
#define kCheckImageSelected         @"myPlush_selected"
#define kCheckImageNormal           @"myPlush_normal"

#define kMusicItemKey   @"MusicItemKey"
#define kSoundItemKey   @"SoundItemKey"
#define kVibrateItemKey @"VibrateItemKey"

static NSString *kAuthScope = @"snsapi_userinfo";
static NSString *kAuthOpenID = @"0c806938e2413ce73eef92cc3";
static NSString *kAuthState = @"xxx";
static NSString *kWXAppID = @"wx78380642630d3e54";
static NSString *kWXAppSecret = @"610f59f161e58dca889054bcf5103125";
static NSString *kTencentAppID = @"1106408873";
static NSString *kTencentAppKey = @"RjJS4GvZTs7bwXiO";
static NSString *kTencentAppSecret = @"";
static NSString *kWeiboAppID = @"1286712227";
static NSString *kWeiboAppKey = @"1982064134";
static NSString *kWeiboAppSecret = @"c5abe691559201e91ce975ee26111e44";
static NSString *kWeiboRedirectURI = @"https://api.weibo.com/oauth2/default.html";
static NSString *kTaklingDataAppID = @"2A989BF58A564064AFB4CE8F71882A7A";//TaklingData统计使用APPID
static NSString *kMTAAppID = @"3203178169";//腾讯移动分析统计使用APPID
static NSString *kMTAAppKey = @"IZA48R1C3IRW";//腾讯移动分析统计使用APPKey

static NSString *kKeyMessageIdentify = @"pt_k_m";
static NSString *kKeyMessageText = @"pt_k_t";

typedef NS_ENUM(NSInteger, PTTextMessageType) {
    PTTextMessageTypeNormal,
    PTTextMessageTypeCatchResult,
    PTTextMessageTypeEnterLeaveRoom,
    PTTextMessageTypeEnterMachine,
};

typedef NS_ENUM(NSInteger, PTLoadType) {
    PTLoadTypeRefresh,
    PTLoadTypeMore,
};

#endif /* PTConstants_h */
