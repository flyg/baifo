//
//  ViewSwitcher.h
//  ShoppingLover
//
//  Created by Lingkai Kong on 12-7-16.
//  Copyright (c) 2012年 Egibbon Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BFViewController;
@class IntroViewController;


@interface ViewSwitcher : NSObject

+(void)start;
+(void)terminate;

+(void)switchToBFView;
+(void)switchToBFView:(int)modelIndex soundIndex:(int)soundIndex;
+(void)switchToIntroView;
+(void)switchToChooseModelView;
+(void)switchToChooseSoundView;

+(BFViewController*)bfViewController;

@end
