//
//  BuiltInSound.m
//  baifo
//
//  Created by Hong Liming on 8/30/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "BuiltInSound.h"
#import <AVFoundation/AVAudioPlayer.h>

@implementation BuiltInSound

-(void)play
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:self->resource ofType:self->type];
        AVAudioPlayer* theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
       [theAudio play];
    });
}

@end
