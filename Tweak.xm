@interface SBUIActionKeylineView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

%hook SBUIActionKeylineView

- (void)layoutSubviews {

	%orig;

	self.hidden = YES;

}

%end