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
    bool recorded;
}

-(void) beginRecord;
-(void) endRecord;

@end
