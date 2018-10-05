#import "RNNBottomTabsOptions.h"
#import "RNNTabBarController.h"
extern const NSInteger BLUR_TOPBAR_TAG;

@implementation RNNBottomTabsOptions

- (void)applyOn:(UIViewController *)viewController {
	UITabBarController *tabBarController;
	if ([viewController isKindOfClass:[UITabBarController class]]) {
		tabBarController = (UITabBarController*)viewController;
	} else {
		tabBarController = viewController.tabBarController;
	}
	
	if (self.currentTabIndex) {
		[tabBarController setSelectedIndex:[self.currentTabIndex unsignedIntegerValue]];
	}
	
	if (self.currentTabId) {
		[(RNNTabBarController*)tabBarController setSelectedIndexByComponentID:self.currentTabId];
	}
	
	if (self.testID) {
		tabBarController.tabBar.accessibilityIdentifier = self.testID;
	}
	
	if (self.drawBehind) {
		if ([self.drawBehind boolValue]) {
			[viewController setExtendedLayoutIncludesOpaqueBars:YES];
			viewController.edgesForExtendedLayout |= UIRectEdgeBottom;
		} else {
			[viewController setExtendedLayoutIncludesOpaqueBars:NO];
			viewController.edgesForExtendedLayout &= ~UIRectEdgeBottom;
		}
	}
	
	if (self.backgroundColor) {
		tabBarController.tabBar.barTintColor = [RCTConvert UIColor:self.backgroundColor];
	} else {
		tabBarController.tabBar.barTintColor = nil;
	}
	
	if (self.barStyle) {
		tabBarController.tabBar.barStyle = [RCTConvert UIBarStyle:self.barStyle];
	} else {
		tabBarController.tabBar.barStyle = UIBarStyleDefault;
	}

	if (self.translucent) {
		tabBarController.tabBar.translucent = [self.translucent boolValue];
	} else {
		tabBarController.tabBar.translucent = NO;
	}
	
	if (self.hideShadow) {
		tabBarController.tabBar.clipsToBounds = [self.hideShadow boolValue];
	}

	[self resetOptions];
}

-(UIFont *)tabBarTextFont {
	if (self.fontFamily) {
		return [UIFont fontWithName:self.fontFamily size:self.tabBarTextFontSizeValue];
	}
	else if (self.fontSize) {
		return [UIFont systemFontOfSize:self.tabBarTextFontSizeValue];
	}
	else {
		return nil;
	}
}

-(CGFloat)tabBarTextFontSizeValue {
	return self.fontSize ? [self.fontSize floatValue] : 10;
}

- (void)resetOptions {
	self.currentTabId = nil;
	self.currentTabIndex = nil;
}

@end
