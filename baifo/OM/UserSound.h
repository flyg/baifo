//
//  UserSound.h
//  baifo
//
//  Created by Hong Liming on 8/30/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sound.h"

@interface UserSound : Sound
{
@public
    NSString *resource;
    NSString *type;
    bool recorded;
}
-(void) play;

@end
