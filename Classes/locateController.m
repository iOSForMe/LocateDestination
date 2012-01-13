//
//  locateController.m
//  LocateDestination
//
//  Created by maesinfo on 12/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "locateController.h"
#import <QuartzCore/QuartzCore.h>
#import "toolDefs.h"
#import "LocateDestinationAppDelegate.h"

#define EARTH_RADIUS  6378.137

double rad(double d)
{
	return d * 3.1415927 / 180.0;
}


@implementation locateController

-(void) loadView
{
	[super loadView];

//	self.title = 	NSLocalizedString(@"title_locate",nil);

	self.view.backgroundColor=[UIColor whiteColor];

	LocateDestinationAppDelegate *delegate=[[UIApplication sharedApplication] delegate];
	float tabHeight=delegate.tabbarController.tabBar.frame.size.height + self.navigationController.navigationBar.frame.size.height;
	currentView = [[LocationView alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, MAIN_VIEW_HEIGHT-70-tabHeight)];
	[self.view addSubview:currentView];

	//
	//	UILabel  *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 160, 40)];
	//	label.textColor = [UIColor colorWithWhite:0.1f alpha:1.0f];
	//	label.text = @"Locating...";
	//	[self.view addSubview:label];
}

-(void) viewDidUnload
{
	NSLog(@"~~~~~~~~ viewDidUnload");
	[locationManager stopUpdatingLocation];

	[super viewDidUnload];
}

-(void) viewWillAppear:(BOOL)animated
{
	NSLog(@"locate:viewWillAppear!");
	
	//################ set the header ########################
	if(nil == refreshItem)
	{
		refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
											target:self 
																	action:@selector(updateLocation:)];
		LocateDestinationAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		delegate.tabbarController.navigationItem.rightBarButtonItem = refreshItem;
		[refreshItem release];
	}
	//################ set the header end! ########################
	
	if(nil ==runningView)
	{
		CGRect frame = self.view.frame;
		frame.origin.y=0;
		runningView = [[UIView alloc] initWithFrame:frame];
		runningView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
		[self.view addSubview:runningView];
		[runningView release];
		
		UIView   *locating = [[UIView alloc]initWithFrame:CGRectMake(100, 120, 120, 120)];
		locating.backgroundColor = [UIColor colorWithWhite:0.3f alpha:0.5f];
		locating.layer.cornerRadius = 8;
		[runningView addSubview:locating];
		[locating release];
		
		UIActivityIndicatorView  *indic = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(40, 40, 40, 40)];
		indic.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
		[indic startAnimating];
		[locating addSubview:indic];
		[indic release];
		
		
		//		resultView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
		//		resultView.backgroundColor = [UIColor colorWithWhite:0.3f alpha:0.3f];
		//		[self.view addSubview:resultView];
		//		[resultView release];
		
		float textHeight=35;
		resultText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, textHeight)];
		resultText.textColor = [UIColor blueColor];
		resultText.textAlignment = UITextAlignmentCenter;
		resultText.adjustsFontSizeToFitWidth = YES;
		resultText.backgroundColor=[UIColor colorWithWhite:0.85f alpha:1.0f];
		[self.view addSubview:resultText];
		[resultText release];
		
		
		altiText = [[UILabel alloc]initWithFrame:CGRectMake(0, textHeight, SCREEN_WIDTH, textHeight)];
		altiText.textColor = [UIColor blueColor];
		altiText.textAlignment = UITextAlignmentCenter;
		altiText.backgroundColor=[UIColor colorWithWhite:0.9f alpha:1.0f];
		[self.view addSubview:altiText];
		[altiText release];
		
	}
	
	[self updateLocation:nil];
	
//	[self.navigationItem setRightBarButtonItem:refreshItem animated:YES];
}

-(void) viewWillDisappear:(BOOL)animated
{
	
	//[self.navigationItem setRightBarButtonItem:nil animated:YES];
//	self.navigationItem.rightBarButtonItem = nil;
	LocateDestinationAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	delegate.tabbarController.navigationItem.rightBarButtonItem = nil;
	refreshItem = nil;

}

-(IBAction)updateLocation:(id) sender
{
	refreshItem.enabled = NO;
	runningView.hidden = NO;
	//	resultView.hidden = YES;
	resultText.hidden = YES;
	altiText.hidden = YES;
	currentView.hidden = YES;
	
	
	if(locationManager == nil)
	{
		locationManager = [[CLLocationManager alloc]init];
		[locationManager setDelegate:self];
	}
	[locationManager startUpdatingLocation];
	
}

-(void) setResult:(NSString *)text :(NSString*)text2
{
	refreshItem.enabled = YES;
	resultText.hidden=NO;
	resultText.text = text;
	if(text2)
	{
		altiText.hidden=NO;
		altiText.text = text2;
	}
	else {
		altiText.hidden = YES;
	}

	currentView.hidden = altiText.hidden;
}

-(void)dealloc
{
	SAFE_RELEASE(currentView);
	SAFE_RELEASE(runningView);
	SAFE_RELEASE(resultText);
	SAFE_RELEASE(altiText);
	SAFE_RELEASE(locationManager);
	
	[super dealloc];
}

#pragma mark -CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	runningView.hidden=YES;
	
	NSLog(@"locate:didUpdateToLocation!");
	
	// 102.54212, 纬31.03198   5025
	LocateDestinationAppDelegate *delegate = [[UIApplication sharedApplication] delegate];

	struct DestInfo *dest = [delegate.dstHandler GetCurrentDest];
	assert(dest);

	const double lat1= dest->latitude;
	const double lng1= dest->longitude;
	//    double lng1＝102.54212;
	const double lat2=newLocation.coordinate.latitude;
	const double lng2=newLocation.coordinate.longitude;
	const double alt = (dest->altitude - newLocation.altitude)/1000;
	
	NSLog(@"%f  %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
	
	double radLat1 = rad(lat1);
	double radLat2 = rad(lat2);
	double a = radLat1 - radLat2;
	double b = rad(lng1) - rad(lng2);
	double s = 2 * asin(sqrt(pow(sin(a/2),2) + 
							 cos(radLat1)*cos(radLat2)*pow(sin(b/2),2)));
	s = s * EARTH_RADIUS;
	s= sqrt(s*s + alt*alt);
	NSString *detail = [NSString stringWithFormat:@"%@：%0.3f km",dest->destName,s];
	NSString *altitu = [NSString stringWithFormat:@"%@：%d m",NSLocalizedString(@"string_CurrentAltitude",nil),(int)newLocation.altitude];
	
	[currentView updateLocation:CGPointMake(lng1, lat1) current:CGPointMake(lng2,lat2)];
	[self setResult:detail :altitu];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	runningView.hidden=YES;
	[self setResult:@"Error!" :nil];
}


@end
