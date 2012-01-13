//
//  DestHandler.h
//  LocateDestination
//
//  Created by jiang jinfu on 12/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArchiveHandler.h"

struct DestInfo
{
	NSString *destName;
	double   latitude;
	double   longitude;
	double   altitude;
};

@interface DestInfoObj : NSObject
<NSCoding>
{
	struct DestInfo dest;

	NSString  *timeFirstSet;
}

@property(nonatomic) struct DestInfo dest;
@property(nonatomic,retain) NSString *timeFirstSet;

-(struct DestInfo*) getInfo;

@end



@interface DestHandler : NSObject {
	
	DestInfoObj   *destObj;
	NSMutableArray  *history;

	ArchiveHandler   *archvHandler;
}

-(void) initDefaultDestInfo;
-(BOOL) initDestInfo;
-(void) initDestHistory;

-(void) setDestInfo:(struct DestInfo*)info;
-(void) updateHistory:(DestInfoObj *)obj;

-(struct DestInfo*) GetCurrentDest;
-(NSArray*) getHistory;

@end
