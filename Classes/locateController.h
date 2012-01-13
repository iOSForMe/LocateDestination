//
//  locateController.h
//  LocateDestination
//
//  Created by maesinfo on 12/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationView.h"
#import "BaseViewController.h"

@interface locateController : UIViewController
<CLLocationManagerDelegate>
{
	
	UIView  *runningView;
	//	UIView  *resultView;
	UILabel *resultText;
	UILabel *altiText;
	
	CLLocationManager *locationManager;
	LocationView   *currentView;
	UIBarButtonItem *refreshItem;
}

-(void) setResult:(NSString *)text :(NSString*)text2;

-(IBAction)updateLocation:(id) sender;

@end
