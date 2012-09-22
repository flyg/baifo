//
//  SoundManager.h
//  baifo
//
//  Created by Hong Liming on 9/14/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sound.h"
@interface SoundManager : NSObject
+(int) soundIndexMax;
+(int) builtinSoundIndexMax;
+(void) initSounds;
+(Sound*) getSound:(int)index;
@end
