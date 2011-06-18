//
//  GameAppAppDelegate.m
//  GameApp
//
//  Created by Vandad Nahavandipoor on 11-03-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameAppAppDelegate.h"

@implementation GameAppAppDelegate


@synthesize window=_window;


- (void) authenticateLocalPlayerAndReportScore{
  
  GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
  
  if ([localPlayer isAuthenticated] == YES){
    NSLog(@"The local player has already authenticated.");
    return;
  }
  
  [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
    
    if (error == nil){
      NSLog(@"Successfully authenticated the local player.");
      
      
      
    } else {
      NSLog(@"Failed to authenticate the player with error = %@", error);
    }
    
  }];
  
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
  
  NSLog(@"Authenticating the local player...");
  [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
    
    if (error == nil){
      
      NSLog(@"Successfully authenticated the local player.");
      GKLeaderboard *leaderboard = 
        [[[GKLeaderboard alloc] init] autorelease];
      
      [leaderboard setCategory:@"MGL1LB"];
      NSLog(@"Loading the scores in leaderboard...");
      [leaderboard loadScoresWithCompletionHandler:
       ^(NSArray *scores, NSError *error) {
        
         if (scores != nil){
           for (GKScore *score in scores){
             NSLog(@"%@", score);
           }
         }
         
         if (error != nil){
           NSLog(@"Error occurred = %@", error);
         }
         
      }];
      
    } else {
      NSLog(@"Failed to authenticate with error = %@", error);
    }
    
  }];
  
  
  

  // Override point for customization after application launch.
  [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  /*
   Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  /*
   Called when the application is about to terminate.
   Save data if appropriate.
   See also applicationDidEnterBackground:.
   */
}

- (void)dealloc
{
  [_window release];
    [super dealloc];
}

@end
