//
//  SetDestViewController.m
//  LocateDestination
//
//  Created by maesinfo on 12/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SetDestViewController.h"
#import "toolDefs.h"
#import "LocateDestinationAppDelegate.h"


@implementation SetDestViewController
@synthesize delegate;

-(void) loadView
{
	[super loadView];
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.45 green:0.70 blue:0.91 alpha:1.0f];

	CGRect frame = self.view.frame;
	frame.origin.y=0;
	UIButton *btn = [[UIButton alloc]initWithFrame:frame];
	[btn addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btn];
	[btn release];

	[self initTable:UITableViewStylePlain bEnableInput:YES];

	self.title = NSLocalizedString(@"string_SetDest",nil);
	self.view.backgroundColor = [UIColor whiteColor];

	
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
																				 target:self 
																				 action:@selector(goBack:)];
	self.navigationItem.leftBarButtonItem = backItem;

	UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																			  target:self 
																			  action:@selector(goSave:)];
	self.navigationItem.rightBarButtonItem = rightItem;
}

-(void) emptyUI
{
	for(int i=0;i<CELL_NUM;i++)
	{
		UITextField *input=[super getCellInput:i];
		input.text = nil;
	}
//	SAFE_RELEASE(dstInfo.destName);
//	memset(&dstInfo,sizeof(dstInfo),0);
}

-(IBAction) goBack:(id) sender
{
	[delegate setController:self didSetDest:nil];
//	[self emptyUI];
}

-(IBAction) goSave:(id) sender
{
	struct DestInfo *info = [self retrieveDestInfo];
	if(info)
	{
		[delegate setController:self didSetDest:info];
//		[self empty];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"string_Alert",nil) 
													   message:NSLocalizedString(@"string_InvalidInput",nil)
													  delegate:self cancelButtonTitle:NSLocalizedString(@"string_OK",nil) otherButtonTitles:nil];
		
		[alert show];
		
	}

}

-(IBAction) hideKeyboard:(id) sender
{
	for(int i=0;i<CELL_NUM;i++)
	{
		[[super getCellInput:i] resignFirstResponder];
	}
}

-(struct DestInfo*)  retrieveDestInfo
{
	UITextField *textField=[super getCellInput:0];
	if(nil != textField.text)
	{
		dstInfo.destName = textField.text;

		textField = [super getCellInput:1];
		NSScanner *scanner = [[NSScanner alloc ]initWithString:textField.text];
		double dbVal;
		if([scanner scanDouble:&dbVal])
		{
			dstInfo.latitude = dbVal;
			SAFE_RELEASE(scanner);

			textField = [super getCellInput:2];
			scanner = [[NSScanner alloc ]initWithString:textField.text];
			if([scanner scanDouble:&dbVal])
			{
				dstInfo.longitude = dbVal;
				SAFE_RELEASE(scanner);

				textField = [super getCellInput:3];
				scanner = [[NSScanner alloc ]initWithString:textField.text];
				if([scanner scanDouble:&dbVal])
				{
					dstInfo.altitude = dbVal;
					SAFE_RELEASE(scanner);
					return &dstInfo;
				}
			}
		}
		SAFE_RELEASE(scanner);
	}
	
	return nil;
}

-(void) dealloc
{
	SAFE_RELEASE(dstInfo.destName);

	[super dealloc];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return MAIN_VIEW_HEIGHT/10.0;
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	SAFE_RELEASE(alertView);	
}




@end
