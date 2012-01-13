//
//  BaseViewController.m
//  LocateDestination
//
//  Created by maesinfo on 1/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"


@implementation BaseViewController
-(void) loadView
{
	[super loadView];
	CGRect frame = self.view.frame;
	frame.origin.y=0;
	bgView = [[UIImageView alloc]initWithFrame:frame];
	bgView.image = [UIImage imageNamed:PIC_BG_BLUE];
	[self.view addSubview:bgView];
}

-(void) dealloc
{
	SAFE_RELEASE(bgView);
	[super dealloc];
}

@end
