//
//  LocalNotifierViewController.m
//  LocalNotifier
//
//  Created by Anurag Solanki on 10/02/11.
//  Copyright 2011 Vinsol. All rights reserved.
//

#import "LocalNotifierViewController.h"

@implementation LocalNotifierViewController

@synthesize datePicker,tableview, eventText;

- (IBAction) scheduleAlarm:(id) sender {
    [eventText resignFirstResponder];
	
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
	
    // Get the current date
    NSDate *pickerDate = [self.datePicker date];
	
    // Break the date up into components
    NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
												   fromDate:pickerDate];
    NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
												   fromDate:pickerDate];
    // Set up the fire time
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:[dateComponents day]];
    [dateComps setMonth:[dateComponents month]];
    [dateComps setYear:[dateComponents year]];
    [dateComps setHour:[timeComponents hour]];
	// Notification will fire in one minute
    [dateComps setMinute:[timeComponents minute]];
	[dateComps setSecond:[timeComponents second]];
    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    [dateComps release];
	
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.fireDate = itemDate;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
	
	// Notification details
    localNotif.alertBody = [eventText text];
	// Set the action button
    localNotif.alertAction = @"View";
	
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
	
	// Specify custom data for the notification
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
    localNotif.userInfo = infoDict;
	
	// Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    [localNotif release];
	
	[self.tableview reloadData];
}

#pragma mark -
#pragma mark UITableView Delegate & DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;		// We only have one section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of notifications
    return [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
    // Get list of local notifications
    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    UILocalNotification *notif = [notificationArray objectAtIndex:indexPath.row];
	
    // Display notification info
    [cell.textLabel setText:notif.alertBody];
    [cell.detailTextLabel setText:[notif.fireDate description]];
	
    return cell;
}

#pragma mark -

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	datePicker = nil;
	tableview = nil;
	eventText = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
