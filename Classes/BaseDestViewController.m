//
//  BaseDestViewController.m
//  LocateDestination
//
//  Created by maesinfo on 12/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseDestViewController.h"
#import "toolDefs.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIMiddleTextField

-(CGRect) editingRectForBounds :(CGRect)bounds
{
//	CGRect frame=[self editingRectForBounds:bounds];

	CGRect frame=bounds;
	float h=20;
	frame.origin.y= (frame.size.height-h)/2;
	frame.size.height = h;
	
	return frame;
}

-(CGRect) textRectForBounds :(CGRect)bounds
{
	//	CGRect frame=[self editingRectForBounds:bounds];
	
	CGRect frame=bounds;
	float h=22;
	frame.origin.y= (frame.size.height-h)/2;
	frame.size.height = h;
	
	return frame;
}


@end


@implementation BaseDestViewController

-(UIMiddleTextField*) getCellInput:(int)index
{
	return cellInput[index];
}

-(void) initTable:(UITableViewStyle)tableStyle bEnableInput:(BOOL)bEnableInput
{
	//init table
	bInput = bEnableInput;
	float offset_x = SCREEN_WIDTH/20;
	float offset_y = MAIN_VIEW_HEIGHT/20;
	CGRect frame = CGRectMake(offset_x, offset_y, SCREEN_WIDTH-offset_x*2, MAIN_VIEW_HEIGHT*0.4);
	if(bEnableInput)
	{
		frame.origin.x = 0;
		frame.size.width = SCREEN_WIDTH;
	}
	table = [[UITableView alloc]initWithFrame:frame
										style:tableStyle];
	table.backgroundColor = self.view.backgroundColor;
	table.separatorColor = [UIColor darkGrayColor];
	[table setDelegate:self];
	[table setDataSource:self];
	
	[self.view addSubview:table];
	
}


-(void) dealloc
{
	for(int i=0;i<CELL_NUM;i++)
	{
		SAFE_RELEASE(cellInput[i]);
	}
	SAFE_RELEASE(headerLabel);
	SAFE_RELEASE(table);
	[super dealloc];
}



#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return MAIN_VIEW_HEIGHT/12.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return MAIN_VIEW_HEIGHT/18.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section   // custom view for header. will be adjusted to default or specified header height
{
	if(0 == section && !bInput)
	{
		if(nil == headerLabel)
		{
			CGRect frame = table.frame;
			frame.origin.x = 0;
			frame.origin.y = 0;
			frame.size.height = 20;
			headerLabel = [[UILabel alloc]initWithFrame:frame];
			headerLabel.text = NSLocalizedString(@"string_CurrentDest",nil);
			headerLabel.textAlignment = UITextAlignmentCenter;
			headerLabel.textColor = [UIColor colorWithWhite:0.0 alpha:1.0];
			headerLabel.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
//			label.layer.opacity = 0.0f;
//			[label release];
		}
		
		return headerLabel;
	}
	
	return nil;
}

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
	if(0 == section)
		return 4;
	else if(1 == section)
		return 1;
	else 
		return 0;
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
	
	NSLog(@"%@",str);
	// insure the cell exist, or create it
    if (cell == nil) 
	{
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:str];
		//cell = [self initPlantCell:indexPath :str];
		
		if(indexPath.section == 0)
		{
			//init UILabel
			const float h_rate = 0.28f;
			const float offset_x = 20;
			CGRect frame = cell.frame;
			frame.size.width = table.frame.size.width;
			frame.origin.x = offset_x;
			frame.origin.y = 0;
			frame.size.width *= h_rate;
//			frame.size.height -= frame.origin.y * 2;
			UILabel  *label = [[UILabel alloc]initWithFrame:frame];
			label.textColor = [UIColor colorWithWhite:0.1f alpha:1.0f];
			label.textAlignment = UITextAlignmentLeft;
			label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			label.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
			[cell addSubview:label];
			[label release];
			
			if(!bInput)
			{
				if(indexPath.row == 0)
					label.text = NSLocalizedString(@"string_Name",nil);
				else if(indexPath.row == 1)
					label.text = NSLocalizedString(@"string_Latitude",nil);
				else if(indexPath.row == 2)
					label.text = NSLocalizedString(@"string_Longitude",nil);
				else if(indexPath.row == 3)
					label.text = NSLocalizedString(@"string_Altitude",nil);
			}
			else {
				if(indexPath.row == 0)
					label.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"string_Name",nil)];
				else if(indexPath.row == 1)
					label.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"string_Latitude",nil)];
				else if(indexPath.row == 2)
					label.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"string_Longitude",nil)];
				else if(indexPath.row == 3)
					label.text =  [NSString stringWithFormat:@"%@:", NSLocalizedString(@"string_Altitude",nil)];
			}


			//init UITextField
			frame.origin.x = frame.size.width+offset_x;
			frame.size.width = table.frame.size.width * (1-h_rate)-offset_x;
			//			frame.size.height -= frame.origin.y * 2;
			int n=indexPath.row;
			cellInput[n] = [[UIMiddleTextField alloc]initWithFrame:frame];
			cellInput[n].textColor = [UIColor colorWithWhite:0.1f alpha:1.0f];
			//		label.textAlignment = UITextAlignmentCenter;
//			cellInput[n].baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			cellInput[n].backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
			CGRect editingRect = frame;
			editingRect.origin.y = 10;
			editingRect.size.height -= editingRect.origin.y * 2;

			//individualization
			cellInput[n].enabled = bInput;
//			if(bInput)
//			{
//				cellInput[n].borderStyle = UITextBorderStyleRoundedRect;
//			}
			if(0==indexPath.row)
			{
				cellInput[n].keyboardType = UIKeyboardTypeDefault;
			}
			else {
				cellInput[n].keyboardType = UIKeyboardTypeNumbersAndPunctuation;
			}

			
			[cell addSubview:cellInput[n]];
			[cellInput[n] release];

		}
		else if(indexPath.section == 1)
		{
			
			//			[btn release];
			//			if(indexPath.row ==0)
			//			{
			//				label.text = NSLocalizedString(@"string_SetMannual",nil);
			//			}
			//			else if (indexPath.row ==1)
			//			{
			//				label.text = NSLocalizedString(@"string_SetDest",nil);
			//			}
			//			cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;	
		}
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
