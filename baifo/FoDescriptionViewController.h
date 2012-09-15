//
//  FoDescriptionViewController.h
//  baifo
//
//  Created by Hong Liming on 9/16/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
@interface FoDescriptionViewController : UIViewController
{
    @public
    Model*model;
}
@property (retain, nonatomic) IBOutlet UIImageView *imgScreenShot;
@property (retain, nonatomic) IBOutlet UILabel *lblName;
@property (retain, nonatomic) IBOutlet UILabel *lblDescription;

- (void) loadModel:(Model*)fo;

@end