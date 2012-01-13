//
//  DestViewController.m
//  LocateDestination
//
//  Created by maesinfo on 12/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DestViewController.h"
#import "toolDefs.h"
#import "LocateDestinationAppDelegate.h"
#import "SettingsForTabController.h"


@implementation DestViewController

//
//-(void) viewDidLoad
//{
//	[super viewDidLoad];
//	
//	self.title = @"FF";
//}

-(void) loadView
{
	[super loadView];
	
	self.title = NSLocalizedString(@"title_dest",nil);
	
	//init table
	float offset_x = SCREEN_WIDTH/20;
	float offset_y = MAIN_VIEW_HEIGHT/10;
	table = [[UITableView alloc]initWithFrame:CGRectMake(offset_x, offset_y, SCREEN_WIDTH-offset_x*2, MAIN_VIEW_HEIGHT-offset_y*2)
										style:UITableViewStyleGrouped];
	table.backgroundColor = self.view.backgroundColor;
	[table setDelegate:self];
	[table setDataSource:self];
	
	[self.view addSubview:table];
	
	
	//	
	//	UIButton  *dst = [UIButton buttonWithType:UIButtonTypeRoundedRect];// alloc]initWithFrame:CGRectMake(100, 100, 160, 40)];
	//	dst.frame = CGRectMake(80, 80, 160, 35);
	//	[dst setTitle:@"Destination" forState:UIControlStateNormal];
	//	[dst addTarget:self action:@selector(goDestination:) forControlEvents:UIControlEventTouchUpInside];
	//	[self.view addSubview:dst];
}

-(IBAction) goDestination:(id)sender
{
	//	if(nil == dstController)
	//	{
	//		dstController = [[settingsDstViewController alloc]init];
	//	}
	//	//	if(self.navigationController.topViewController == self)
	//	[nav pushViewController :dstController animated:YES];
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	SAFE_RELEASE(table);
    [super dealloc];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return MAIN_VIEW_HEIGHT/10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return MAIN_VIEW_HEIGHT/15.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	SettingsForTabController *controller = [[SettingsForTabController alloc] init];
//	LocateDestinationAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//	[delegate.nav pushViewController:controller animated:YES];

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)
//{
//	[tableView didDeselectRowAtIndexPath:indexPath];
//}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(0 == section)
		return 3;
	else if(1 == section)
		return 1;
	else 
		return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
	return 2;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *str=[NSString stringWithFormat:@"RootViewCon%d-%d",indexPath.section,indexPath.row];
	UITableViewCell *cell =(UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:str];
	
	NSLog(@"%@",str);
	// insure the cell exist, or create it
    if (cell == nil) 
	{
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:str];
		cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;	
		//cell = [self initPlantCell:indexPath :str];
		
		CGRect frame = cell.frame;
		frame.origin.x = 0;
		frame.origin.y = 0;
		UILabel  *label = [[UILabel alloc]initWithFrame:frame];
		label.textColor = [UIColor colorWithWhite:0.1f alpha:1.0f];
		label.text = NSLocalizedString(@"string_SetMannual",nil);
		label.textAlignment = UITextAlignmentCenter;
		[cell addSubview:label];
		[label release];
	}
	
	//[self updateCellValue:cell :indexPath];
	
	
    return cell;
}

@end
