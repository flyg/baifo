//
//  SoundDescriptionViewController.m
//  baifo
//
//  Created by Hong Liming on 9/21/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "SoundDescriptionViewController.h"
#import "BFAppData.h"
#import "ViewSwitcher.h"
#import "SoundManager.h"
#import "UserSound.h"

@interface SoundDescriptionViewController ()

@end

@implementation SoundDescriptionViewController
@synthesize btnPlay;
@synthesize btnRecord;
@synthesize lblName;

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
    [self setBtnPlay:nil];
    [self setBtnRecord:nil];
    [self setLblName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [btnPlay release];
    [btnRecord release];
    [lblName release];
    [super dealloc];
}

- (void)loadSound:(int)index
{
    Sound*sound=[SoundManager getSound:index];
    self->sound = sound;
    int builinSoundIndexMax = [SoundManager builtinSoundIndexMax];
    if(sound->free)
    {
        lblName.text = sound->name;
        lblName.enabled = true;
        btnPlay.enabled = true;
        btnRecord.hidden = true;
    }
    else if(((UserSound*)sound)->recorded)
    {
        lblName.text = @"自定义声音";
        lblName.enabled = true;
        btnPlay.enabled = true;
        btnRecord.hidden = true;
    }
    else
    {
        lblName.text = @"按住录音";
        lblName.enabled = true;
        btnPlay.hidden = true;
    }
    self->index = index;
}

- (IBAction)btnPlayTouched:(id)sender
{
    [self->sound play];
}

- (IBAction)btnBackgroundTouched:(id)sender
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^
    {
        if(self->index < [SoundManager soundIndexMax])
        {
            [BFAppData setSoundIndexCurrent:self->index];
            dispatch_async(dispatch_get_main_queue(), ^
            {
                [ViewSwitcher switchToBFView:-1 soundIndex:self->index];
            });
        }
    });
}

- (void) refreshSelection:(BOOL)selected
{
    lblName.highlighted = selected;
}
@end
