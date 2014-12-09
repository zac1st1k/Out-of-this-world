//
//  XZZAddSpaceObjectViewController.m
//  Out of this world
//
//  Created by Zac on 9/12/2014.
//  Copyright (c) 2014 1st1k. All rights reserved.
//

#import "XZZAddSpaceObjectViewController.h"

@interface XZZAddSpaceObjectViewController ()

@end

@implementation XZZAddSpaceObjectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *orionImage = [UIImage imageNamed:@"Orion.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:orionImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButtonPressed:(id)sender
{
    [self.delegate didCancel];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addButtonPressed:(id)sender
{
    XZZSpaceObject *newSpaceObject = [self returnNewSpaceObject];
    [self.delegate addSpaceObject:newSpaceObject];
}

- (XZZSpaceObject *)returnNewSpaceObject
{
    XZZSpaceObject *addSpaceObject = [[XZZSpaceObject alloc] init];
    addSpaceObject.name = self.nameTextField.text;
    addSpaceObject.nickname = self.nicknameTextField.text;
    addSpaceObject.diameter = [self.diameterTextField.text floatValue];
    addSpaceObject.temperature = [self.temperatureTextField.text floatValue];
    addSpaceObject.numberOfMoons = [self.numberOfMoonsTextField.text intValue];
    addSpaceObject.interestFact = self.interestingFactTextField.text;
    return addSpaceObject;
}

@end
