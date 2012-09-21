//
//  ChooseSoundViewController.m
//  baifo
//
//  Created by Hong Liming on 9/21/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "ChooseSoundViewController.h"
#import "SoundDescriptionViewController.h"
#import "SoundManager.h"
#import "BFAppData.h"
#import "ViewSwitcher.h"

@interface ChooseSoundViewController ()

@end

@implementation ChooseSoundViewController
@synthesize tblSounds;

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
    [self setTblSounds:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [tblSounds release];
    [super dealloc];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SoundManager soundIndexMax];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SoundDescriptionViewController *soundDescriptionViewController = [[SoundDescriptionViewController alloc]initWithNibName:@"SoundDescriptionView_iPhone" bundle:nil];
    Sound*sound = [SoundManager getSound:indexPath.row];
    // initialize the view
    soundDescriptionViewController.view;
    [soundDescriptionViewController loadSound:sound index:indexPath.row];
    return (UITableViewCell*)soundDescriptionViewController.view;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   return 60;
//}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^
    {
        [BFAppData setSoundIndexCurrent:indexPath.row];
    });
    [ViewSwitcher switchToBFView:-1 soundIndex:indexPath.row];
}
- (IBAction)btnReturnTouched:(id)sender
{
    [ViewSwitcher switchToBFView];
}
@end
