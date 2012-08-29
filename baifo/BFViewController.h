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
@property (retain, nonatomic) IBOutlet UIButton *btnSwitchModel;
@property (retain, nonatomic) IBOutlet UIButton *btnSwitchSound;
@property (retain, nonatomic) IBOutlet UIButton *btnShare;
@property (retain, nonatomic) IBOutlet UIButton *btnShowStatus;
@property (retain, nonatomic) IBOutlet UILabel *lblUserCount;
@property (nonatomic, retain) WBEngine *weiBoEngine;

- (IBAction)btnSwitchModelTouched:(id)sender;
- (IBAction)btnSwitchSoundTouched:(id)sender;
- (IBAction)btnShareTouched:(id)sender;
- (IBAction)btnShowStatusTouched:(id)sender;

@end
