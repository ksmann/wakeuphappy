//
//  pViewController.m
//  Mooosh
//
//  Created by Katelyn Mann on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "pViewController.h"

@implementation pViewController
@synthesize myDatePicker;
@synthesize myDate;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMyDatePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)buttonClicked:(id)sender {
    NSLog(@"you clicked me!");
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd!HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    NSString *url = [NSString stringWithFormat:@"http://localhost:8080?time=%@", dateString];
    NSLog(@"%@", url);
    

    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        NSLog(@"Connection successful!!");
    } else {
        NSLog(@"Connection failed!");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
    NSLog(@"received response");
    NSLog(@"%lld", [response expectedContentLength]);
    NSLog(@"%d", [response statusCode]);
    if ([response statusCode] == 200) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Towels will be warmed!" delegate:nil cancelButtonTitle:@"Lucky me!" otherButtonTitles:nil];
        [alertView show];
    }
}
@end
