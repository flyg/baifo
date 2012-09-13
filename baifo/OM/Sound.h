//
//  Sound.h
//  baifo
//
//  Created by Hong Liming on 8/30/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sound : NSObject
{
@public
    NSString *name;
    NSString *description;
    bool free;
}
-(void)play;

@end
