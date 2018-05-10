//
//  JFSpringPresentationTwoViewController.m
//  TransitionDemo
//
//  Created by sheldon on 19/04/2018.
//  Copyright © 2018 MZD. All rights reserved.
//

#import "JFSpringPresentationTwoViewController.h"
#import "JFSpringPresentTransition.h"
#import "JFInteractiveTransition.h"

@interface JFSpringPresentationTwoViewController ()
@property (nonatomic, strong) JFInteractiveTransition *interactiveDismiss;
@end

@implementation JFSpringPresentationTwoViewController
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"Spring Presentation Two";
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 10;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 100, 300, 50);
    [button setTitle:@"点我或者向下滑动dismiss" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    
    self.transitioningDelegate = self;

    self.interactiveDismiss = [JFInteractiveTransition interactiveTransitionWithTransitionType:JFInteractiveTransitionTypeDismiss gestureDirection:JFInteractiveTransitionGestureDirectionDown];
    [self.interactiveDismiss addPanGestureForViewController:self];
}

- (void)dealloc {
    NSLog(@"%@ -- dealloc", [self class]);
}

- (void)dismiss:(UIButton *)send {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [JFSpringPresentTransition transitionWithTransitionType:JFAnimatedTransitionTypePresent];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [JFSpringPresentTransition transitionWithTransitionType:JFAnimatedTransitionTypeDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    JFInteractiveTransition *interactivePresent = [self.delegate interactiveTransitionForPresent];
    return interactivePresent.interacting ? interactivePresent : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveDismiss.interacting ? self.interactiveDismiss : nil;
}

@end
