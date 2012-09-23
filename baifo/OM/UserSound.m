//
//  UserSound.m
//  baifo
//
//  Created by Hong Liming on 8/30/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "UserSound.h"
#import <AVFoundation/AVAudioPlayer.h>

@implementation UserSound

- (id)init
{
    self = [super init];
    if (self)
    {
        self->type = @"caf";
    }
    return self;
}

-(void) beginRecord
{
    if(!self->recorded)
    {
        CFUUIDRef theUUID = CFUUIDCreate(NULL);
        CFStringRef string = CFUUIDCreateString(NULL, theUUID);
        self->resource = [(NSString *)string retain];
        CFRelease(theUUID);
    }
}

-(void) endRecord
{
    if(!self->recorded)
    {
        self->recorded = true;
    }
}

@end
