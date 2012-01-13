//
//  BaseDestViewController.h
//  LocateDestination
//
//  Created by maesinfo on 12/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"


#define CELL_NUM  4

@interface UIMiddleTextField : UITextField
{
	
}



@end


@interface BaseDestViewController : BaseViewController 
<UITableViewDelegate,UITableViewDataSource>
{

	UITableView *table;

	UIMiddleTextField  *cellInput[CELL_NUM];
	BOOL bInput;
	UILabel  *headerLabel;
}
//@property(nonatomic,readonly) UIMiddleTextField  *cellInput;

-(void) initTable:(UITableViewStyle)tableStyle bEnableInput:(BOOL)bEnableInput;
-(UIMiddleTextField*) getCellInput:(int)index;

-(UITableViewCell*) getCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;

@end
