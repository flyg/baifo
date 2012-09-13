//
//  BuiltInSound.h
//  baifo
//
//  Created by Hong Liming on 8/30/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sound.h"

@interface BuiltInSound : Sound
{
@public
    NSString *resource;
    NSString *type;
}
-(void) play;

@end
