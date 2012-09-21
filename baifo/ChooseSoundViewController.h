//
//  ChooseSoundViewController.h
//  baifo
//
//  Created by Hong Liming on 9/21/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundDescriptionViewController.h"

@interface ChooseSoundViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableDictionary* allSoundDescriptionViewControllers;
}
@property (retain, nonatomic) IBOutlet UITableView *tblSounds;
- (IBAction)btnReturnTouched:(id)sender;
- (void)switchToCurrentSound;
@end
