# No3DLines

```objective-c
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

}```
