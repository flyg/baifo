//
//  BFAppDelegate.h
//  baifo
//
//  Created by Hong Liming on 8/25/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLGravityView.h"

@class BFViewController;

@interface BFAppDelegate : UIResponder <UIApplicationDelegate, UIAccelerometerDelegate>
{
    UIAccelerationValue accel[3];
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BFViewController *viewController;

@property (strong, nonatomic) GLGravityView *glView;

@end
