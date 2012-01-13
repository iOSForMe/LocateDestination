//
//  LocationView.h
//  LocateDestination
//
//  Created by maesinfo on 12/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LocationView : UIView {
	CGPoint  destPoint;
	CGPoint  currentPoint;
	UIImage  *destImage;
	UIImage  *currentImage;
	float radius;
}

-(void) updateLocation:(CGPoint)dest current:(CGPoint)current;
-(CGPoint) transformCurrent;
-(void) layImage:(UIImage*)image point:(CGPoint)point;

@end
