//
//  XZZAddSpaceObjectViewController.h
//  Out of this world
//
//  Created by Zac on 9/12/2014.
//  Copyright (c) 2014 1st1k. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XZZAddSpaceObjectViewControllerDelegate <NSObject>

@required

- (void)addSpaceObject;
- (void)didCancel;

@end

@interface XZZAddSpaceObjectViewController : UIViewController

@property (weak, nonatomic) id <XZZAddSpaceObjectViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (strong, nonatomic) IBOutlet UITextField *diameterTextField;
@property (strong, nonatomic) IBOutlet UITextField *temperatureTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfMoonsTextField;
@property (strong, nonatomic) IBOutlet UITextField *interestingFactTextField;

- (IBAction)addButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@end
