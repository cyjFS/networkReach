//
//  NetworkReach.h
//  NetworkReach
//
//  Created by newegg on 16/3/21.
//  Copyright © 2016年 code. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Reachability;

@interface NetworkReach : NSObject

@property (nonatomic, readonly) BOOL        isNetReachable;
@property (nonatomic, readonly) BOOL        isHostReach;
@property (nonatomic, strong) Reachability  *hostReach;

- (void)initNetwork;
@end
