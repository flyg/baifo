//
//  Model.m
//  baifo
//
//  Created by Hong Liming on 9/14/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "Model.h"


@implementation Model
- (void)dealloc
{
    if(nil!=self->name)
    {
        [self->name release];
    }
    if(nil!=self->description)
    {
        [self->description release];
    }
}
@end
