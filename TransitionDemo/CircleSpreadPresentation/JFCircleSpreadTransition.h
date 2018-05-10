//
//  JFCircleSpreadTransition.h
//  TransitionDemo
//
//  Created by sheldon on 28/04/2018.
//  Copyright © 2018 MZD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFAnimatedTransitionProtocol.h"

@interface JFCircleSpreadTransition : NSObject <UIViewControllerAnimatedTransitioning, JFAnimatedTransitionProtocol>
+ (instancetype)transitionWithTransitionType:(JFAnimatedTransitionType)type circlePointArea:(CGRect)rect;
@end
