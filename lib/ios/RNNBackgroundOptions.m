#import "RNNBackgroundOptions.h"

@implementation RNNBackgroundOptions

- (void)applyOnNavigationController:(UINavigationController *)navigationController {
	if (self.color && ![self.color isKindOfClass:[NSNull class]]) {
		UIColor* backgroundColor = [RCTConvert UIColor:self.color];
		navigationController.navigationBar.barTintColor = backgroundColor;
	}
	
	if (self.clipToBounds) {
		navigationController.navigationBar.clipsToBounds = [self.clipToBounds boolValue];
	} else {
		navigationController.navigationBar.clipsToBounds = NO;
	}
}

@end
