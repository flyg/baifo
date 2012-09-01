//
//  BFViewController.h
//  baifo
//
//  Created by Hong Liming on 8/25/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLGravityView.h"
#import "WBEngine.h"
#import "WBSendView.h"
#import "WBLogInAlertView.h"
#import "Reachability.h"

@interface BFViewController : UIViewController<WBEngineDelegate, WBSendViewDelegate, WBLogInAlertViewDelegate>
{
@private
    WBEngine *weiBoEngine;
    Reachability *internetReachability;
    NSNumber *modelIndexMax;
    NSNumber *soundIndexMax;
    NSNumber *modelIndexCurrent;
    NSNumber *soundIndexCurrent;
    NSTimer *statusTimer;
}
@property (retain, nonatomic) IBOutlet GLGravityView *glView;
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnSwitchModel;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnSwitchSound;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnShare;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnShowStatus;
@property (retain, nonatomic) IBOutlet UILabel *lblUserCount;
@property (nonatomic, retain) WBEngine *weiBoEngine;
@property (retain, nonatomic) IBOutlet UIView *statusView;
@property (retain, nonatomic) IBOutlet UINavigationBar *statusViewNavBar;
@property (retain, nonatomic) IBOutlet UINavigationItem *statusViewNavItem;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *statusViewNavCloseButton;


- (IBAction)btnSwitchModelTouched:(id)sender;
- (IBAction)btnSwitchSoundTouched:(id)sender;
- (IBAction)btnShareTouched:(id)sender;
- (IBAction)btnShowStatusTouched:(id)sender;
- (IBAction)btnCloseStatusView:(id)sender;

@end
