//
//  BFViewController.m
//  baifo
//
//  Created by Hong Liming on 8/25/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "BFViewController.h"

@interface BFViewController ()

@end

@implementation BFViewController
@synthesize glView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [glView startAnimation];
}

- (void)viewDidUnload
{
    [self setGlView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)dealloc {
    [glView release];
    [super dealloc];
}
@end
