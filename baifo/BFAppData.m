//
//  BFAppData.m
//  baifo
//
//  Created by Hong Liming on 9/3/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "BFAppData.h"

@implementation BFAppData
NSUserDefaults* g_userDefaults;
int g_modelIndexMax;
int g_soundIndexMax;
+(void)initGlobal
{
    g_userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* configFile = [[NSBundle mainBundle]pathForResource:@"config" ofType:@"plist"];
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithContentsOfFile:configFile];
    g_modelIndexMax = ((NSNumber*)[dict objectForKey:@"model_index_max"]).intValue;
    g_soundIndexMax = ((NSNumber*)[dict objectForKey:@"sound_index_max"]).intValue;
}

+(BOOL)isFirstRun
{
    return [g_userDefaults objectForKey:@"first_run"] == nil;
}

+(void)removeIsFirstRunFlag
{
    [g_userDefaults setObject:[NSNumber numberWithInt:1] forKey:@"first_run"];
}

+(int)modelIndexCurrent
{
    NSNumber *value = [g_userDefaults objectForKey:@"model_index_current"];
    return (nil == value) ? 0 : value.intValue;
}
+(void)setModelIndexCurrent:(int)modelIndexCurrent
{
    [g_userDefaults setObject:[NSNumber numberWithInt:modelIndexCurrent] forKey:@"model_index_current"];
}
+(int)soundIndexCurrent
{
    NSNumber *value = [g_userDefaults objectForKey:@"sound_index_current"];
    return (nil == value) ? 0 : value.intValue;
}
+(void)setSoundIndexCurrent:(int)soundIndexCurrent
{
    [g_userDefaults setObject:[NSNumber numberWithInt:soundIndexCurrent] forKey:@"sound_index_current"];
}
+(int)modelIndexMax
{
    return g_modelIndexMax;
}
+(int)soundIndexMax
{
    return g_soundIndexMax;
}

@end
