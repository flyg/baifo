//
//  SoundDescriptionViewController.h
//  baifo
//
//  Created by Hong Liming on 9/21/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sound.h"

@interface SoundDescriptionViewController : UIViewController
{
    @public
    Sound*sound;
    int index;
}
@property (retain, nonatomic) IBOutlet UIButton *btnPlay;
@property (retain, nonatomic) IBOutlet UIButton *btnRecord;
@property (retain, nonatomic) IBOutlet UILabel *lblName;

- (void) loadSound:(Sound*)sound index:(int)index;
- (IBAction)btnPlayTouched:(id)sender;
- (IBAction)btnBackgroundTouched:(id)sender;

@end
