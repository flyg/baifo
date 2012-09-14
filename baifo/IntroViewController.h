//
//  IntroViewController.h
//  baifo
//
//  Created by Hong Liming on 9/3/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroViewController : UIViewController<UIScrollViewDelegate>
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;
@property(nonatomic,retain) NSMutableArray *viewControllers;
- (IBAction)btnStart:(id)sender;

@end
