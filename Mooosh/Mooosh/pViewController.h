//
//  pViewController.h
//  Mooosh
//
//  Created by Katelyn Mann on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *myDatePicker;
- (IBAction)buttonClicked:(id)sender;

@property (nonatomic, strong) NSDate *myDate;
@property (nonatomic, strong) NSData *receivedData;

@end
