//
//  SoundEffect.m
//  baifo
//
//  Created by Hong Liming on 8/30/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "SoundEffect.h"
#import <AVFoundation/AVAudioPlayer.h>
@implementation SoundEffect
int soundIndexCurrent;
+(void)switchSound:(int)index
{
    soundIndexCurrent = index;
}
+(void)playSound
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^
    {
        NSString *path;
        switch (soundIndexCurrent)
        {
            default:
            case 0:
                path = [[NSBundle mainBundle] pathForResource:@"emtf" ofType:@"wav"];
                break;
            case 1:
                path = [[NSBundle mainBundle] pathForResource:@"spring" ofType:@"mp3"];
                break;
        }
         
        AVAudioPlayer* theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        //theAudio.delegate = self;
        [theAudio play];
    });
}
@end
