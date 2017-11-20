//
//  PTDingTalkRequestHandler.m
//  
//
//  Created by aron on 2017/11/20.
//
//

#import "PTDingTalkRequestHandler.h"
#import <DTShareKit/DTOpenKit.h>
#import "PTThirdPlatformKit.h"

@implementation PTDingTalkRequestHandler

// 分享
+ (BOOL)sendMessageWithModel:(ThirdPlatformShareModel *)model {
    
    DTMediaWebObject* obj;
    obj = [[DTMediaWebObject alloc] init];
    obj.pageURL = ValueOrEmpty(model.urlString);
    
    DTMediaMessage* msg = [[DTMediaMessage alloc] init];
    msg.mediaObject = obj;
    msg.title = model.title;
    msg.thumbURL = model.imageUrlString;
    msg.messageDescription = model.text;
    
    DTSendMessageToDingTalkReq *req = [[DTSendMessageToDingTalkReq alloc] init];
    req.scene = DTSceneSession;
    req.message = msg;
    
    BOOL result = [DTOpenAPI sendReq:req];
    
    return result;
}

@end

