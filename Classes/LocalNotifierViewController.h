//
//  LocalNotifierViewController.h
//  LocalNotifier
//
//  Created by Anurag Solanki on 10/02/11.
//  Copyright 2011 Vinsol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalNotifierViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *tableview;
	IBOutlet UIDatePicker *datePicker;
	IBOutlet UITextField *eventText;
}

@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet UITextField *eventText;

- (IBAction) scheduleAlarm:(id) sender;


@end

