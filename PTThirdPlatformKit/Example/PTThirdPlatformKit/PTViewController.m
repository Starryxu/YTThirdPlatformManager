//
//  PTViewController.m
//  PTThirdPlatformKit
//
//  Created by flypigrmvb on 11/13/2017.
//  Copyright (c) 2017 flypigrmvb. All rights reserved.
//

#import "PTViewController.h"
#import "PTThirdPlatformKit.h"

@interface PTViewController ()

@end

@implementation PTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    typeof(self) __weak weakSelf = self;
    [self addActionWithName:@"QQ登录Demo" callback:^{
        [[PTThirdPlatformManager sharedInstance] signInWithType:PTThirdPlatformTypeTencentQQ fromViewController:weakSelf callback:^(ThirdPlatformUserInfo *userInfo, NSError *err) {
            
        }];
    }];
    
    
    // 分享模型
    ThirdPlatformShareModel* shareModel = [[ThirdPlatformShareModel alloc] init];
    shareModel.image = nil;
    shareModel.imageUrlString = @"";
    shareModel.title = @"title";
    shareModel.text = @"text";
    shareModel.weiboText = @"weibo text";
    shareModel.urlString = @"http://www.baidu.com";
    shareModel.fromViewController = self;
    shareModel.shareResultBlock = ^(PTShareType pplatform, PTShareResult result, NSError * error) {
        
    };
    [self addActionWithName:@"钉钉分享Demo" callback:^{
        shareModel.platform = PTCustumShareTypeDingTalk;
        [[PTThirdPlatformManager sharedInstance] shareWithModel:shareModel];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
