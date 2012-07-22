//
//  StatusViewController.m
//  Mooosh
//
//  Created by Katelyn Mann on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StatusViewController.h"

@implementation StatusViewController

@synthesize myDateLabel;
@synthesize alarmDate;
@synthesize dancing;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    myDateLabel.text = [alarmDate description];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [UIView animateWithDuration:1.5 animations:^{
        CGRect frame = dancing.frame;
        frame.origin.x = 0;
        frame.origin.y -= 90;
        [dancing setFrame:frame];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 animations:^{
            CGRect frame = dancing.frame;
            frame.origin.x = 0;
            frame.origin.y += 90;
            [dancing setFrame:frame];
        } completion:^(BOOL finished) {
        }];
    }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
