//
//  JFCircleSpreadTransition.m
//  TransitionDemo
//
//  Created by sheldon on 28/04/2018.
//  Copyright © 2018 MZD. All rights reserved.
//

#import "JFCircleSpreadTransition.h"

@interface JFCircleSpreadTransition() <CAAnimationDelegate>
@property(nonatomic, assign) JFAnimatedTransitionType type;
@property(nonatomic, assign) CGRect circlePointArea;
@end

@implementation JFCircleSpreadTransition
+ (instancetype)transitionWithTransitionType:(JFAnimatedTransitionType)type {
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(JFAnimatedTransitionType)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%@ -- dealloc", [self class]);
}

+ (instancetype)transitionWithTransitionType:(JFAnimatedTransitionType)type circlePointArea:(CGRect)rect {
    JFCircleSpreadTransition *transition = [[self alloc] initWithTransitionType:type];
    transition.circlePointArea = rect;
    return transition;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
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
    [containerView addSubview:toVc.view];

    UIBezierPath *startCycle = [UIBezierPath bezierPathWithOvalInRect:self.circlePointArea];
    CGFloat x = MAX(self.circlePointArea.origin.x, containerView.frame.size.width - self.circlePointArea.origin.x);
    CGFloat y = MAX(self.circlePointArea.origin.y, containerView.frame.size.height - self.circlePointArea.origin.y);
    CGFloat radius = sqrtf((float) (pow(x, 2) + pow(y, 2)));
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:(CGFloat) (M_PI * 2) clockwise:YES];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    toVc.view.layer.mask = maskLayer;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id)startCycle.CGPath;
    animation.toValue = (__bridge id)endCycle.CGPath;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:animation forKey:@"path"];
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVc.view];
    [containerView addSubview:fromVc.view];

    CGFloat x = containerView.frame.size.width;
    CGFloat y = containerView.frame.size.height;
    CGFloat radius = sqrtf((float) (pow(x, 2) + pow(y, 2)));
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:(CGFloat) (M_PI * 2) clockwise:YES];
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithOvalInRect:self.circlePointArea];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    fromVc.view.layer.mask = maskLayer;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id)startCycle.CGPath;
    animation.toValue = (__bridge id)endCycle.CGPath;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:animation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    switch (_type) {
        case JFAnimatedTransitionTypePresent: {
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
        }
            break;
        case JFAnimatedTransitionTypeDismiss: {
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            BOOL isCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancelled];
            if (isCancelled) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
        }
            break;
    }
}

@end
