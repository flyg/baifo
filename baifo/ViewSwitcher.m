//
//  ViewSwitcher.m
//  ShoppingLover
//
//  Created by Lingkai Kong on 12-7-16.
//  Copyright (c) 2012年 Egibbon Inc. All rights reserved.
//

#import "ViewSwitcher.h"
#import "BFViewController.h"
#import "IntroViewController.h"
#import "BFAppData.h"

@implementation ViewSwitcher;


UIWindow* g_mainWindow;
IntroViewController* g_introViewController;
BFViewController* g_bfViewController;
UINavigationController* g_navigationController;


+(void)start
{
    g_mainWindow = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    g_bfViewController = [[BFViewController alloc]initWithNibName:@"BFViewController_iPhone" bundle:nil];
    g_introViewController = [[IntroViewController alloc]initWithNibName:@"IntroViewController_iPhone" bundle:nil];
        
    g_navigationController = [[UINavigationController alloc]initWithRootViewController:g_bfViewController];
    g_navigationController.navigationBarHidden = YES;
    
    g_mainWindow.rootViewController = [BFAppData isFirstRun]?g_introViewController:g_bfViewController;
    
    
    [g_mainWindow makeKeyAndVisible];    
}

+(void)terminate
{
    [g_mainWindow release];
}

+(BFViewController*)bfViewController
{
    return g_bfViewController;
}

+(void)switchToBFView
{
    g_mainWindow.rootViewController = g_bfViewController;
}


+(void)switchToIntroView
{
    g_mainWindow.rootViewController = g_introViewController;
}


@end
