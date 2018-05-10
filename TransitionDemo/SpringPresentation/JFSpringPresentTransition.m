// JFSpringPresentTransition.m
// TransitionDemo
//
// Created by sheldon on 19/04/2018.
// Copyright (c) 2018 MZD. All rights reserved.
//

#import "JFSpringPresentTransition.h"

@interface JFSpringPresentTransition ()
@property(nonatomic, assign) JFAnimatedTransitionType type;
@end

@implementation JFSpringPresentTransition
+ (instancetype)transitionWithTransitionType:(JFAnimatedTransitionType)type {
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(JFAnimatedTransitionType)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return _type == JFAnimatedTransitionTypePresent ? 0.5 : 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case JFAnimatedTransitionTypePresent: {
            [self presentAnimation:transitionContext];
        }
            break;
        case JFAnimatedTransitionTypeDismiss: {
            [self dismissAnimation:transitionContext];
        }
            break;
    }
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    fromVc.view.hidden = YES;

    // 截屏
    UIView *snapshot = [fromVc.view snapshotViewAfterScreenUpdates:NO];
    snapshot.frame = fromVc.view.frame;

    [containerView addSubview:snapshot];
    [containerView addSubview:toVc.view];
    [containerView sendSubviewToBack:fromVc.view];

    toVc.view.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, 400);

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0f /0.55f options:0 animations:^{
        toVc.view.transform = CGAffineTransformMakeTranslation(0, -400);
        snapshot.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
        if (isCancelled) {
            // 转场失败
            fromVc.view.hidden = NO;
            [snapshot removeFromSuperview];
        }
    }];
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    // 获取截屏
    UIView *snapshot = containerView.subviews[0];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromVc.view.transform = CGAffineTransformIdentity;
        snapshot.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
        if (!isCancelled) { // dismiss 转场成功
            toVc.view.hidden = NO;
            [snapshot removeFromSuperview];
        }
    }];
}

@end
