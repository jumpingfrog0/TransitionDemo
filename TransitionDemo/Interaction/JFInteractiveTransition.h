//
//  JFInteractiveTransition.h
//  TransitionDemo
//
//  Created by sheldon on 20/04/2018.
//  Copyright © 2018 MZD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JFInteractiveTransitionGestureDirection) { // 手势的方向
    JFInteractiveTransitionGestureDirectionLeft = 0,
    JFInteractiveTransitionGestureDirectionRight,
    JFInteractiveTransitionGestureDirectionUp,
    JFInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, JFInteractiveTransitionType) { // 手势控制的转场类型
    JFInteractiveTransitionTypePresent = 0,
    JFInteractiveTransitionTypeDismiss,
    JFInteractiveTransitionTypePush,
    JFInteractiveTransitionTypePop
};

typedef void (^interactBlock)();

@interface JFInteractiveTransition : UIPercentDrivenInteractiveTransition
/**
 * 正在触发手势
 */
@property(nonatomic, assign) BOOL interacting;
@property(nonatomic, copy) interactBlock presentBlock;
@property(nonatomic, copy) interactBlock pushBlock;

+ (instancetype)interactiveTransitionWithTransitionType:(JFInteractiveTransitionType)type gestureDirection:(JFInteractiveTransitionGestureDirection)direction;
- (instancetype)initWithWithTransitionType:(JFInteractiveTransitionType)type gestureDirection:(JFInteractiveTransitionGestureDirection)direction;

- (void)addPanGestureForViewController:(UIViewController *)controller;
@end
