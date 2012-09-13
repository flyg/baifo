//
//  BFAppData.h
//  baifo
//
//  Created by Hong Liming on 9/3/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFAppData : NSObject
+(void)initGlobal;
+(BOOL)isFirstRun;
+(void)removeIsFirstRunFlag;
+(int)modelIndexCurrent;
+(void)setModelIndexCurrent:(int)modelIndexCurrent;
+(int)soundIndexCurrent;
+(void)setSoundIndexCurrent:(int)soundIndexCurrent;
@end
