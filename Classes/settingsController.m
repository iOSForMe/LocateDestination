//
//  settingsController.m
//  LocateDestination
//
//  Created by maesinfo on 12/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "settingsController.h"
#import "toolDefs.h"
#import "LocateDestinationAppDelegate.h"
#import "SetDestViewController.h"



@implementation settingsController
//
//-(void) viewDidLoad
//{
//	[super viewDidLoad];
//	
//	self.title = @"FF";
//}


//-(void) viewWillAppear:(BOOL)animated
//{
//	[super viewWillAppear:animated];
//
//	LocateDestinationAppDelegate *delegate = [[UIApplication sharedApplication]delegate];
////	[self setDestInfo:[delegate.dstHandler GetCurrentDest]];
//
//}

-(void) loadView
{
	[super loadView];

	//	self.view.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
	self.title = NSLocalizedString(@"title_settings",nil);

	bFirstTime = YES;
	[self initTable:UITableViewStyleGrouped bEnableInput:NO];
//	self.backgroundView.layer.opacity = 0.0f;


	CGRect frame=table.frame;
	frame.origin.y += (frame.size.height+ 50);
	frame.origin.x += 20;
	frame.size.width -= 20 * 2;
	frame.size.height = 38;
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	btn.frame = frame;
	[btn setTitle:NSLocalizedString(@"string_Edit",nil) forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(goEdit:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btn];

//	
//	UIButton  *dst = [UIButton buttonWithType:UIButtonTypeRoundedRect];// alloc]initWithFrame:CGRectMake(100, 100, 160, 40)];
//	dst.frame = CGRectMake(80, 80, 160, 35);
//	[dst setTitle:@"Destination" forState:UIControlStateNormal];
//	[dst addTarget:self action:@selector(goDestination:) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:dst];
}

-(void) initTable:(UITableViewStyle)tableStyle bEnableInput:(BOOL)bEnableInput
{
	[super initTable:tableStyle bEnableInput:bEnableInput];
	table.backgroundView.layer.opacity = 0.0f;

}


//-(IBAction) goDestination:(id)sender
//{
////	if(nil == dstController)
////	{
////		dstController = [[settingsDstViewController alloc]init];
////	}
////	//	if(self.navigationController.topViewController == self)
////	[nav pushViewController :dstController animated:YES];
//}



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

	SAFE_RELEASE(promptView);
	SAFE_RELEASE(setController);
	SAFE_RELEASE(navSetController);
	SAFE_RELEASE(setFromhistoryController);
	SAFE_RELEASE(navSetFromhistoryController);

    [super dealloc];
}

- (IBAction) goEdit:(id)sender
{
	
    promptView =[ [UIActionSheet  alloc ]initWithTitle :
				  NSLocalizedString(@"string_Edit",nil)  delegate : self	 cancelButtonTitle: NSLocalizedString(@"string_Cancel",nil)
								 destructiveButtonTitle :nil otherButtonTitles : NSLocalizedString(@"string_Reset",nil),NSLocalizedString(@"string_SetFromHistory",nil),NSLocalizedString(@"string_Modify",nil),nil ];
	
    promptView.actionSheetStyle 	=UIBarStyleDefault;
	
	
	if( ![ promptView superview])

		[promptView showInView : [[[[UIApplication sharedApplication]

									 keyWindow] subviews ] objectAtIndex: 0 ]];

//	[ promptView setTitle:statusText];
}


- (IBAction)resetDest:(id)sender {
	// Create the root view controller for the navigation controller
	// The new view controller configures a Cancel and Done button for the
	// navigation bar.
	if(nil == setController)
	{
		setController = [[SetDestViewController alloc]init ];
	
		// Configure the RecipeAddViewController. In this case, it reports any
		// changes to a custom delegate object.
		[setController setDelegate : self];

		// Create the navigation controller and present it modally.
		navSetController = [[UINavigationController alloc]
						 initWithRootViewController:setController];
	}
	
	[self presentModalViewController:navSetController animated:YES];

	// The navigation controller is now owned by the current view controller
	// and the root view controller is owned by the navigation controller,
	// so both objects should be released to prevent over-retention.
}

- (IBAction)setFromHistory:(id)sender
{
	NSLog(@"begin set!");
	if(nil == setFromhistoryController)
	{
		setFromhistoryController = [[SetFromhistoryViewController alloc]initWithParent:self ];
		
		navSetFromhistoryController = [[UINavigationController alloc]
							 initWithRootViewController:setFromhistoryController];
//		[setController setDelegate : self];
	}		
		// Create the navigation controller and present it modally.
	
	
	NSLog(@"begin present!");
	[self presentModalViewController:navSetFromhistoryController animated:YES];
	NSLog(@"end present!");
}


-(void)  setDestInfoUI:(struct DestInfo*)info
{
	UIMiddleTextField  *input = [super getCellInput:0];
	if(input)
	{
		NSLog(@"%d",[input retainCount]);
		input.text = info->destName;
		NSLog(@"%d",[input retainCount]);
		input = [super getCellInput:1];
		input.text = [NSString stringWithFormat:@"%0.6f",info->latitude];

		input = [super getCellInput:2];
		input.text = [NSString stringWithFormat:@"%0.6f",info->longitude];
		input = [super getCellInput:3];
		input.text = [NSString stringWithFormat:@"%0.2f m",info->altitude];
	}
}

-(void) cancelModalView
{

	[self dismissModalViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [super getCell:tableView indexPath:indexPath];
	
	if(indexPath.row == 3 && bFirstTime)
	{
		bFirstTime = NO;
		LocateDestinationAppDelegate *delegate = [[UIApplication sharedApplication]delegate];
		[self setDestInfoUI:[delegate.dstHandler GetCurrentDest]];
	}
	return cell;
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(0 == buttonIndex)
	{
		[self resetDest:nil];
	}
	else if(1 == buttonIndex)
	{
		[self setFromHistory:nil];
	}
}


#pragma mark RecipeAddDelegate
- (void)setController:(SetDestViewController *)setDestController
		   didSetDest:(struct DestInfo *)info
{
	if (info) {
		// Add the recipe to the recipes controller.
		[self setDestInfoUI:info];
		LocateDestinationAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		[delegate.dstHandler setDestInfo:info];
//		[table reloadData];
	}
	[self dismissModalViewControllerAnimated:YES];
	[setController emptyUI];
}

@end
