//
//  XZZSpaceObject.h
//  Out of this world
//
//  Created by Zac on 6/12/2014.
//  Copyright (c) 2014 1st1k. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZZSpaceObject : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) float gravitationalForce;
@property (nonatomic) float diameter;
@property (nonatomic) float yearLength;
@property (nonatomic) float dayLength;
@property (nonatomic) float temperature;
@property (nonatomic) int numberOfMoons;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *interestFact;

@property (strong, nonatomic) UIImage *spaceImage;

-(id)initWithData:(NSDictionary *)data andImage:(UIImage *)image;

@end
