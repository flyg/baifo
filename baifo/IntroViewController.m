//
//  IntroViewController.m
//  baifo
//
//  Created by Hong Liming on 9/3/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "IntroViewController.h"
#import "ViewSwitcher.h"

@interface IntroViewController ()

@end

@implementation IntroViewController
@synthesize scrollView;
@synthesize pageControl;
@synthesize viewControllers;

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
    NSArray *updateStepViews = [[NSBundle mainBundle] loadNibNamed:@"IntroPages_iPhone" owner:self options:nil];
    
    NSMutableArray *views = [[NSMutableArray alloc] init];
    NSInteger viewCount = [updateStepViews count];
    for (unsigned i = 0; i < viewCount; i++)
    {
		[views addObject:[NSNull null]];
    }
    self.viewControllers = views;
    [views release];
    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * viewCount, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = viewCount;
    pageControl.currentPage = 0;

    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

- (void)viewDidUnload
{
    [self setPageControl:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)dealloc {
    [pageControl release];
    [scrollView release];
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
        NSArray *updateStepViews = [[NSBundle mainBundle] loadNibNamed:@"IntroPages_iPhone" owner:self options:nil];
        stepView = [updateStepViews objectAtIndex:page];
        [viewControllers replaceObjectAtIndex:page withObject:stepView];
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

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

- (IBAction)changePage:(id)sender
{
    int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];    
}

- (IBAction)btnStart:(id)sender
{
    [ViewSwitcher switchToBFView];
    pageControl.currentPage = 0;
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];

}

@end
