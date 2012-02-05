//
//  SerialViewController.m
//  Serial
//
//  Created by Raja on 10/11/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "SerialViewController.h"
#import <dlfcn.h>
#import <mach/port.h>
#import <mach/kern_return.h>

@implementation SerialViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	/*CFTypeRef serialNumberAsCFString;
	
	io_service_t platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"));
	
	if (platformExpert)
	{
		serialNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert, CFSTR(kIOPlatformUUIDKey), kCFAllocatorDefault, 0);
	}
	
	IOObjectRelease(platformExpert);
	
	NSString *serial = [[NSString alloc] initWithFormat:@"%@",serialNumberAsCFString];
	
    NSLog(@"serail no==>%@",serialNumberAsCFString);
    NSLog(@"serail no==>%@",serial);*/
	
	NSString *serialNumber = nil;
	
	void *IOKit = dlopen("/System/Library/Frameworks/IOKit.framework/IOKit", RTLD_NOW);
	if (IOKit)
	{
		mach_port_t *kIOMasterPortDefault = dlsym(IOKit, "kIOMasterPortDefault");
		CFMutableDictionaryRef (*IOServiceMatching)(const char *name) = dlsym(IOKit, "IOServiceMatching");
		mach_port_t (*IOServiceGetMatchingService)(mach_port_t masterPort, CFDictionaryRef matching) = dlsym(IOKit, "IOServiceGetMatchingService");
		CFTypeRef (*IORegistryEntryCreateCFProperty)(mach_port_t entry, CFStringRef key, CFAllocatorRef allocator, uint32_t options) = dlsym(IOKit, "IORegistryEntryCreateCFProperty");
		kern_return_t (*IOObjectRelease)(mach_port_t object) = dlsym(IOKit, "IOObjectRelease");
		
		if (kIOMasterPortDefault && IOServiceGetMatchingService && IORegistryEntryCreateCFProperty && IOObjectRelease)
		{
			mach_port_t platformExpertDevice = IOServiceGetMatchingService(*kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"));
			if (platformExpertDevice)
			{
				CFTypeRef platformSerialNumber = IORegistryEntryCreateCFProperty(platformExpertDevice, CFSTR("IOPlatformSerialNumber"), kCFAllocatorDefault, 0);
				if (CFGetTypeID(platformSerialNumber) == CFStringGetTypeID())
				{
					serialNumber = [NSString stringWithString:(NSString*)platformSerialNumber];
					CFRelease(platformSerialNumber);
				}
				IOObjectRelease(platformExpertDevice);
			}
		}
		dlclose(IOKit);
	
	}
	NSLog(@"Serial NO ==>%@",serialNumber);
	t1.text=serialNumber;
		NSString *id = [[UIDevice currentDevice] uniqueIdentifier];
	t2.text=id;
	NSLog(@"UDID==>%@",id);
	NSString *name = [[UIDevice currentDevice] name];
	t3.text=name;
	NSLog(@"Name==>%@",name);
	NSString *systemName = [[UIDevice currentDevice] systemName];
	t4.text=systemName;
	
	NSLog(@"systemName==>%@",systemName);
	NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
	t5.text=systemVersion;
	NSLog(@"systemVersion==>%@",systemVersion);
	NSString *model = [[UIDevice currentDevice] model];
	t6.text=model;
	NSLog(@"model==>%@",model);
	NSString *localizedModel = [[UIDevice currentDevice] localizedModel];
	NSLog(@"localizedModel==>%@",localizedModel);
	//name
	//systemName
	//systemVersion
	//model
	//localizedModel
    [super viewDidLoad];
	
}



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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
