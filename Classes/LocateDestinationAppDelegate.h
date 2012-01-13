//
//  LocateDestinationAppDelegate.h
//  LocateDestination
//
//  Created by maesinfo on 12/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "UICustomTabBar.h"
#import "DestHandler.h"


@interface LocateDestinationAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
	UICustomTabBar  *tabbarController;
	
	DestHandler *dstHandler;

	UINavigationController * nav;
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UICustomTabBar *tabbarController;
@property (nonatomic, retain) UINavigationController *nav;


@property (nonatomic, retain) DestHandler *dstHandler;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;


@end

