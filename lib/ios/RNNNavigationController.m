
#import "RNNNavigationController.h"
#import "RNNModalAnimation.h"
#import "RNNRootViewController.h"

@implementation RNNNavigationController

- (instancetype)initWithLayoutInfo:(RNNLayoutInfo *)layoutInfo childViewControllers:(NSArray *)childViewControllers options:(RNNNavigationOptions *)options presenter:(RNNNavigationControllerPresenter *)presenter {
	self = [super init];

	self.presenter = presenter;
	self.options = options;
	self.layoutInfo = layoutInfo;
	
	[self setViewControllers:childViewControllers];
	
	return self;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
	return self.viewControllers.lastObject.supportedInterfaceOrientations;
}

- (UINavigationController *)navigationController {
	return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
	return self.getLeafViewController.preferredStatusBarStyle;
}

- (UIModalPresentationStyle)modalPresentationStyle {
	return self.getLeafViewController.modalPresentationStyle;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
	if (self.viewControllers.count > 1) {
		UIViewController *controller = self.viewControllers[self.viewControllers.count - 2];
		if ([controller isKindOfClass:[RNNRootViewController class]]) {
			RNNRootViewController *rnnController = (RNNRootViewController *)controller;
			[rnnController.presenter present:rnnController.options onViewControllerDidLoad:rnnController];
		}
	}
	
	return [super popViewControllerAnimated:animated];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
	return [[RNNModalAnimation alloc] initWithScreenTransition:self.getLeafViewController.options.animations.showModal isDismiss:NO];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
	return [[RNNModalAnimation alloc] initWithScreenTransition:self.getLeafViewController.options.animations.dismissModal isDismiss:YES];
}

- (UIViewController *)getLeafViewController {
	return ((UIViewController<RNNParentProtocol>*)self.topViewController);
}

- (UIViewController *)childViewControllerForStatusBarStyle {
	return self.topViewController;
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
	[_presenter present:self.options onViewControllerDidLoad:self];
}


@end
