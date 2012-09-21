//
//  ChooseModelViewController.h
//  baifo
//
//  Created by Hong Liming on 9/15/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseModelViewController : UIViewController<UIScrollViewDelegate>

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;
@property(nonatomic,retain) NSMutableArray *viewControllers;
@property (retain, nonatomic) IBOutlet UILabel *lblName;
@property (retain, nonatomic) IBOutlet UILabel *lblDescription;
@property (retain, nonatomic) IBOutlet UIButton *btnLeft;
@property (retain, nonatomic) IBOutlet UIButton *btnRight;
@property (retain, nonatomic) IBOutlet UIButton *btnSelect;

- (IBAction)btnSelectTouched:(id)sender;
- (IBAction)btnLeftTouched:(id)sender;
- (IBAction)btnRightTouched:(id)sender;
- (IBAction)btnCancelTouched:(id)sender;
- (void)switchToCurrentModel;

@end
