//
//  GameAppAppDelegate_iPhone.h
//  GameApp
//
//  Created by Vandad Nahavandipoor on 11-03-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameAppAppDelegate.h"

@interface GameAppAppDelegate_iPhone : GameAppAppDelegate {
@protected
  UINavigationController *navigationController;
}

@property (nonatomic, retain) UINavigationController *navigationController;

@end
