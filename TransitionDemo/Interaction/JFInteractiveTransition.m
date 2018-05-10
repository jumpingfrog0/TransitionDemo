//
//  JFInteractiveTransition.m
//  TransitionDemo
//
//  Created by sheldon on 20/04/2018.
//  Copyright © 2018 MZD. All rights reserved.
//

#import "JFInteractiveTransition.h"

@interface JFInteractiveTransition()
@property (nonatomic, weak) UIViewController *controller;
@property(nonatomic, assign) JFInteractiveTransitionGestureDirection direction;
@property(nonatomic, assign) JFInteractiveTransitionType type;
@end

@implementation JFInteractiveTransition
+ (instancetype)interactiveTransitionWithTransitionType:(JFInteractiveTransitionType)type gestureDirection:(JFInteractiveTransitionGestureDirection)direction {
    return [[self alloc] initWithWithTransitionType:type gestureDirection:direction];
}

- (instancetype)initWithWithTransitionType:(JFInteractiveTransitionType)type gestureDirection:(JFInteractiveTransitionGestureDirection)direction {
    if (self = [super init]) {
        _direction = direction;
        _type = type;
    }
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)controller {
    self.controller = controller;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [controller.view addGestureRecognizer:pan];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    // 手势百分比
    CGFloat percent = 0;
    switch (_direction) {
        case JFInteractiveTransitionGestureDirectionLeft: {
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            percent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case JFInteractiveTransitionGestureDirectionRight: {
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            percent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case JFInteractiveTransitionGestureDirectionUp: {
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            percent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        case JFInteractiveTransitionGestureDirectionDown: {
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            percent = transitionY / panGesture.view.frame.size.width;
        }
            break;
    }
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            self.interacting = YES;
            [self startInteraction];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            [self updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            self.interacting = NO;

            // 手势完成结束后判断移动距离是否过半，过半则完成转场，否则取消转场
            if (percent > 0.5) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
        }
            break;
        default:
            break;
    }
}

- (void)startInteraction {
    switch (_type) {
        case JFInteractiveTransitionTypePresent: {
            if (self.presentBlock) {
                self.presentBlock();
            } else {
                NSLog(@"必须传 presentBlock 参数");
            }
        }
            break;
        case JFInteractiveTransitionTypeDismiss: {
            [self.controller dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case JFInteractiveTransitionTypePush: {
            if (self.pushBlock) {
                self.pushBlock();
            } else {
                NSLog(@"必须传 pushBlock 参数");
            }
        }
            break;
        case JFInteractiveTransitionTypePop: {
            [self.controller.navigationController popViewControllerAnimated:YES];
        }
            break;
    }
}
@end
