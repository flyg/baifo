//
//  SoundManager.m
//  baifo
//
//  Created by Hong Liming on 9/14/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "SoundManager.h"
#import "BuiltInSound.h"
#import "UserSound.h"

const int MAX_BUILTIN_SOUND = 2;
const int MAX_USER_SOUND = 3;

@implementation SoundManager

Sound*sounds[MAX_BUILTIN_SOUND+MAX_USER_SOUND];

+(UserSound*) initUserSound:(int)index
{
    UserSound *sound = [[UserSound alloc]init];
    return sound;
}

+(void) initUserSounds
{
    sounds[MAX_BUILTIN_SOUND+0] = [self initUserSound:0];
    sounds[MAX_BUILTIN_SOUND+1] = [self initUserSound:1];
    sounds[MAX_BUILTIN_SOUND+2] = [self initUserSound:2];
}

+(BuiltInSound*) initBuiltInSound1
{
    BuiltInSound *sound = [[BuiltInSound alloc]init];
    sound->name = @"阿弥陀佛";
    sound->description = @"阿弥陀佛的说明";
    sound->resource = @"emtf";
    sound->type = @"wav";
    sound->free = true;
    return sound;
}

+(BuiltInSound*) initBuiltInSound2
{
    BuiltInSound *sound = [[BuiltInSound alloc]init];
    sound->name = @"弹簧";
    sound->description = @"弹簧的说明";
    sound->resource = @"spring";
    sound->type = @"mp3";
    sound->free = true;
    return sound;
}

+(void) initBuiltInSounds
{
    sounds[0] = [self initBuiltInSound1];
    sounds[1] = [self initBuiltInSound2];
}

+(int) soundIndexMax
{
    return MAX_BUILTIN_SOUND+MAX_USER_SOUND;
}

+(int) builtinSoundIndexMax
{
    return MAX_BUILTIN_SOUND;
}

+(void) initSounds
{
    [self initBuiltInSounds];
    [self initUserSounds];
}
+(Sound*) getSound:(int)index
{
    if (index<0 || index>=MAX_BUILTIN_SOUND+MAX_USER_SOUND)
    {
        return nil;
    }
    else
    {
        return sounds[index];
    }
}
@end
