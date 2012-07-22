//
//  pViewController.m
//  Mooosh
//
//  Created by Katelyn Mann on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "pViewController.h"
#import "StatusViewController.h"

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
    NSString *dateString = [dateFormatter stringFromDate:self.myDatePicker.date];
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

    NSDate *date = [[NSDate date] dateByAddingTimeInterval:10.0];
    // NSDate *date = self.myDatePicker.date;
    [self scheduleNotificationForDate:date];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
    NSLog(@"received response");
    NSLog(@"%lld", [response expectedContentLength]);
    NSLog(@"%d", [response statusCode]);
    if ([response statusCode] == 200) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Towels will be warmed!" delegate:self cancelButtonTitle:@"Lucky me!" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed with error");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Your towel warmer is offline" delegate:self cancelButtonTitle:   @"Shucks!" otherButtonTitles:nil];
    [alertView show];
}

-(void) scheduleNotificationForDate: (NSDate*)date {
    /* Here we cancel all previously scheduled notifications */
    [[UIApplication sharedApplication] cancelAllLocalNotifications];

    UILocalNotification *localNotification = [[UILocalNotification alloc] init];

    localNotification.fireDate = date;
    NSLog(@"Notification will be shown on: %@", localNotification.fireDate);

    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = [NSString stringWithFormat:
                                   @"Your notification message 42"];
    
    //localNotification.repeatInterval = NSSecondCalendarUnit;
    //localNotification.soundName = @"bell.caf";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.alertAction = NSLocalizedString(@"View details!", nil);
    localNotification.applicationIconBadgeNumber = 1;

    /* Here we set notification sound and badge on the app's icon "-1" 
     means that number indicator on the badge will be decreased by one 
     - so there will be no badge on the icon */

    //localNotification.soundName = UILocalNotificationDefaultSoundName;
    //localNotification.applicationIconBadgeNumber = -1;

    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

 
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if ([alertView.title isEqualToString:@"Success"]) {
        NSLog(@"dismissed");
        [self performSegueWithIdentifier:@"status" sender:self];
    } else if ([alertView.title isEqualToString:@"Sorry"]) {
        [self performSegueWithIdentifier:@"failure" sender:self];
        NSLog(@"Fail");
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"status"]) {
        StatusViewController *vc = [segue destinationViewController];
        [vc setAlarmDate:self.myDatePicker.date];
    }
}
@end
