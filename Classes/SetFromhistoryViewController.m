//
//  SetFromhistoryViewController.m
//  LocateDestination
//
//  Created by maesinfo on 1/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SetFromhistoryViewController.h"
#import "settingsController.h"
#import "LocateDestinationAppDelegate.h"


@implementation SetFromhistoryViewController
-(id) initWithParent:(UIViewController *)controller
{
	[super init];
	parent = controller;
	
	return self;
}

-(void) loadView
{
	[super loadView];
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.45 green:0.70 blue:0.91 alpha:1.0f];
		
	self.title = NSLocalizedString(@"string_SetDest",nil);
	self.view.backgroundColor = [UIColor whiteColor];
	
	
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
																			  target:self 
																			  action:@selector(goBack:)];
	self.navigationItem.leftBarButtonItem = backItem;

	CGRect frame = self.view.frame;
	frame.origin.y=0;
	table = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
	[table setDelegate:self];
	[table setDataSource:self];

	[self.view addSubview:table];
}

-(void) viewWillAppear:(BOOL)animated
{
	if(table)
	{
		[table reloadData];
	}
}

-(IBAction) goBack:(id)sender
{
	settingsController* ctrller = (settingsController*)parent;
	[ctrller cancelModalView];
}

-(void) dealloc
{
	SAFE_RELEASE(table);
	[super dealloc];
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return MAIN_VIEW_HEIGHT/8.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return MAIN_VIEW_HEIGHT/18.0;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section   // custom view for header. will be adjusted to default or specified header height
//{
//	if(0 == section && !bInput)
//	{
//		if(nil == headerLabel)
//		{
//			CGRect frame = table.frame;
//			frame.origin.x = 0;
//			frame.origin.y = 0;
//			frame.size.height = 20;
//			headerLabel = [[UILabel alloc]initWithFrame:frame];
//			headerLabel.text = NSLocalizedString(@"string_CurrentDest",nil);
//			headerLabel.textAlignment = UITextAlignmentCenter;
//			headerLabel.textColor = [UIColor colorWithWhite:0.0 alpha:1.0];
//			headerLabel.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
//			//			label.layer.opacity = 0.0f;
//			//			[label release];
//		}
//		
//		return headerLabel;
//	}
//	
//	return nil;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section == 1)
	{
		//		SettingsForTabController *controller = [[SettingsForTabController alloc] init];
		//		LocateDestinationAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		//		[delegate.nav pushViewController:controller animated:YES];
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)
//{
//	[tableView didDeselectRowAtIndexPath:indexPath];
//}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	LocateDestinationAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	return [[delegate.dstHandler getHistory] count];
//	if(0 == section)
//		return 4;
//	else if(1 == section)
//		return 1;
//	else 
//		return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
	return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section    // fixed font style. use custom view (UILabel) if you want something different
//{
//	if(section == 0)
//		return @"当前目标点";
//	
//	return nil;
//}

-(UITableViewCell*) getCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath
{
	NSString *str=[NSString stringWithFormat:@"RootViewCon%d-%d",indexPath.section,indexPath.row];
	UITableViewCell *cell =(UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:str];
	SAFE_RELEASE(cell);

	NSLog(@"%@",str);
	LocateDestinationAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	// insure the cell exist, or create it
    if (cell == nil) 
	{
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:str];
		//cell = [self initPlantCell:indexPath :str];
//		cell.textLabel.text = ;

		DestInfoObj *obj = [[delegate.dstHandler getHistory]objectAtIndex:indexPath.row];
		CGRect frame=cell.frame;
		float rate=0.7;
//		frame.origin.x=0;
//		frame.origin.y=0;
//		frame.size.width = SCREEN_WIDTH;
		frame.size.height = cell.frame.size.height * rate;
		UILabel  *name = [[UILabel alloc]initWithFrame:frame];
		name.text = obj.dest.destName;

		frame.origin.y = name.frame.size.height;
		frame.size.height= cell.frame.size.height -name.frame.size.height;
		UILabel  *date = [[UILabel alloc]initWithFrame:frame];
		date.text = obj.timeFirstSet;

		[cell.contentView addSubview:name];
		[cell.contentView addSubview:date];
		[name release];
		[date release];


//		if(indexPath.section == 0)
//		{
//			//init UILabel
//			const float h_rate = 0.28f;
//			const float offset_x = 20;
//			CGRect frame = cell.frame;
//			frame.size.width = table.frame.size.width;
//			frame.origin.x = offset_x;
//			frame.origin.y = 0;
//			frame.size.width *= h_rate;
//			//			frame.size.height -= frame.origin.y * 2;
//			UILabel  *label = [[UILabel alloc]initWithFrame:frame];
//			label.textColor = [UIColor colorWithWhite:0.1f alpha:1.0f];
//			label.textAlignment = UITextAlignmentLeft;
//			label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
//			label.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
//			[cell addSubview:label];
//			[label release];
//			
//			if(!bInput)
//			{
//				if(indexPath.row == 0)
//					label.text = NSLocalizedString(@"string_Name",nil);
//				else if(indexPath.row == 1)
//					label.text = NSLocalizedString(@"string_Latitude",nil);
//				else if(indexPath.row == 2)
//					label.text = NSLocalizedString(@"string_Longitude",nil);
//				else if(indexPath.row == 3)
//					label.text = NSLocalizedString(@"string_Altitude",nil);
//			}
//			else {
//				if(indexPath.row == 0)
//					label.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"string_Name",nil)];
//				else if(indexPath.row == 1)
//					label.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"string_Latitude",nil)];
//				else if(indexPath.row == 2)
//					label.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"string_Longitude",nil)];
//				else if(indexPath.row == 3)
//					label.text =  [NSString stringWithFormat:@"%@:", NSLocalizedString(@"string_Altitude",nil)];
//			}
//			
//			
//			//init UITextField
//			frame.origin.x = frame.size.width+offset_x;
//			frame.size.width = table.frame.size.width * (1-h_rate)-offset_x;
//			//			frame.size.height -= frame.origin.y * 2;
//			int n=indexPath.row;
//			cellInput[n] = [[UIMiddleTextField alloc]initWithFrame:frame];
//			cellInput[n].textColor = [UIColor colorWithWhite:0.1f alpha:1.0f];
//			//		label.textAlignment = UITextAlignmentCenter;
//			//			cellInput[n].baselineAdjustment = UIBaselineAdjustmentAlignCenters;
//			cellInput[n].backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
//			CGRect editingRect = frame;
//			editingRect.origin.y = 10;
//			editingRect.size.height -= editingRect.origin.y * 2;
//			
//			//individualization
//			cellInput[n].enabled = bInput;
//			//			if(bInput)
//			//			{
//			//				cellInput[n].borderStyle = UITextBorderStyleRoundedRect;
//			//			}
//			if(0==indexPath.row)
//			{
//				cellInput[n].keyboardType = UIKeyboardTypeDefault;
//			}
//			else {
//				cellInput[n].keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//			}
//			
//			
//			[cell addSubview:cellInput[n]];
//			[cellInput[n] release];
//			
//		}
//		else if(indexPath.section == 1)
//		{
//			
//			//			[btn release];
//			//			if(indexPath.row ==0)
//			//			{
//			//				label.text = NSLocalizedString(@"string_SetMannual",nil);
//			//			}
//			//			else if (indexPath.row ==1)
//			//			{
//			//				label.text = NSLocalizedString(@"string_SetDest",nil);
//			//			}
//			//			cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;	
//		}
	}
	
	//[self updateCellValue:cell :indexPath];
	
	
    return cell;
	
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [self getCell:tableView indexPath:indexPath];
}


@end
