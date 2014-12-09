//
//  XZZSpaceImageViewController.m
//  Out of this world
//
//  Created by Zac on 6/12/2014.
//  Copyright (c) 2014 1st1k. All rights reserved.
//

#import "XZZSpaceImageViewController.h"

@interface XZZSpaceImageViewController ()

@end

@implementation XZZSpaceImageViewController

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
//    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Jupiter.jpg"]];
    
    self.imageView = [[UIImageView alloc] initWithImage:self.spaceObject.spaceImage];
//    self.scrollView.contentSize = self.imageView.frame.size;
//    CGRect rect =[[UIScreen mainScreen] bounds];
//    CGSize size = rect.size;
    self.imageView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize = self.imageView.frame.size;
    self.scrollView.bounces = YES;

//    self.scrollView.layer.contents = (id) self.spaceObject.spaceImage.CGImage;
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.minimumZoomScale = 0.5;
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

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
