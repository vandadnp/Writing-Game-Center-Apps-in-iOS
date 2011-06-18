//
//  RootViewController_iPad.m
//  Displaying Leaderboards to Users
//
//  Created by Vandad Nahavandipoor on 11-03-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController_iPad.h"


@implementation RootViewController_iPad
@synthesize buttonSendData;
@synthesize textViewIncomingData;
@synthesize acceptedMatch;

- (void)dealloc{
  [acceptedMatch release];
  [buttonSendData release];
  [textViewIncomingData release];
  [textViewIncomingData release];
  [super dealloc];
}

/* The match received data sent from the player. */
- (void)  match:(GKMatch *)match 
 didReceiveData:(NSData *)data 
     fromPlayer:(NSString *)playerID{
  
  NSLog(@"Incoming data from player ID = %@", playerID);
  
  NSString *incomingDataAsString = 
  [[NSString alloc] initWithData:data 
                        encoding:NSUTF8StringEncoding];
  
  NSString *existingText = self.textViewIncomingData.text;
  
  NSString *finalText = 
  [existingText stringByAppendingFormat:@"\n%@",
   incomingDataAsString];
  
  [self.textViewIncomingData setText:finalText];
  
  [incomingDataAsString release];
  
}


/* The player state changed 
 (eg. connected or disconnected) */
- (void)  match:(GKMatch *)match 
         player:(NSString *)playerID 
 didChangeState:(GKPlayerConnectionState)state{
  
}

/* The match was unable to connect with the 
 player due to an error. */
- (void)              match:(GKMatch *)match 
 connectionWithPlayerFailed:(NSString *)playerID
                  withError:(NSError *)error{
  
}

/* The match was unable to be established 
 with any players due to an error. */
- (void)    match:(GKMatch *)match 
 didFailWithError:(NSError *)error{
  
}

#pragma mark - View lifecycle


- (void)matchmakerViewControllerWasCancelled:
(GKMatchmakerViewController *)viewController{
  
  [self dismissModalViewControllerAnimated:YES];
  
}

/* Matchmaking has failed with an error */
- (void)matchmakerViewController:
(GKMatchmakerViewController *)viewController 
                didFailWithError:(NSError *)error{
  
  [self dismissModalViewControllerAnimated:YES];
  
}

/* A peer-to-peer match has been found, the 
 game should start */
- (void)matchmakerViewController:
(GKMatchmakerViewController *)viewController 
                    didFindMatch:(GKMatch *)paramMatch{
  
  [self dismissModalViewControllerAnimated:YES];
  
  self.acceptedMatch = paramMatch;
  [self.acceptedMatch setDelegate:self];
  
}

/* Players have been found for a server-hosted game, 
 the game should start */
- (void)matchmakerViewController:
(GKMatchmakerViewController *)viewController 
                  didFindPlayers:(NSArray *)playerIDs{
  
  [self dismissModalViewControllerAnimated:YES];
  
}

- (void) setInviteHandler{
  
  [GKMatchmaker sharedMatchmaker].inviteHandler = 
  ^(GKInvite *acceptedInvite, NSArray *playersToInvite) {
    
    if (acceptedInvite != nil){
      
      NSLog(@"An invite came through. process it...");
      
      GKMatchmakerViewController *controller = 
      [[[GKMatchmakerViewController alloc] 
        initWithInvite:acceptedInvite] autorelease];
      
      [controller setMatchmakerDelegate:self];
      [self presentModalViewController:controller
                              animated:YES];
      
    }
    
    else if (playersToInvite != nil){
      
      NSLog(@"Game Centere invoked our game. process the match...");
      
      GKMatchRequest *matchRequest = 
      [[[GKMatchRequest alloc] init] autorelease];
      
      [matchRequest setPlayersToInvite:playersToInvite];
      [matchRequest setMinPlayers:2];
      [matchRequest setMaxPlayers:2];
      
      
      GKMatchmakerViewController *controller = 
      [[[GKMatchmakerViewController alloc] 
        initWithMatchRequest:matchRequest] autorelease];
      
      [controller setMatchmakerDelegate:self];
      [self presentModalViewController:controller
                              animated:YES];
    }
  };
  
}

- (void) viewDidLoad{
  [super viewDidLoad];
  
  GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
  
  [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
    
    if (error == nil){
      
      [self setInviteHandler];
      
      GKMatchRequest *matchRequest = [[GKMatchRequest alloc] init];
      [matchRequest setMinPlayers:2];
      [matchRequest setMaxPlayers:2];
      
      GKMatchmakerViewController *controller = 
      [[GKMatchmakerViewController alloc] 
       initWithMatchRequest:matchRequest];
      
      [controller setMatchmakerDelegate:self];
      
      [matchRequest release];
      
      [self presentModalViewController:controller
                              animated:YES];
      [controller release];
      
    } else {
      NSLog(@"Failed to authenticate the local player %@", error);
    }
    
  }];
  
}

- (void)viewDidUnload{
  self.buttonSendData = nil;
  self.textViewIncomingData = nil;
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return YES;
}

- (IBAction)buttonSendDataTapped:(id)sender {
  
  NSString *dataToSend = 
  [NSString stringWithFormat:@"Date = %@", 
   [NSDate date]];
  
  NSData *data = 
  [dataToSend dataUsingEncoding:NSUTF8StringEncoding];
  
  [self.acceptedMatch 
   sendDataToAllPlayers:data
   withDataMode:GKMatchSendDataReliable
   error:nil];
  
}

@end
