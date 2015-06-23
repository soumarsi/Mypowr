//
//  MMAppDelegate.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 09/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface MMAppDelegate : UIResponder <UIApplicationDelegate>
@property(nonatomic,retain)  NSMutableArray *ImageThumUrlArray;
@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) FBSession *session;
@property (strong, nonatomic) UINavigationController *navigationController;
@property(nonatomic,retain)  NSMutableArray *allFonts;
@end
