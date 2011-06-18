//
//  RootViewController.h
//  Displaying Leaderboards to Users
//
//  Created by Vandad Nahavandipoor on 11-03-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface RootViewController_iPhone : UIViewController 
  <GKMatchmakerViewControllerDelegate, GKMatchDelegate> {
@protected
  GKMatch *acceptedMatch;
    
  UIButton *buttonSendData;
  UITextView *textViewIncomingData;
}

@property (nonatomic, retain) 
  IBOutlet UIButton *buttonSendData;

@property (nonatomic, retain) 
  IBOutlet UITextView *textViewIncomingData;

@property (nonatomic, retain) 
  GKMatch *acceptedMatch;

- (IBAction)buttonSendDataTapped:(id)sender;

@end
