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
#import "ChooseModelViewController.h"
#import "BFAppData.h"

@implementation ViewSwitcher;


UIWindow* g_mainWindow;
IntroViewController* g_introViewController;
BFViewController* g_bfViewController;
ChooseModelViewController* g_chooseModelViewController;
UINavigationController* g_navigationController;


+(void)start
{
    g_mainWindow = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    g_bfViewController = [[BFViewController alloc]initWithNibName:@"BFViewController_iPhone" bundle:nil];
    g_introViewController = [[IntroViewController alloc]initWithNibName:@"IntroViewController_iPhone" bundle:nil];
    g_chooseModelViewController = [[ChooseModelViewController alloc]initWithNibName:@"ChooseModelViewController_iPhone" bundle:nil];
    g_navigationController = [[UINavigationController alloc]initWithRootViewController:g_bfViewController];
    g_navigationController.navigationBarHidden = YES;
    
    if([BFAppData isFirstRun])
    {
        [ViewSwitcher switchToIntroView];
    }
    else
    {
        [ViewSwitcher switchToBFView];
    }
    
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
    [g_bfViewController.glView startAnimation];
    g_mainWindow.rootViewController = g_bfViewController;
}


+(void)switchToIntroView
{
    g_mainWindow.rootViewController = g_introViewController;
    [g_bfViewController.glView stopAnimation];
}

+(void)switchToChooseModelView
{
    g_mainWindow.rootViewController = g_chooseModelViewController;
    [g_bfViewController.glView stopAnimation];
}

@end
