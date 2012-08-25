//
//  WebAPIClient.h
//  baifo
//
//  Created by Hong Liming on 8/25/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebAPIClient : NSObject
+(void)initGlobal;
+(void)optInDevice;
+(void)optOutDevice;
+(NSString*)numberOfOnlineUsers;
@end
