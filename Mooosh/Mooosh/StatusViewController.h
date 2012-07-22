//
//  StatusViewController.h
//  Mooosh
//
//  Created by Katelyn Mann on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *myDateLabel;
@property (weak, nonatomic) NSDate *alarmDate;
@property (weak, nonatomic) IBOutlet UIImageView *dancing;
@end
