//
//  settingsController.h
//  LocateDestination
//
//  Created by maesinfo on 12/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDestViewController.h"
#import "SetFromhistoryViewController.h"


@class SetDestViewController;

@protocol SetDestDelegate <NSObject>

- (void)setController:(SetDestViewController *)setController
		   didSetDest:(struct DestInfo *)info;
@end


@interface settingsController : BaseDestViewController 
<UIActionSheetDelegate,SetDestDelegate>
{
	SetDestViewController *setController;
	UINavigationController *navSetController;
	SetFromhistoryViewController *setFromhistoryController;
	UINavigationController *navSetFromhistoryController;
	UIActionSheet *promptView;
	
	BOOL  bFirstTime; // update table for first time
}

-(void) cancelModalView;

-(void)  setDestInfoUI:(struct DestInfo*)info;

//-(IBAction) goDestination:(id)sender;
-(IBAction) goEdit:(id)sender;
- (IBAction)resetDest:(id)sender;
- (IBAction)setFromHistory:(id)sender;
@end
