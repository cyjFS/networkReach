//
//  NetworkReach.m
//  NetworkReach
//
//  Created by newegg on 16/3/21.
//  Copyright © 2016年 code. All rights reserved.
//

#import "NetworkReach.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#define	kNetworkTestAddress						@"http://www.baidu.com"
#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface NetworkReach ()
{
    NetworkStatus lastNetworkStatus;
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) MBProgressHUD *networkAlert;

@end
@implementation NetworkReach

- (void)dealloc
{
    self.hostReach = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

#pragma mark - 
#pragma mark - Reachability
- (void)initNetwork
{
    
    _isHostReach = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeStatus)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    _hostReach = [Reachability reachabilityWithHostName:kNetworkTestAddress];
    [_hostReach startNotifier];
}


- (void)changeStatus
{
    
    if (_hostReach.currentReachabilityStatus != lastNetworkStatus) {
        if (ReachableViaWiFi == _hostReach.currentReachabilityStatus) {
            [self showWithDetailsLabel:@"wifi环境"];
        }
        else if (ReachableViaWWAN == _hostReach.currentReachabilityStatus)
        {
            [self showWithDetailsLabel:@"2G/3G环境"];
        }
        else
        {
            [self showWithDetailsLabel:@"网络无法连接"];
        }
        
        lastNetworkStatus = _hostReach.currentReachabilityStatus;
    }
}


- (void)showWithDetailsLabel:(NSString *)title {
    HUD = [MBProgressHUD showHUDAddedTo:APP_DELEGATE.window animated:YES];
    HUD.tag = 1000;
    HUD.dimBackground = NO;
    HUD.labelFont = [UIFont systemFontOfSize:14];
    [APP_DELEGATE.window addSubview:HUD];
    HUD.labelText = title;
     HUD.mode = MBProgressHUDModeText;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:3];
}





@end
