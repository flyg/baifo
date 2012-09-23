//
//  Sound.m
//  baifo
//
//  Created by Hong Liming on 8/30/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "Sound.h"
#import <AVFoundation/AVAudioPlayer.h>

@implementation Sound

- (void)dealloc
{
    if(nil!=self->resource)
    {
        [self->resource release];
    }
    if(nil!=self->type)
    {
        [self->type release];
    }
    if(nil!=self->name)
    {
        [self->name release];
    }
    if(nil!=self->description)
    {
        [self->description release];
    }
    [super dealloc];
}

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
