//
//  SetFromhistoryViewController.h
//  LocateDestination
//
//  Created by maesinfo on 1/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"


@interface SetFromhistoryViewController : BaseViewController
<UITableViewDelegate,UITableViewDataSource>{

	UIViewController *parent;
	UITableView   *table;
}
-(id) initWithParent:(UIViewController *)controller;
-(IBAction) goBack:(id)sender;

@end
