//
//  BFViewController.m
//  baifo
//
//  Created by Hong Liming on 8/25/12.
//  Copyright (c) 2012 Hong Liming. All rights reserved.
//

#import "BFViewController.h"
#import "WebAPIClient.h"

#ifndef kWBSDKDemoAppKey
#define kWBSDKDemoAppKey @"2498986407"
#endif

#ifndef kWBSDKDemoAppSecret
#define kWBSDKDemoAppSecret @"b44ad990fc8c93ff10bed1ba88bbb6ea"
#endif

#define kWBAlertViewLogOutTag 100

@interface BFViewController ()

@end

@implementation BFViewController
@synthesize glView;
@synthesize btnShare;
@synthesize btnChooseModel;
@synthesize lblUserCount;
@synthesize weiBoEngine;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [glView startAnimation];
    internetReachability = [[Reachability reachabilityForInternetConnection]retain];
    
    //set weibo
    WBEngine *engine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
    [engine setRootViewController:self];
    [engine setDelegate:self];
    [engine setRedirectURI:@"http://"];
    [engine setIsUserExclusive:NO];
    self.weiBoEngine = engine;
    [engine release];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^
    {
        [WebAPIClient optInDevice];
        NSString* onlineCount = [[WebAPIClient numberOfOnlineUsers] substringToIndex:10];
        if (![onlineCount isEqualToString:@""])
        {
            dispatch_async(dispatch_get_main_queue(), ^ {
                [lblUserCount setText:[NSString stringWithFormat:@"当前共有%@人同时在拜佛！", onlineCount ]];
            });
        }        
    });
}

- (void)viewDidUnload
{
    [self setGlView:nil];
    [self setBtnShare:nil];
    [self setLblUserCount:nil];
    [self setBtnChooseModel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)dealloc {
    [glView release];
    [btnShare release];
    [lblUserCount release];
    [btnChooseModel release];
    [super dealloc];
}

- (IBAction)btnShareTouched:(id)sender
{
    NetworkStatus internetStatus = [internetReachability currentReachabilityStatus];
    
    if (internetStatus == NotReachable) {
        UIAlertView *alertView;
        alertView = [[UIAlertView alloc] initWithTitle:@"需要网络连接" message:@"需要网络连接访问微博" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alertView.delegate = self;
        [alertView show];
        [alertView release];
    } else {
        
        BOOL isLoggedIn = [weiBoEngine isLoggedIn];
        BOOL isAuthorizeExpired = [weiBoEngine isAuthorizeExpired];
        if (!isLoggedIn || isAuthorizeExpired){
            [weiBoEngine logIn];
        }
        else {
            [self showEditWeiboContent];
        }
    }
}

- (IBAction)btnChooseModelTouched:(id)sender {
}

//set weibo method
-(void)showEditWeiboContent{
    
    NSString *text = @"我正在用拜佛APP拜佛～快来围观！";
   
    WBSendView *sendView = [[WBSendView alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret text:text image:nil];
    [sendView setDelegate:self];
    [text release];
    
    [sendView show:YES];
    [sendView release];
}

#pragma mark - WBLogInAlertViewDelegate Methods
- (void)logInAlertView:(WBLogInAlertView *)alertView logInWithUserID:(NSString *)userID password:(NSString *)password
{
    [weiBoEngine logInUsingUserID:userID password:password];
    
}

#pragma mark - WBEngineDelegate Methods
#pragma mark Authorize
- (void)engineAlreadyLoggedIn:(WBEngine *)engine
{
    if ([engine isUserExclusive])
    {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"请先登出！"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (void)engineDidLogIn:(WBEngine *)engine
{
    [self showEditWeiboContent];
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error
{
    NSLog(@"didFailToLogInWithError: %@", error);
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登录失败！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)engineDidLogOut:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登出成功！"
													  delegate:self
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
    [alertView setTag:kWBAlertViewLogOutTag];
	[alertView show];
	[alertView release];
}

- (void)engineNotAuthorized:(WBEngine *)engine
{
    
}

- (void)engineAuthorizeExpired:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"请重新登录！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

#pragma mark - WBSendViewDelegate Methods
- (void)sendViewDidFinishSending:(WBSendView *)view
{
    [view hide:YES];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"微博发送成功！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)sendView:(WBSendView *)view didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    [view hide:YES];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"微博发送失败！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)sendViewNotAuthorized:(WBSendView *)view
{
    [view hide:YES];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)sendViewAuthorizeExpired:(WBSendView *)view
{
    [view hide:YES];
    
    [self dismissModalViewControllerAnimated:YES];
}
//end of weibo method
@end
