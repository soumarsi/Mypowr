//
//  MMGlobalClass.m
//  OpenCVSample
//
//  Created by Prosenjit Kolay on 30/06/15.
//
//

#import "MMGlobalClass.h"
#import <SystemConfiguration/SystemConfiguration.h>

@implementation MMGlobalClass

- (BOOL) currentNetworkStatus {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    BOOL connected;
    BOOL isConnected;
    const char *host = "www.apple.com";
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host);
    SCNetworkReachabilityFlags flags;
    connected = SCNetworkReachabilityGetFlags(reachability, &flags);
    isConnected = NO;
    isConnected = connected && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
    CFRelease(reachability);
    return isConnected;
}

@end
