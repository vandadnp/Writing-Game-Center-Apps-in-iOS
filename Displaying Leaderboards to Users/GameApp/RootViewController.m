//
//  RootViewController.m
//  Displaying Leaderboards to Users
//
//  Created by Vandad Nahavandipoor on 11-03-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)leaderboardViewControllerDidFinish:
  (GKLeaderboardViewController *)viewController{
  
  /* We are finished here */
  [self dismissModalViewControllerAnimated:YES];
  
}

- (void) viewDidLoad{
  
  [super viewDidLoad];
  
  GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
  
  [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
    
    if (error == nil){
      
      GKLeaderboardViewController *controller = 
        [[GKLeaderboardViewController alloc] init];
      
      /* The category for our leaderboard. We created this before */
      [controller setCategory:@"MGL1LB"];
      /* Only show the scores that were submitted this week */
      [controller setTimeScope:GKLeaderboardTimeScopeWeek];
      [controller setLeaderboardDelegate:self];
      [self presentModalViewController:controller
                              animated:YES];
      [controller release];
      
    } else {
      NSLog(@"Could not authenticate the local player. Error = %@", error);
    }
    
  }];
  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
