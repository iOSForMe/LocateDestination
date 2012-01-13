//
//  UICustomTabBar.m
//  LocateDestination
//
//  Created by maesinfo on 12/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UICustomTabBar.h"
#import "LocateDestinationAppDelegate.h"
#import "toolDefs.h"


@implementation UICustomTabBar
@synthesize nav;

//-(void) viewDidLoad
//{
//	[super viewDidLoad];
//
//	nav = [[UINavigationController alloc]initWithRootViewController: self];
////	nav.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, MAIN_VIEW_HEIGHT);
//	[nav setNavigationBarHidden:NO animated:NO];
//}

-(id) initTabBar
{
	[self init];

//	LocateDestinationAppDelegate *delegate=[[UIApplication sharedApplication] delegate];
	
	[self setDelegate:self];


	//##################### create view controllers #####################
    NSMutableArray *ctrlArray = [[NSMutableArray alloc]init];
	settingsCtrller = [[settingsController alloc]init];
	locateCtrller   = [[locateController   alloc]init];
	helpController  = [[HelpViewController alloc]init];

	settingsCtrller.title = NSLocalizedString(@"title_settings",nil);
	locateCtrller.title = NSLocalizedString(@"title_locate",nil);
	helpController.title= NSLocalizedString(@"title_help",nil);

	[ctrlArray addObject:settingsCtrller];
	[settingsCtrller release];

	[ctrlArray addObject:locateCtrller];
	[locateCtrller release];
	
	[ctrlArray addObject:helpController];
	[helpController release];


	[self setViewControllers:ctrlArray animated:NO];
	self.title = settingsCtrller.title;

	//####################### comfigure item ##########################
	UITabBarItem  *tmpItem= [[UITabBarItem alloc]initWithTitle:NSLocalizedString(@"title_settings",nil)
														 image:[UIImage imageNamed:@"settings.png"] tag:0];
	settingsCtrller.tabBarItem = tmpItem;
	[tmpItem release];
	
	tmpItem= [[UITabBarItem alloc]initWithTitle:NSLocalizedString(@"title_locate",nil) 
										  image:[UIImage imageNamed:@"locate.png"] tag:1];
	locateCtrller.tabBarItem = tmpItem;
	[tmpItem release];

	tmpItem= [[UITabBarItem alloc]initWithTitle:NSLocalizedString(@"title_help",nil) 
										  image:[UIImage imageNamed:@"help.png"] tag:2];
	helpController.tabBarItem = tmpItem;
	[tmpItem release];
	

	return self;
	
}

-(void) dealloc
{
	[settingsCtrller release];
	[locateCtrller release];
	SAFE_RELEASE(helpController);

	SAFE_RELEASE(nav);

	[super dealloc];
}

#pragma mark -
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)
{
	return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	self.title = viewController.title;
//	if(viewController == locateCtrller)
//	{
//		self.navigationItem.rightBarButtonItem.enabled = NO;
//	}
//	else {
//		self.navigationItem.rightBarButtonItem.enabled = YES;
//	}

}

@end
