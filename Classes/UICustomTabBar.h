//
//  UICustomTabBar.h
//  LocateDestination
//
//  Created by maesinfo on 12/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "settingsController.h"
#import "locateController.h"
#import "SettingsForTabController.h"
#import "HelpViewController.h"


@interface UICustomTabBar : UITabBarController 
<UITabBarControllerDelegate>
{

	settingsController *settingsCtrller;
	locateController   *locateCtrller;
	HelpViewController *helpController;

	UINavigationController  *nav;
}

@property(nonatomic,retain) UINavigationController *nav;

-(id) initTabBar;

@end
