//
//  XZZSpaceObject.m
//  Out of this world
//
//  Created by Zac on 6/12/2014.
//  Copyright (c) 2014 1st1k. All rights reserved.
//

#import "XZZSpaceObject.h"
#import "AstronomicalData.h"
@implementation XZZSpaceObject

-(id) init
{
    self = [self initWithData:nil andImage:nil];
    return self;
}

-(id) initWithData:(NSDictionary *)data andImage:(UIImage *)image
{
    self = [super init];
    self.name = data[PLANET_NAME];
    self.gravitationalForce = [data[PLANET_GRAVITY] floatValue];
    self.diameter = [data[PLANET_DIAMETER] floatValue];
    self.yearLength = [data[PLANET_YEAR_LENGTH] floatValue];
    self.dayLength = [data[PLANET_DAY_LENGTH] floatValue];
    self.temperature = [data[PLANET_TEMPERATURE] floatValue];
    self.numberOfMoons = [data[PLANET_NUMBER_OF_MOONS] intValue];
    self.nickname = data[PLANET_NICKNAME];
    self.interestFact = data[PLANET_INTERESTING_FACT];
    self.spaceImage = image;
    return self;
}

@end
