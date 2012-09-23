//
//  BuiltInSound.m
//  baifo
//
//  Created by Hong Liming on 8/30/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "BuiltInSound.h"

@implementation BuiltInSound
- (id)init
{
    self = [super init];
    if (self)
    {
        self->free = true;
    }
    return self;
}
@end
