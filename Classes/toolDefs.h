/*
 *  toolDefs.h
 *  ParseGPS
 *
 *  Created by maesinfo on 11/28/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */


#define MAIN_VIEW_HEIGHT [[UIScreen mainScreen] applicationFrame].size.height
#define STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define SCREEN_HEIGHT (MAIN_VIEW_HEIGHT + STATUS_BAR_HEIGHT)
#define SCREEN_WIDTH [[UIScreen mainScreen] applicationFrame].size.width
#define TOOLBAR_HEIGHT 40
#define HORIZ_SWIPE_DRAG_MIN 12
#define VERT_SWIPE_DRAG_MIN 12
#define HORIZ_SWIPE_DRAG_MAX 10
#define VERT_SWIPE_DRAG_MAX 10 

#define TOOLBAR_BUTTON_COUNT 2
#define TOOLBAR_BUTTON_OFFSET 10


#define SAFE_RELEASE(p) if(p)[p release];p=nil


// files
#define PIC_BG_BLUE  @"bg_blue.png"

// archive
#define FILENAME_DESTINFO    @"file_destinfo.dat"
#define FILENAME_DESTHISTORY    @"file_destHistory.dat"

