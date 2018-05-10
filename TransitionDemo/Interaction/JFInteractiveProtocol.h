// JFInteractiveProtocol.h
// TransitionDemo
//
// Created by sheldon on 20/04/2018.
// Copyright (c) 2018 MZD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JFInteractiveTransition;

@protocol JFInteractiveTransitionDelegate <NSObject>
@optional
- (JFInteractiveTransition *)interactiveTransitionForPresent;
@end

@protocol JFInteractiveTransitionProtocol <NSObject>
@property (nonatomic, weak) id<JFInteractiveTransitionDelegate> delegate;
@end