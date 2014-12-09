//
//  XZZOuterSpaceTableViewController.h
//  Out of this world
//
//  Created by Zac on 5/12/2014.
//  Copyright (c) 2014 1st1k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZZAddSpaceObjectViewController.h"

@interface XZZOuterSpaceTableViewController : UITableViewController <XZZAddSpaceObjectViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *planets;
@property (strong, nonatomic) NSMutableArray *addedSpaceObjects;

@end
