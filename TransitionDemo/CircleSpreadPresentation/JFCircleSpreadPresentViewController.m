//
//  JFCircleSpreadPresentViewController.m
//  TransitionDemo
//
//  Created by sheldon on 28/04/2018.
//  Copyright © 2018 MZD. All rights reserved.
//

#import "JFCircleSpreadPresentViewController.h"
#import "JFInteractiveTransition.h"
#import "JFCircleSpreadTransition.h"

@interface JFCircleSpreadPresentViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) JFInteractiveTransition *interactiveDismiss;
@end

@implementation JFCircleSpreadPresentViewController

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor cyanColor];
    self.title = @"Circle Spread Presented Page";
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向下滑动dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 50, self.view.frame.size.width, 50);
    [self.view addSubview:button];

    self.transitioningDelegate = self;
    self.modalTransitionStyle = UIModalPresentationCustom;

    self.interactiveDismiss = [JFInteractiveTransition interactiveTransitionWithTransitionType:JFInteractiveTransitionTypeDismiss gestureDirection:JFInteractiveTransitionGestureDirectionDown];
    [self.interactiveDismiss addPanGestureForViewController:self];
}

- (void)dealloc {
    NSLog(@"%@ -- dealloc", [self class]);
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [JFCircleSpreadTransition transitionWithTransitionType:JFAnimatedTransitionTypePresent circlePointArea:self.circlePointArea];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [JFCircleSpreadTransition transitionWithTransitionType:JFAnimatedTransitionTypeDismiss circlePointArea:self.circlePointArea];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveDismiss ? self.interactiveDismiss : nil;
}

@end
