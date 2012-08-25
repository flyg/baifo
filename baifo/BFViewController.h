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
    WBEngine *weiBoEngine;
    Reachability *internetReachability;
}
@property (retain, nonatomic) IBOutlet GLGravityView *glView;
@property (retain, nonatomic) IBOutlet UIButton *btnShare;
@property (retain, nonatomic) IBOutlet UIButton *btnChooseModel;
@property (retain, nonatomic) IBOutlet UILabel *lblUserCount;
@property (nonatomic, retain) WBEngine *weiBoEngine;

- (IBAction)btnShareTouched:(id)sender;
- (IBAction)btnChooseModelTouched:(id)sender;

@end
