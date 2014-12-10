//
//  XZZOuterSpaceTableViewController.m
//  Out of this world
//
//  Created by Zac on 5/12/2014.
//  Copyright (c) 2014 1st1k. All rights reserved.
//

#import "XZZOuterSpaceTableViewController.h"
#import "AstronomicalData.h"
#import "XZZSpaceObject.h"
#import "XZZSpaceImageViewController.h"
#import "XZZSpaceDataViewController.h"

@interface XZZOuterSpaceTableViewController ()

@end

@implementation XZZOuterSpaceTableViewController

#define ADDED_SPACE_OBJECTS_KEY @"Added Space Objects Array"

#pragma mark - Lazy Instantiation of Properties

- (NSMutableArray *)planets
{
    if (!_planets) {
        _planets = [[NSMutableArray alloc] init];
    }
    return _planets;
}

///////////// half hour addedspaceObjects
- (NSMutableArray *)addedSpaceObjects
{
    if (!_addedSpaceObjects) {
        _addedSpaceObjects = [[NSMutableArray alloc] init];
    }
    return _addedSpaceObjects;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //???self.planets = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets])
    {
        NSString *imageNamge = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
        XZZSpaceObject *planet = [[XZZSpaceObject alloc] initWithData:planetData andImage:[UIImage imageNamed:imageNamge]];
        [self.planets addObject:planet];
    }
    NSArray *myPlanetsAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY];
    for (NSDictionary *dictionary in myPlanetsAsPropertyLists) {
        XZZSpaceObject *spaceObject = [self spaceObjectForDictionary:dictionary];
        [self.addedSpaceObjects addObject:spaceObject];
    }

//    NSString *planet1 = @"Mercury";
//    NSString *planet2 = @"Venus";
//    NSString *planet3 = @"Earth";
//    NSString *planet4 = @"Mars";
//    NSString *planet5 = @"Jupiter";
//    NSString *planet6 = @"Saturn";
//    NSString *planet7 = @"Uranus";
//    NSString *planet8 = @"Neptunes";
//    self.planets = [[NSMutableArray alloc] initWithObjects:planet1, planet2, planet3, planet4, planet5, planet6, planet7, planet8, nil];
    
//    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
//    NSString *firstColor = @"red";
//    [myDictionary setObject:firstColor forKey:@"firetruck color"];
//    [myDictionary setObject:@"blue" forKey:@"ocean color"];
//    [myDictionary setObject:@"yellow" forKey:@"star color"];
//    NSLog(@"%@", myDictionary);
//    NSLog(@")%@", [myDictionary objectForKey:@"ocean color"]);
    
