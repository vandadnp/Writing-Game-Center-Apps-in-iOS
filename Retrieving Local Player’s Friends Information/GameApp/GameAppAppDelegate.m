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

void (^getLocalPlayerFriendsDetails)(void) = ^{
  
  GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
  
  if ([localPlayer isAuthenticated] == NO){
    NSLog(@"The local player is not authenticated.");
    return;
  }
  
  if ([[localPlayer friends] count] == 0){
    NSLog(@"The local player has no friends. How sad!");
    return;
  }
  
  NSLog(@"Loading players...");
  [GKPlayer 
   loadPlayersForIdentifiers:[localPlayer friends]
   withCompletionHandler:^(NSArray *players, NSError *error) {
     
     if (players != nil){
       NSLog(@"Successfully loaded the players.");
       for (GKPlayer *player in players){
         NSLog(@"%@", player);
       }
     }
     
     if (error != nil){
       NSLog(@"Error happened. Error = %@", error);
     }
     
   }];
  
};

void (^getLocalPlayerFriends)(void) = ^{
  
  GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
  
  if ([localPlayer isAuthenticated] == NO){
    NSLog(@"The local player is not authenticated.");
    return;
  }
  
  NSLog(@"Loading local player's friend IDs...");
  [localPlayer loadFriendsWithCompletionHandler:
   ^(NSArray *friends, NSError *error) {
     
     if (friends != nil){
       NSLog(@"Successfully retrieved friends of the local player.");
       
       dispatch_queue_t concurrentQueue = 
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
       dispatch_async(concurrentQueue, getLocalPlayerFriendsDetails);
       
     }
     
     if (error != nil){
       NSLog(@"Error occurred. Error = %@", error);
     }
    
  }];
  
};

- (void) authenticateLocalPlayerAndGetHerInfo{
  
  dispatch_queue_t concurrentQueue = 
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  
  dispatch_async(concurrentQueue, ^(void) {
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    if ([localPlayer isAuthenticated] == NO){
      [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
        if (error == nil){
          NSLog(@"Successfully authenticated.");
          dispatch_async(concurrentQueue, getLocalPlayerFriends);
        } else {
          NSLog(@"Failed to authenticate. Error = %@", error);
        }
      }];
    } else {
      dispatch_async(concurrentQueue, getLocalPlayerFriends);
    }
  });
  
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  [self authenticateLocalPlayerAndGetHerInfo];

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
