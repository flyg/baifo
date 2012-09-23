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
#import "BFAppData.h"

const int MAX_BUILTIN_SOUND = 2;
const int MAX_USER_SOUND = 3;
int recordedUserSoundCount = 0;

@implementation SoundManager

Sound*sounds[MAX_BUILTIN_SOUND+MAX_USER_SOUND];

+(UserSound*) initUnrecordedUserSound
{
    UserSound *sound = [[UserSound alloc]init];
    return sound;
}

+(void) initUserSounds
{
    for (int i=0;i<recordedUserSoundCount;i++)
    {
        UserSound *sound = [[UserSound alloc]init];
        sound->recorded = true;
        sound->resource = [BFAppData userSoundMediaFileName:i];
        sounds[MAX_BUILTIN_SOUND+i]=sound;
    }
    [self addUnrecordedUserSound];
}

+(void) addUnrecordedUserSound
{    
    if (recordedUserSoundCount < MAX_USER_SOUND)
    {
        sounds[MAX_BUILTIN_SOUND+recordedUserSoundCount] = [self initUnrecordedUserSound];
    }
}

+(BuiltInSound*) initBuiltInSound1
{
    BuiltInSound *sound = [[BuiltInSound alloc]init];
    sound->name = @"阿弥陀佛";
    sound->description = @"阿弥陀佛的说明";
    sound->resource = @"emtf";
    sound->type = @"wav";
    return sound;
}

+(BuiltInSound*) initBuiltInSound2
{
    BuiltInSound *sound = [[BuiltInSound alloc]init];
    sound->name = @"弹簧";
    sound->description = @"弹簧的说明";
    sound->resource = @"spring";
    sound->type = @"mp3";
    return sound;
}

+(void) initBuiltInSounds
{
    sounds[0] = [self initBuiltInSound1];
    sounds[1] = [self initBuiltInSound2];
}

+(int) soundIndexMax
{
    return MAX_BUILTIN_SOUND+recordedUserSoundCount+1;
}

+(int) builtinSoundIndexMax
{
    return MAX_BUILTIN_SOUND;
}

+(void) initSounds
{
    recordedUserSoundCount = [BFAppData userSoundCount];
    [self initBuiltInSounds];
    [self initUserSounds];
}
+(Sound*) getSound:(int)index
{
    if (index<0 || index>=MAX_BUILTIN_SOUND+recordedUserSoundCount+1)
    {
        return nil;
    }
    else
    {
        return sounds[index];
    }
}
@end
