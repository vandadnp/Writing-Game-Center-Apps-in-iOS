//
//  GameAppAppDelegate_iPhone.m
//  GameApp
//
//  Created by Vandad Nahavandipoor on 11-03-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameAppAppDelegate_iPhone.h"
#import "RootViewController.h"

@implementation GameAppAppDelegate_iPhone

@synthesize navigationController;

- (BOOL)            application:(UIApplication *)application 
  didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
  
  
  RootViewController *controller = [[RootViewController alloc] initWithNibName:@"RootViewController"
                                                                        bundle:nil];
  UINavigationController *newNavigationController = 
  [[UINavigationController alloc] initWithRootViewController:controller];
  
  [controller release];
  
  navigationController = [newNavigationController retain];
  [newNavigationController release];
  
  [[super window] addSubview:navigationController.view];
  [[super window] makeKeyAndVisible];
  
  return YES;
}

- (void)dealloc
{
  [navigationController release];
	[super dealloc];
}

@end
