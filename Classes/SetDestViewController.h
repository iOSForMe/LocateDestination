//
//  SetDestViewController.h
//  LocateDestination
//
//  Created by maesinfo on 12/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DestHandler.h"
#import "BaseDestViewController.h"
//#import "settingsController.h"

@interface SetDestViewController : BaseDestViewController<UIAlertViewDelegate> {

	struct DestInfo dstInfo;
	UIViewController  *parent;
}
//@property(nonatomic,assign)   id <SetDestDelegate>   delegate;

-(id)initWithParent:(UIViewController*)controller;

-(IBAction) goBack:(id) sender;
-(IBAction) goSave:(id) sender;

-(IBAction) hideKeyboard:(id) sender;

-(struct DestInfo*)  retrieveDestInfo; //freed by the callerf

-(void) emptyUI;

@end