//    NSNumber *myNumber = [ NSNumber numberWithInt:5];
//    NSNumber *myNumber = @6;
//    NSLog(@"%@", myNumber);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    NSLog(@"%@", sender);
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        if ([segue.destinationViewController isKindOfClass:[XZZSpaceImageViewController class]]) {
//            NSLog(@"%@", sender);
            XZZSpaceImageViewController *nextViewController = segue.destinationViewController;
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            XZZSpaceObject *selectedObject;
            if (path.section == 0) {
                selectedObject = self.planets[path.row];
            }
            else if (path.section == 1){
                selectedObject = self.addedSpaceObjects[path.row];
            }
            nextViewController.spaceObject = selectedObject;
        }
    }
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.destinationViewController isKindOfClass:[XZZSpaceDataViewController class]]){
            XZZSpaceDataViewController *targetViewController = segue.destinationViewController;
            NSIndexPath *path = sender;
            XZZSpaceObject *selectedObject;
            if (path.section == 0) {
                selectedObject = self.planets[path.row];
            } else if (path.section == 1){
                selectedObject = self.addedSpaceObjects[path.row];
            }
            targetViewController.spaceObject = selectedObject;
        }
    }
    if ([segue.destinationViewController isKindOfClass:[XZZAddSpaceObjectViewController class]]) {
        XZZAddSpaceObjectViewController *addSpaceObjectVC = segue.destinationViewController;
        addSpaceObjectVC.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - XZZAddSpaceObjectViewController Delegate

- (void)didCancel
{
    NSLog(@"didCancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addSpaceObject:(XZZSpaceObject *)spaceObject
{
    
//    Replaced by lazy instantiation
//    if (!self.addedSpaceObjects) {
//        self.addedSpaceObjects = [[NSMutableArray alloc] init];
//    }
    [self.addedSpaceObjects addObject:spaceObject];
    NSLog(@"addSpaceObject");
    
    // Will seve to NSUserDefaults here
    NSMutableArray *spaceObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY] mutableCopy];
    if (!spaceObjectsAsPropertyLists) spaceObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    [spaceObjectsAsPropertyLists addObject:[self spaceObjectAsAPropertyList:spaceObject]];
    [[NSUserDefaults standardUserDefaults] setObject:spaceObjectsAsPropertyLists forKey:ADDED_SPACE_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

#pragma - Helper Methods

- (NSDictionary *)spaceObjectAsAPropertyList:(XZZSpaceObject *)spaceObject
{
    NSData *imageData = UIImagePNGRepresentation(spaceObject.spaceImage);
    NSDictionary *dictionary = @{PLANET_NAME : spaceObject.name,
                                 PLANET_GRAVITY : @(spaceObject.gravitationalForce),
                                 PLANET_DIAMETER : @(spaceObject.diameter),
                                 PLANET_YEAR_LENGTH : @(spaceObject.yearLength),
                                 PLANET_DAY_LENGTH : @(spaceObject.dayLength),
                                 PLANET_TEMPERATURE : @(spaceObject.temperature),
                                 PLANET_NUMBER_OF_MOONS : @(spaceObject.numberOfMoons),
                                 PLANET_NICKNAME : spaceObject.nickname,
                                 PLANET_INTERESTING_FACT : spaceObject.interestFact,
                                 PLANET_IMAGE : imageData};
    return dictionary;
}

-(XZZSpaceObject *)spaceObjectForDictionary:(NSDictionary *)dictionary
{
//    XZZSpaceObject *spaceObject = [[XZZSpaceObject alloc] initWithData:dictionary andImage:[UIImage imageNamed:@"EinsteinRing.jpg"]];
    //**************************** [PLANET_NAME] FOR 4 HOURS
    NSData *dataForImage = dictionary[PLANET_IMAGE];
    UIImage *spaceObjectImage = [UIImage imageWithData:dataForImage];
    XZZSpaceObject *spaceObject = [[XZZSpaceObject alloc] initWithData:dictionary andImage:spaceObjectImage];
    return spaceObject;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    if ([self.addedSpaceObjects count]) {
        return 2;
    }
    else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 1) {
        return [self.addedSpaceObjects count];
    }
    else{
        return [self.planets count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.section == 1) {
        //use new space object to customize our cell
        XZZSpaceObject *planet = [self.addedSpaceObjects objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
    }
    else{
//    cell.textLabel.text = @"My first tableview";
//    cell.textLabel.text = [NSString stringWithFormat:@"Row %i", indexPath.row];
//    cell.textLabel.text = [self.planets objectAtIndex:indexPath.row];
//    if (indexPath.section == 0) {
//        cell.backgroundColor = [UIColor redColor];
//    }
//    else{
//        cell.backgroundColor = [UIColor yellowColor];
//    }
        XZZSpaceObject *planet = [self.planets objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    return cell;
}

#pragma mark - UITableView  Delegate

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
//    NSLog(@"INDEX %i", indexPath.row);
}


// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    if (indexPath.section == 1)
//        return YES;
//    else
//        return NO;
//}



// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [self.addedSpaceObjects removeObjectAtIndex:indexPath.row];
//        NSMutableArray *newSavedSpaceObjectData = [[NSMutableArray alloc] init];
//        for (XZZSpaceObject *spaceObject in self.addedSpaceObjects) {
//            [newSavedSpaceObjectData addObject:[self spaceObjectAsAPropertyList:spaceObject]];
//        }
//        [[NSUserDefaults standardUserDefaults] setObject:newSavedSpaceObjectData forKey:ADDED_SPACE_OBJECTS_KEY];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
