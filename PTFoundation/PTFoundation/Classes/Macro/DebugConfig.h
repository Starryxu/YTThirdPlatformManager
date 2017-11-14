//
//  DebugConfig.h
//  MobileExperience
//
//  Created by heyuan on 17-3-2.
//  Copyright (c) 2017年 NetDragon. All rights reserved.
//

#ifndef Mmosite_DebugConfig_h
#define Mmosite_DebugConfig_h

// Release模式下禁用NSLog
#if DEBUG
#define NSLog(...)    NSLog(__VA_ARGS__)
#define DBLog(...)    NSLog(@"%s:%d\n%@",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#define DBLog(...)
#endif

///////////////////////////模块调试开关////////////////////////

#ifdef DEBUG

#define kDebugAllNewsMenu

#endif

#ifdef kDebugAllNewsMenu
#define LogAllNewsMenu(...)   NSLog(__VA_ARGS__)
#else
#define LogAllNewsMenu(...)
#endif

#endif
