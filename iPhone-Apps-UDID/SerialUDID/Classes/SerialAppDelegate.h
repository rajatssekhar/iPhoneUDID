//
//  SerialAppDelegate.h
//  Serial
//
//  Created by Satheesan on 10/11/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SerialViewController;

@interface SerialAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SerialViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SerialViewController *viewController;

@end

