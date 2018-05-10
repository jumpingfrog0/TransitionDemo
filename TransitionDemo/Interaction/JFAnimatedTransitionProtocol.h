// JFAnimatedTransitionProtocol.h
// TransitionDemo
//
// Created by sheldon on 02/05/2018.
// Copyright (c) 2018 MZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JFAnimatedTransitionProtocol <NSObject>
typedef NS_ENUM(NSUInteger, JFAnimatedTransitionType) {
    JFAnimatedTransitionTypePresent = 0,
    JFAnimatedTransitionTypeDismiss
};
+ (instancetype)transitionWithTransitionType:(JFAnimatedTransitionType)type;
- (instancetype)initWithTransitionType:(JFAnimatedTransitionType)type;
@end