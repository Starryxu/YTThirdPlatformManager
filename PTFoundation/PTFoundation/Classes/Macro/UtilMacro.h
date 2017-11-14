//
//  UtilMacro.h
//  Pods
//
//  Created by aron on 2017/11/10.
//
//

#ifndef UtilMacro_h
#define UtilMacro_h


#pragma mark - ......::::::: 对象处理 :::::::......

/**
 *  定义单例
 *
 *  @param
 *  使用方法:在.h文件中声明单例，使用AS_SINGLETON  在.m文件中定义单例，使用DEF_SINGLETON
 *  调用方法：使用[单例名称 sharedInstance]
 *
 */
#undef	AS_SINGLETON
#define AS_SINGLETON \
+ (instancetype)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON \
+ (instancetype)sharedInstance{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
} \


#undef	AS_ItemsWithArray
#define AS_ItemsWithArray \
+ (NSMutableArray *)itemsWithArray:(NSArray *)array;

#undef	DEF_ItemsWithArray
#define DEF_ItemsWithArray \
+ (NSMutableArray *)itemsWithArray:(NSArray *)array { \
NSMutableArray *items = [NSMutableArray array]; \
for (NSDictionary *dict in array) { \
id newItem = [self yy_modelWithDictionary:dict]; \
if (newItem) { \
[items addObject:newItem]; \
} \
} \
return items; \
}

#undef	DEF_Coding
#define DEF_Coding \
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; } \
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }


#pragma mark - ......::::::: 字符串处理 :::::::......

// 字符串相关的宏定义
#define validString(x)      (((x) && [(x) isKindOfClass:[NSString class]] && ((NSString *)(x)).length > 0)?((NSString *)(x)):@"")
#define ValueOrEmpty(value) 	((value)?(value):@"")


#pragma mark - ......::::::: 线程处理 :::::::......

// 线程处理相关
static inline void PTOnMainThreadAsync(void (^block)()) {
    if ([NSThread isMainThread]) block();
    else dispatch_async(dispatch_get_main_queue(), block);
}


#pragma mark - ......::::::: 颜色处理 :::::::......

//通用颜色宏定义
//参数格式为：FFFFFF
#define colorWithRGB(rgbValue)  colorWithRGBAndA(rgbValue, 1.0)

//参数格式为：FFFFFF, 1.0
#define colorWithRGBAndA(rgbValue, alphaValue) \
[UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((0x##rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(0x##rgbValue & 0xFF)) / 255.0 alpha:alphaValue]
//参数格式为：FFFFFFFF
#define colorWithARGB(argbValue) \
[UIColor colorWithRed:((float)((0x##argbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((0x##argbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(0x##argbValue & 0xFF)) / 255.0 \
alpha:((float)((0x##argbValue & 0xFF000000) >> 24)) / 255.0]


#pragma mark - ......::::::: 设备信息 :::::::......

static inline CGFloat gScreenHeight() {
    static CGFloat gScreenHeight = 0;
    if (gScreenHeight == 0) {
        gScreenHeight = [UIScreen mainScreen].bounds.size.height;
    }
    return gScreenHeight;
}

static inline CGFloat gScreenWidth() {
    static CGFloat gScreenWidth = 0;
    if (gScreenWidth == 0) {
        gScreenWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return gScreenWidth;
}

static inline CGFloat screenScale() {
    static CGFloat gScreenScale = 0;
    if (gScreenScale == 0) {
        gScreenScale = [UIScreen mainScreen].scale;
        if (gScreenScale == 3 && gScreenWidth() != 414) {
            gScreenScale = 2;
        }
    }
    return gScreenScale;
}

#define kScreenHeight gScreenHeight()    //获取屏幕高度
#define kScreenWidth gScreenWidth()     //获取屏幕宽度
#define kScreenScale screenScale()    //获取屏幕缩放比率

#endif /* UtilMacro_h */
