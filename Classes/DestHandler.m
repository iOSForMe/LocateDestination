//
//  DestHandler.m
//  LocateDestination
//
//  Created by maesinfo on 12/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DestHandler.h"
#import "toolDefs.h"

@implementation DestInfoObj
@synthesize dest;
@synthesize timeFirstSet;

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:dest.destName forKey:@"destName"];
	[encoder encodeDouble:dest.latitude forKey:@"latitude"];
	[encoder encodeDouble:dest.longitude forKey:@"longitude"];
	[encoder encodeDouble:dest.altitude forKey:@"altitude"];
	[encoder encodeObject:timeFirstSet forKey:@"time"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	[self init];
	dest.destName = [decoder decodeObjectForKey:@"destName"];
	[dest.destName retain];
	dest.latitude =[decoder decodeDoubleForKey:@"latitude"];
	dest.longitude=[decoder decodeDoubleForKey:@"longitude"];
	dest.altitude =[decoder decodeDoubleForKey:@"altitude"];

	timeFirstSet = [decoder decodeObjectForKey:@"time"];
	[timeFirstSet retain];
	
	return self;
}

-(struct DestInfo*) getInfo
{
	return &dest;
}

-(void) dealloc
{
	SAFE_RELEASE(dest.destName);
	SAFE_RELEASE(timeFirstSet);

	[super dealloc];
}

@end



@implementation DestHandler

-(id) init
{
	[super init];

	archvHandler = [[ArchiveHandler alloc]init];
	[self initDestInfo];

	[self initDestHistory];
	if(nil == history)
	{
		[self updateHistory:destObj];
	}
//	else
//	{
//		history = [[NSMutableArray alloc] init];
//	}
	
	
	return self;
}

-(BOOL) initDestInfo
{
	destObj = [ArchiveHandler unarchive:FILENAME_DESTINFO];
	if(nil == destObj)
	{
		destObj = [[DestInfoObj alloc]init];
		[self initDefaultDestInfo];
		return NO;
	}
	else {
		[destObj retain];
		return YES;
	}
}

-(void) initDestHistory
{
	history = [ArchiveHandler unarchive:FILENAME_DESTHISTORY];
	if(history)
	{
		[history retain];
	}
}

-(void) initDefaultDestInfo
{
	struct DestInfo *info=[self GetCurrentDest];

	info->destName = [[NSString alloc]initWithString:@"四姑娘山大峰"];
	info->latitude = 31.03198;
	info->longitude= 102.54212;
	info->altitude = 5025.0f;
}

-(void) setDestInfo:(struct DestInfo*)info
{
//	struct DestInfo* currentInfo = [self GetCurrentDest];

	SAFE_RELEASE(destObj);
//	SAFE_RELEASE(currentInfo->destName);
	destObj = [[DestInfoObj alloc] init];
	destObj.dest = *info;
	[destObj.dest.destName retain];
	
	[ArchiveHandler archive:destObj :FILENAME_DESTINFO];
	[self updateHistory:destObj];
//	SAFE_RELEASE(history);
}

-(void) updateHistory:(DestInfoObj *)obj
{
	if(nil == history)
	{
		history = [[NSMutableArray alloc] init];
	}

	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"YYYY.MM.dd-hh:mm:ss"];
	NSString *locationString=[formatter stringFromDate: [NSDate date]];
//	NSArray*timeArray=[locationString componentsSeparatedByString:@"-"];
//	float value_D=   [[timeArray objectAtIndex:1]floatValue];
//	float value_h=  [ [timeArray objectAtIndex:2]floatValue];
//	float value_m= [ [timeArray objectAtIndex:3]floatValue];
//	float value_s=  [ [timeArray objectAtIndex:4]floatValue];
//	float value_All=value_D*24*60*60+value_h*60*60+value_m*60+value_s;

	obj.timeFirstSet = locationString;
	[history insertObject:obj atIndex:0];
	[formatter release];
	[ArchiveHandler archive:history :FILENAME_DESTHISTORY];
}

-(struct DestInfo*) GetCurrentDest
{
	return [destObj getInfo];
}

-(NSArray*) getHistory
{
//	if(nil == history)
//	{
//		[self initDestHistory];
//	}
	return history;
}

-(void) dealloc
{
	SAFE_RELEASE(archvHandler);
	SAFE_RELEASE(destObj);
	SAFE_RELEASE(history);

	[super dealloc];
}

@end
