//
//  ChooseModelViewController.m
//  baifo
//
//  Created by Hong Liming on 9/15/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "ChooseModelViewController.h"
#import "ModelManager.h"
#import "ViewSwitcher.h"
#import "BFAppData.h"

@interface ChooseModelViewController ()

@end

@implementation ChooseModelViewController
@synthesize scrollView;
@synthesize pageControl;
@synthesize viewControllers;
@synthesize lblName;
@synthesize lblDescription;
@synthesize btnLeft;
@synthesize btnRight;

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
    int modelIndexMax = [ModelManager modelIndexMax];
    NSMutableArray *views = [[NSMutableArray alloc]initWithCapacity: modelIndexMax];
    for (unsigned i = 0; i < modelIndexMax; i++)
    {
		[views addObject:[NSNull null]];
    }
    self.viewControllers = views;
    [views release];
    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * modelIndexMax, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = modelIndexMax;
    pageControl.currentPage = 0;
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    [self fixNavigationButtons];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPageControl:nil];
    [self setLblName:nil];
    [self setLblDescription:nil];
    [self setBtnLeft:nil];
    [self setBtnRight:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [scrollView release];
    [pageControl release];
    [lblName release];
    [lblDescription release];
    [btnLeft release];
    [btnRight release];
    [super dealloc];
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= self.viewControllers.count)
        return;
    
    // replace the placeholder if necessary
    UIView *stepView = [viewControllers objectAtIndex:page];
    if ((NSNull *)stepView == [NSNull null]) {
        Model *currentModel = [ModelManager getModel:page];
        if(nil != currentModel)
        {
            NSArray *updateStepViews = [[NSBundle mainBundle] loadNibNamed:@"FoDescriptionPages_iPhone" owner:self options:nil];
            stepView = [updateStepViews objectAtIndex:page];
            [viewControllers replaceObjectAtIndex:page withObject:stepView];
        }
    }
    
    // add the controller's view to the scroll view
    if (stepView.superview == nil)
    {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        stepView.frame = frame;
        [scrollView addSubview:stepView];
    }
}

- (void)setPage:(int)page
{
    pageControl.currentPage = page;
    [self fixNavigationButtons];
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:pageControl.currentPage - 1];
    [self loadScrollViewWithPage:pageControl.currentPage];
    [self loadScrollViewWithPage:pageControl.currentPage + 1];
}

- (void)gotoPage:(int)page
{
    [self setPage:page];
    CGPoint point;
    point.x = page * scrollView.frame.size.width;
    point.y = 0;
    [scrollView setContentOffset:point animated:true];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self setPage:page];
}

- (IBAction)btnSelectTouched:(id)sender
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^
    {
        [BFAppData setModelIndexCurrent:pageControl.currentPage];
    });
    [ViewSwitcher switchToBFView:pageControl.currentPage];
}

- (IBAction)btnLeftTouched:(id)sender
{
    [self gotoPage: pageControl.currentPage - 1];
}

- (IBAction)btnRightTouched:(id)sender
{
    [self gotoPage: pageControl.currentPage + 1];
}

-(void)fixNavigationButtons
{
    btnLeft.enabled = pageControl.currentPage > 0;
    btnRight.enabled = pageControl.currentPage < [ModelManager modelIndexMax]-1;
}

@end
