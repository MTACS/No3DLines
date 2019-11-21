#import <substrate.h>
#import <UIKit/UIKit.h>
#import <sys/types.h>
#import <sys/stat.h>
#import <stdio.h>
#import <unistd.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <errno.h>

@interface SBUIActionKeylineView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

@interface _UIInterfaceActionBlankSeparatorView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

@interface _UIInterfaceActionVibrantSeparatorView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

%group iOS12

%hook SBUIActionKeylineView

- (void)layoutSubviews {

	%orig;

	self.hidden = YES;

}

%end

%end

%group iOS13

%hook _UIInterfaceActionBlankSeparatorView

- (void)layoutSubviews {

	%orig;

	self.hidden = YES;

}

%end

%hook _UIInterfaceActionVibrantSeparatorView

- (void)layoutSubviews {

	%orig;

	self.hidden = YES;

}

%end

%end

%ctor {

	CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];

	if (version >= 13.0) {

		%init(iOS13);

	} else {

		%init(iOS12);

	}

}
