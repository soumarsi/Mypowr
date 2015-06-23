//
//  MMAppDelegate.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 09/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMAppDelegate.h"
#import "MMLandingViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation MMAppDelegate
@synthesize allFonts;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //[self getAllFonts];
    allFonts=[[NSMutableArray alloc]init];
    _ImageThumUrlArray=[[NSMutableArray alloc]init];
    
    MMLandingViewController *aft = [[MMLandingViewController alloc] init];
   self.navigationController = [[UINavigationController alloc] initWithRootViewController:aft];
    self.navigationController.navigationBar.hidden= YES;
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
    
    
}
-(void)getAllFonts {
    
    NSLog(@"-(void)getAllFonts");
    
    for(id familyName in [UIFont familyNames]){
        NSLog(@"FontFamily = %@",familyName);
        for(id fontName in [UIFont fontNamesForFamilyName:familyName]){
            [allFonts addObject:fontName];
            NSLog(@"Fonts at family %@ %@",fontName,familyName);
        }
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:self.session];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBAppEvents activateApp];
    
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    //FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBAppCall handleDidBecomeActiveWithSession:self.session];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.session close];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
