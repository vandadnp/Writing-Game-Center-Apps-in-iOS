//
//  RootViewController_iPad.h
//  Displaying Leaderboards to Users
//
//  Created by Vandad Nahavandipoor on 11-03-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface RootViewController_iPad : UIViewController <GKMatchmakerViewControllerDelegate, GKMatchDelegate> {
    
  UITextView *textViewIncomingData;
  UIButton *buttonSendData;
  GKMatch *acceptedMatch;
}
@property (nonatomic, retain) IBOutlet UITextView *textViewIncomingData;
@property (nonatomic, retain) IBOutlet UIButton *buttonSendData;
@property (nonatomic, retain) GKMatch *acceptedMatch;

- (IBAction)buttonSendDataTapped:(id)sender;

@end
