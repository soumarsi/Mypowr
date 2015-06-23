#import "AppDelegate.h"
#import "ColorCircleViewController.h"
#import "DetectSmileViewController.h"
#import "TryYourselfViewController.h"
#import "MMLandingViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MeterViewController.h"

@implementation AppDelegate

@synthesize CircleArray,individualCircleDataDict;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
   
    _CirclePeripheral1PointsXDataArray=[[NSMutableArray alloc]init];
    _CirclePeripheral1PointsYDataArray=[[NSMutableArray alloc]init];
    
    
    _CirclePeripheral2PointsXDataArray=[[NSMutableArray alloc]init];
    _CirclePeripheral2PointsYDataArray=[[NSMutableArray alloc]init];
    
    
    _CirclePeripheral3PointsXDataArray=[[NSMutableArray alloc]init];
    _CirclePeripheral3PointsYDataArray=[[NSMutableArray alloc]init];
    
    _CirclePeripheral4PointsXDataArray=[[NSMutableArray alloc]init];
    _CirclePeripheral4PointsYDataArray=[[NSMutableArray alloc]init];
    
    _CirclePeripheral5PointsXDataArray=[[NSMutableArray alloc]init];
    _CirclePeripheral5PointsYDataArray=[[NSMutableArray alloc]init];
    _CenterArray=[[NSMutableArray alloc]init];

    /*
     (
     117,
     169,
     29,
     
     49,
     169,
     31,
     
     247,
     173,
     27,
     
     177,
     169,
     31,
     
     311,
     171,
     32
     )*/
    

    
   

//    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    _window.rootViewController = [ColorCircleViewController new];
//    //_window.rootViewController = [DetectSmileViewController new];
////    _window.rootViewController = [TryYourselfViewController new];
//    [_window makeKeyAndVisible];
//    return YES;
       _ImageThumUrlArray=[[NSMutableArray alloc]init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    //ColorCircleViewController *aft = [[ColorCircleViewController alloc] init];
    //_menuNavController = [[UINavigationController alloc] initWithRootViewController:aft];
    //_menuNavController.navigationBar.hidden= YES;
    //self.window.rootViewController = _menuNavController;
    
    MMLandingViewController *aft = [[MMLandingViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:aft];
    self.navigationController.navigationBar.hidden= YES;
    self.window.rootViewController = self.navigationController;
    
//    MeterViewController *aft = [[MeterViewController alloc] init];
//    self.navigationController = [[UINavigationController alloc] initWithRootViewController:aft];
//    self.navigationController.navigationBar.hidden= YES;
//    self.window.rootViewController = self.navigationController;
    
    [self.window makeKeyAndVisible];
    return YES;
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