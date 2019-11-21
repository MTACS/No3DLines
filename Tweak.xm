@interface SBUIActionKeylineView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

@interface _UIInterfaceActionBlankSeparatorView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

@interface _UIInterfaceActionVibrantSeparatorView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

#import <substrate.h>
#import <UIKit/UIKit.h>
#import <sys/types.h>
#import <sys/stat.h>
#import <stdio.h>
#import <unistd.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <errno.h>

@interface SBUIActionPlatterViewController : UIViewController {

    UIStackView* _stackView;

}
@end

@interface SBUIAction : NSObject {

    UIImage *_image;

}
@property (nonatomic, readonly) UIImage *image;
@end

@interface SBUIActionView 
@property (nonatomic, assign, readwrite) CGPoint center;
@property (nonatomic, assign, readwrite) CGRect frame;
@end

@interface SBUIAppIconForceTouchControllerDataProvider : NSObject
- (NSString *)applicationBundleIdentifier;
- (void)dismissAnimated:(BOOL)arg1 withCompletionHandler:(id)arg2;
@end

@interface SBSApplicationShortcutItem : NSObject <NSCopying> 
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * localizedTitle;
@property (nonatomic,copy) NSString * localizedSubtitle;
@property (nonatomic,copy) NSString * bundleIdentifierToLaunch;
@end

@interface SBIconController : UIViewController {

    UIImpactFeedbackGenerator* _iconEditingFeedbackBehavior;

}
@property (nonatomic, readonly) UIImpactFeedbackGenerator * iconEditingFeedbackBehavior;
+ (id)sharedInstance;
- (void)setIsEditing:(BOOL)arg1;
- (void)_iconForceTouchControllerDidDismiss:(id)arg1;
@end

@interface SpringBoard
- (void)_returnToHomescreenWithCompletion:(id)arg1;
@end

@interface LSApplicationProxy
- (id)_initWithBundleUnit:(NSUInteger)arg1 applicationIdentifier:(NSString *)arg2;
+ (id)applicationProxyForIdentifier:(NSString *)arg1;
+ (id)applicationProxyForBundleURL:(NSURL *)arg1;
- (void)setUserInitiatedUninstall:(BOOL)arg1;
- (NSString *)itemName;
@end

@interface FBApplicationInfo : NSObject
- (NSURL *)dataContainerURL;
- (NSURL *)bundleURL;
- (NSString *)bundleIdentifier;
- (NSString *)bundleType;
- (NSString *)bundleVersion;
- (NSString *)displayName;
- (id)initWithApplicationProxy:(id)arg1;
@end

@interface LSApplicationWorkspace: NSObject
+ (id)defaultWorkspace;
- (BOOL)uninstallApplication:(id)arg1 withOptions:(id)arg2;
@end

@interface SBUIActionViewLabel: UIView {

	NSString* _text;
	UIColor* _textColor;
	UILabel* _label;
	UILabel* _emojiLabel;
}
- (UIColor *)textColor;
- (void)setTextColor:(UIColor *)arg1;
@end

%group iOS12

%hook SBUIActionKeylineView

- (void)layoutSubviews {

	%orig;

	self.hidden = YES;

}

%end

/* %hook SBUIAppIconForceTouchControllerDataProvider

- (NSArray *)applicationShortcutItems {

	NSMutableArray *orig = [%orig mutableCopy];

	if (!orig) {

		orig = [NSMutableArray new];

	}

	SBSApplicationShortcutItem *item = [[%c(SBSApplicationShortcutItem) alloc] init];

	item.localizedTitle = @"Edit Home Screen";
	item.type = @"DisqueItem";
	item.bundleIdentifierToLaunch = nil;

	[orig addObject:item];

	return orig;

}

%end */

/* %hook SBUIAction

- (id)initWithTitle:(id)title subtitle:(id)arg2 image:(id)image badgeView:(id)arg4 handler:(id)arg5 {
    
	if ([title isEqualToString:@"Edit Home Screen"]) {
        
		image = [[UIImage imageWithContentsOfFile:@"/Library/Application Support/disque.bundle/rearrange.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

	}

    return %orig;

}

%end */

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