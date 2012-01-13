//
//  ArchiveHandler.m
//  ParseGPS
//
//  Created by Jiang Jinfu on 12/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArchiveHandler.h"


@implementation ArchiveHandler

+ (void) archive:(id)ObjToArchived :(NSString*)fileName
{
	NSLog(@"begin archive...  obj:%@  file:%@",ObjToArchived,fileName);
	NSString* docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	[NSKeyedArchiver archiveRootObject:ObjToArchived 
								toFile: [docDir stringByAppendingPathComponent:fileName]];
	NSLog(@" archive completed!!!");

	
//	switch (archiveType)
//	{
//		case ARCHIVE_VERSION:
//			
//			[NSKeyedArchiver archiveRootObject:versionString 
//										toFile: [docDir stringByAppendingPathComponent:FILENAME_VERSION]];
//			break;
//		case ARCHIVE_FUSIONSTRINGS:
//		{
//			NSString *str;
//			if(nil == dataHandler)
//			{
//				str = @"";
//			}else {
//				str = dataHandler.archivedData;
//			}
//			
//			[NSKeyedArchiver archiveRootObject:str 
//										toFile: [docDir stringByAppendingPathComponent:FILENAME_FUSIONSTRING]];
//		}
//			break;
//			
//		case ARCHIVE_FAVORITE:
//			
//			[NSKeyedArchiver archiveRootObject:favoriteArray 
//										toFile: [docDir stringByAppendingPathComponent:FILENAME_FAVORITE]];
//			favoriteChanged = YES;
//			break;
//		case ARCHIVE_ZIPCODE:
//		{
//			NSString *tempString = [NSString stringWithFormat:@"%@.%@",zipCode,[ecoArray objectAtIndex:0]];
//			
//			if([ecoArray count]>1)
//			{
//				int n;
//				for(n=1;n<[ecoArray count]; n++)
//					tempString = [NSString stringWithFormat:@"%@.%@",tempString,[ecoArray objectAtIndex:n]];
//			}
//			
//			NSString *zipString;
//			zipString = tempString;
//			
//			[NSKeyedArchiver archiveRootObject:zipString 
//										toFile: [docDir stringByAppendingPathComponent:FILENAME_ZIPCODE]];
//		}
//			break;
//		default:
//			break;
//	}
}

+ (id) unarchive:(NSString*)fileName
{
	NSString* docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	
	return [NSKeyedUnarchiver unarchiveObjectWithFile:[docDir stringByAppendingPathComponent:fileName]];
	
//	switch (archiveType)
//	{
//		case ARCHIVE_VERSION:
//			
//			self.versionString = [NSKeyedUnarchiver unarchiveObjectWithFile:[docDir stringByAppendingPathComponent:FILENAME_VERSION]];
//			
//			break;
//		case ARCHIVE_FUSIONSTRINGS:
//			
//			dataHandler.archivedData = [NSKeyedUnarchiver unarchiveObjectWithFile:[docDir stringByAppendingPathComponent:FILENAME_FUSIONSTRING]];
//			if( dataHandler.archivedData == nil)
//			{
//				NSString *tmpStr = [[NSString alloc]init];
//				dataHandler.archivedData = tmpStr;
//				[tmpStr release];
//			}
//			break;
//			
//		case ARCHIVE_FAVORITE:
//			favoriteArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[docDir stringByAppendingPathComponent:FILENAME_FAVORITE]];
//			[favoriteArray retain];
//			if( favoriteArray == nil)
//			{
//				NSMutableArray  *arr = [[NSMutableArray alloc]init];
//				self.favoriteArray = arr;
//				[arr release];
//			}
//			break;
//		case ARCHIVE_ZIPCODE:
//		{
//			NSString *zipString = [NSKeyedUnarchiver unarchiveObjectWithFile:[docDir stringByAppendingPathComponent:FILENAME_ZIPCODE]];
//			
//			NSArray  *zipArray = [zipString componentsSeparatedByString:@"."];
//			
//			self.zipCode = [zipArray objectAtIndex:0];
//			if(ecoArray == nil)
//			{
//				ecoArray = [[NSMutableArray alloc]init];
//			}
//			else {
//				[ecoArray removeAllObjects];
//			}
//			
//			int n;
//			for(n=1; n<[zipArray count];n++)
//			{
//				[ecoArray addObject:[zipArray objectAtIndex:n]];
//			}
//			//			[ecoregionNumber retain];
//			
//			//			if( favoriteArray == nil)
//			//			{
//			//				NSMutableArray  *arr = [[NSMutableArray alloc]init];
//			//				self.favoriteArray = arr;
//			//				[arr release];
//			//			}
//		}
//			break;
//		default:
//			break;
//	}
}

@end
