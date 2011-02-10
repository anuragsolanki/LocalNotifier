//
//  LocalNotifierAppDelegate.h
//  LocalNotifier
//
//  Created by Anurag Solanki on 10/02/11.
//  Copyright 2011 Vinsol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocalNotifierViewController;

@interface LocalNotifierAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    LocalNotifierViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LocalNotifierViewController *viewController;

@end

