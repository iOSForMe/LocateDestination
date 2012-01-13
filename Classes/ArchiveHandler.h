//
//  ArchiveHandler.h
//  ParseGPS
//
//  Created by Jiang Jinfu on 12/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ArchiveHandler : NSObject {

}


+ (void) archive:(id)ObjToArchived :(NSString*)fileName;
+ (id) unarchive:(NSString*)fileName;

@end
