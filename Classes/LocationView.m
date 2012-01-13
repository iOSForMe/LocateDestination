//
//  LocationView.m
//  LocateDestination
//
//  Created by maesinfo on 12/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationView.h"
#include "toolDefs.h"


@implementation LocationView

-(id)initWithFrame:(CGRect)frame
{
	[super initWithFrame:frame];

	self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
	radius = 100;

	return self;
}

-(void) drawRect:(CGRect)rect
{
	NSLog(@"drawRect");
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 2.0);

	UIColor *currentColor = [UIColor blueColor];
	CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
//	CGContextSetFillColorWithColor(context, currentColor.CGColor);

	CGRect frame = self.frame;
	CGRect currentRect = CGRectMake ((frame.size.width-radius*2)/2,(frame.size.height-radius*2)/2,radius*2,radius*2);
	CGContextAddEllipseInRect(context, currentRect);
	CGContextDrawPath(context, kCGPathStroke);

	CGFloat phase = 0.0;
    CGFloat lengths[] = {10.0, 5.0};
    CGContextSetLineDash (context,phase,lengths,2); 					 
	CGContextClosePath(context);
    CGContextStrokePath(context);
	CGPoint points[]={{0,self.frame.size.height/2},{self.frame.size.width,self.frame.size.height/2}};
	CGContextAddLines(context,points,2);
	CGContextDrawPath(context, kCGPathStroke);
	points[0].x=self.frame.size.width/2;
	points[0].y=0;
	points[1].x=self.frame.size.width/2;
	points[1].y=self.frame.size.height;
	CGContextAddLines(context,points,2);
	CGContextDrawPath(context, kCGPathStroke);


	

//	switch (shapeType)
//	{
//		case kLineShape:
//			CGContextMoveToPoint(context, firstTouch.x, firstTouch.y);
//			CGContextAddLineToPoint(context, lastTouch.x, lastTouch.y);
//			CGContextStrokePath(context);
//			break;
//		case kRectShape:
//			CGContextAddRect(context, currentRect);
//			CGContextDrawPath(context, kCGPathFillStroke);
//			break;
//		case kEllipseShape:
//			break;
//		case kImageShape: 
//		{

	CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
	if(nil == destImage)
	{
		NSString *path = [[NSBundle mainBundle] pathForResource:@"dest.png" ofType:nil];
		destImage = [[UIImage alloc]initWithContentsOfFile:path];
		[path release];
	}
	if(nil == currentImage)
	{
		NSString *path = [[NSBundle mainBundle] pathForResource:@"current.png" ofType:nil];
		currentImage = [[UIImage alloc]initWithContentsOfFile:path];
		[path release];
	}
	[self layImage:destImage point:centerPoint];
	[self layImage:currentImage point:[self transformCurrent]];
//	[destImage drawAtPoint:centerPoint];
//	[currentImage drawAtPoint:[self transformCurrent]];

//	CGFloat horizontalOffset = drawImage.size.width / 2;
//			CGFloat verticalOffset = drawImage.size.height / 2;
//			CGPoint drawPoint = CGPointMake(lastTouch.x - horizontalOffset,
//											lastTouch.y - verticalOffset);
//			break;
//		}
//		default:
//			break;
//	}
}

-(void) updateLocation:(CGPoint)dest current:(CGPoint)current
{
	NSLog(@"updateLocation");
	destPoint = dest;
	currentPoint = current;
	[self setNeedsDisplay];
}

// note that the coordinate system is the opposite by y-axis
-(CGPoint) transformCurrent
{
	float cx = currentPoint.x - destPoint.x;
	float cy = currentPoint.y - destPoint.y;
	
	NSLog(@"%f   %f",cx,cy);

	float x_offset;
	float y_offset;
	float abs_x_offset;
	float abs_y_offset;
	if(cx)
	{
		abs_x_offset = sqrt((radius*radius)/(1+(cy/cx)*(cy/cx)));
		abs_y_offset = sqrt((radius*radius)-abs_x_offset*abs_x_offset);
	}
	else {
		abs_y_offset = sqrt((radius*radius)/(1+(cx/cy)*(cx/cy)));
		abs_x_offset = sqrt((radius*radius)-abs_y_offset*abs_y_offset);
	}

	x_offset = ((cx>0.0f)?1:-1) * abs_x_offset;
	y_offset = ((cy>0.0f)?-1:1) * abs_y_offset;

	return CGPointMake(self.frame.size.width/2 + x_offset, self.frame.size.height/2 + y_offset);
}

-(void) layImage:(UIImage*)image point:(CGPoint)point
{
	CGPoint newPoint=point;
	newPoint.x -= (image.size.width)/2;
	newPoint.y -= (image.size.height)/2;
	
	[image drawAtPoint:newPoint];
}


@end
//CGContextRef context = UIGraphicsGetCurrentContext();
//CGContextSetLineWidth(context, 2.0);
//
//UIColor *currentColor = [UIColor blueColor];
//CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
//CGContextSetFillColorWithColor(context, currentColor.CGColor);
//CGRect currentRect = CGRectMake (50,50,10,10);
//									 (firstTouch.x > lastTouch.x) ? lastTouch.x : firstTouch.x,
//									 (firstTouch.y > lastTouch.y) ? lastTouch.y : firstTouch.y,
//									 fabsf(firstTouch.x - lastTouch.x),
//									 fabsf(firstTouch.y - lastTouch.y));

//	switch (shapeType)
//	{
//		case kLineShape:
//			CGContextMoveToPoint(context, firstTouch.x, firstTouch.y);
//			CGContextAddLineToPoint(context, lastTouch.x, lastTouch.y);
//			CGContextStrokePath(context);
//			break;
//		case kRectShape:
//			CGContextAddRect(context, currentRect);
//			CGContextDrawPath(context, kCGPathFillStroke);
//			break;
//		case kEllipseShape:
//			CGContextAddEllipseInRect(context, currentRect);
//			CGContextDrawPath(context, kCGPathFillStroke);
//			break;
//		case kImageShape: 
//		{
//			CGFloat horizontalOffset = drawImage.size.width / 2;
//			CGFloat verticalOffset = drawImage.size.height / 2;
//			CGPoint drawPoint = CGPointMake(lastTouch.x - horizontalOffset,
//											lastTouch.y - verticalOffset);
//			[drawImage drawAtPoint:drawPoint];            
//			break;
//		}
//		default:
//			break;
//	}
