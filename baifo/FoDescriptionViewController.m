//
//  FoDescriptionViewController.m
//  baifo
//
//  Created by Hong Liming on 9/16/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "FoDescriptionViewController.h"

@interface FoDescriptionViewController ()

@end

@implementation FoDescriptionViewController
@synthesize imgScreenShot;
@synthesize lblName;
@synthesize lblDescription;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setImgScreenShot:nil];
    [self setLblName:nil];
    [self setLblDescription:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) loadModel:(Model*)fo
{
    self->model = fo;
    lblName.text = fo->name;
    lblDescription.text = fo->description;
    UIImage * image = [UIImage imageNamed:fo->screenShot];
    imgScreenShot.image = image;
    if(!fo->free)
    {
        lblName.alpha = 0.5;
        lblDescription.alpha = 0.5;
        imgScreenShot.alpha = 0.5;
    }
    else
    {
        lblName.alpha = 1;
        lblDescription.alpha = 1;
        imgScreenShot.alpha = 1;
    }
}

- (void)dealloc {
    [imgScreenShot release];
    [lblName release];
    [lblDescription release];
    [super dealloc];
}
@end
