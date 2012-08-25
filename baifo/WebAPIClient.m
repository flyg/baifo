//
//  WebAPIClient.m
//  baifo
//
//  Created by Hong Liming on 8/25/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "WebAPIClient.h"

@implementation WebAPIClient
NSString* g_serverAddress;
NSString* g_deviceId;
+(void)initGlobal
{
    NSString* configFile = [[NSBundle mainBundle]pathForResource:@"config" ofType:@"plist"];
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithContentsOfFile:configFile];
    
    g_serverAddress = [[dict objectForKey:@"server"]retain];
    NSLog(@"Server address: %@", g_serverAddress);
    
    g_deviceId = [[[UIDevice currentDevice] uniqueIdentifier]retain];
    NSLog(@"DeviceID: %@", g_deviceId);
}

+(NSString*)send:(NSString*)requestString httpMethod:(NSString*)httpMethod
{
    NSString* url = [NSString stringWithFormat:@"http://%@/baifo/stat/%@?UID=%@", g_serverAddress, requestString, g_deviceId];
    NSLog(@"Requesting url: %@", url);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]  initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:httpMethod];
    [request setCachePolicy:NSURLCacheStorageNotAllowed];
    [request setTimeoutInterval:3.0];
    NSURLResponse* response;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSLog(@"Data loaded: %d bytes", [data length]);
    
    NSString* text =[[NSString alloc]initWithData:data encoding:NSStringEncodingConversionAllowLossy];
    NSString* returnText = [NSString stringWithString:text];
    [text release];
    return returnText;
}

   
+(void)optInDevice
{
    [WebAPIClient send:@"OptIn" httpMethod:@"POST"];
}
+(void)optOutDevice
{
    [WebAPIClient send:@"OptOut" httpMethod:@"POST"];
}
+(NSString*)numberOfOnlineUsers
{
    return [WebAPIClient send:@"Count" httpMethod:@"GET"];
}
@end
