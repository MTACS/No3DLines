# No3DLines

```objective-c
#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface SBUIActionKeylineView: UIView
@end

@interface _UIInterfaceActionBlankSeparatorView: UIView
@end

@interface _UIInterfaceActionVibrantSeparatorView: UIView
@end

@interface _UIContextMenuActionsListSeparatorView: UIView
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
- (void)didMoveToWindow {
	%orig;
	self.hidden = YES;
}
%end

%hook _UIInterfaceActionVibrantSeparatorView
- (void)didMoveToWindow {
	%orig;
	self.hidden = YES;
}
%end
%end

%group iOS14
%hook _UIContextMenuActionsListSeparatorView
- (void)didMoveToWindow {
	%orig;
	self.hidden = YES;
}
%end
%end

%ctor {
	if (![NSProcessInfo processInfo]) return;
	NSString *processName = [NSProcessInfo processInfo].processName;
	bool isSpringBoard = [@"SpringBoard" isEqualToString:processName];
	bool shouldLoad = NO;
	NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
	NSUInteger count = args.count;
	if (count != 0) {
		NSString *executablePath = args[0];
		if (executablePath) {
			NSString *processName = [executablePath lastPathComponent];
			BOOL isApplication = [executablePath rangeOfString:@"/Application/"].location != NSNotFound || [executablePath rangeOfString:@"/Applications/"].location != NSNotFound;
			BOOL isFileProvider = [[processName lowercaseString] rangeOfString:@"fileprovider"].location != NSNotFound;
			BOOL skip = [processName isEqualToString:@"AdSheet"]
				|| [processName isEqualToString:@"CoreAuthUI"]
				|| [processName isEqualToString:@"SafetyMap"]
				|| [processName isEqualToString:@"MessagesNotificationViewService"]
				|| [executablePath rangeOfString:@".appex/"].location != NSNotFound;
			if ((!isFileProvider && isApplication && !skip) || isSpringBoard) {
				shouldLoad = YES;
			}
		}
	}
	if (!shouldLoad) return;
	if (shouldLoad) {
		if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"12.0") && SYSTEM_VERSION_LESS_THAN(@"13.0")) {
			%init(iOS12);
		} else if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"13.0") && SYSTEM_VERSION_LESS_THAN(@"14.0")) {
			%init(iOS13);
		} else if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"14.0") && SYSTEM_VERSION_LESS_THAN(@"15.0")) {
			%init(iOS14);
		}
	}
}
```
