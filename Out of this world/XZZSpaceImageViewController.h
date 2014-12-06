//
//  XZZSpaceImageViewController.h
//  Out of this world
//
//  Created by Zac on 6/12/2014.
//  Copyright (c) 2014 1st1k. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface XZZSpaceImageViewController : UIViewController

@interface XZZSpaceImageViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@end
