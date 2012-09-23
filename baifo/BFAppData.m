//
//  BFAppData.m
//  baifo
//
//  Created by Hong Liming on 9/3/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "BFAppData.h"
#import "SoundManager.h"

@implementation BFAppData
NSUserDefaults* g_userDefaults;
+(void)initGlobal
{
    g_userDefaults = [NSUserDefaults standardUserDefaults];
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
+(int)userSoundCount
{
    NSNumber *value = [g_userDefaults objectForKey:@"usersound_count"];
    return (nil == value) ? 0 : value.intValue;
}
+(void)setUserSoundCount:(int)userSoundCount
{
    [g_userDefaults setObject:[NSNumber numberWithInt:userSoundCount] forKey:@"usersound_count"];
}
+(NSString*)userSoundMediaFileName:(int)index
{
    return [g_userDefaults objectForKey:[NSString stringWithFormat:@"usersound_file_%d", index]];
}
+(void)setUserSoundMediaFileName:(NSString*)mediaFileName for:(int)index
{
    [g_userDefaults setObject:mediaFileName forKey:[NSString stringWithFormat:@"usersound_file_%d", index]];
}

@end
