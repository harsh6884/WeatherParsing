//
//  Weather.h
//  WeatherParsing
//
//  Created by Harshad on 27/08/16.
//  Copyright (c) 2016 Harshad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Weather : NSObject

@property(nonatomic,retain)NSString *cloud,*humidity,*time,*weathercode,*value,*wind,*windDegree,*query,*type;

@property(nonatomic,retain)UIImage *img;



@end
