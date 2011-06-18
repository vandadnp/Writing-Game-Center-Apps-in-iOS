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

- (BOOL) reportScore:(NSUInteger)paramScore
       toLeaderboard:(NSString *)paramLeaderboard{
  
  __block BOOL result = NO;
  
  GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
  
  if ([localPlayer isAuthenticated] == NO){
    NSLog(@"You must authenticate the local player first.");
    return NO;
  }
  
  if ([paramLeaderboard length] == 0){
    NSLog(@"Leaderboard identifier is empty.");
    return NO;
  }
  
  GKScore *score = [[[GKScore alloc] 
                     initWithCategory:paramLeaderboard] autorelease];
  
  score.value = (int64_t)paramScore;
  
  NSLog(@"Attempting to report the score...");
  [score reportScoreWithCompletionHandler:^(NSError *error) {
    if (error == nil){
      NSLog(@"Succeeded in reporting the error.");
      result = YES;
    } else {
      NSLog(@"Failed to report the error. Error = %@", error);
    }
  }];
  
  return result;
  
}

- (void) authenticateLocalPlayerAndReportScore{
  
  GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
  
  if ([localPlayer isAuthenticated] == YES){
    NSLog(@"The local player has already authenticated.");
    return;
  }
  
  [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
    
    if (error == nil){
      NSLog(@"Successfully authenticated the local player.");
      
      [self reportScore:10
          toLeaderboard:@"MGL1LB"];
      
    } else {
      NSLog(@"Failed to authenticate the player with error = %@", error);
    }
    
  }];
  
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  
  [self authenticateLocalPlayerAndReportScore];
  

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
