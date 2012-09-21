//
//  ChooseSoundViewController.h
//  baifo
//
//  Created by Hong Liming on 9/21/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseSoundViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UITableView *tblSounds;
- (IBAction)btnReturnTouched:(id)sender;

@end
