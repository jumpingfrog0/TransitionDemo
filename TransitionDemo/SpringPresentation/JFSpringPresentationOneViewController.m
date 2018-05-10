//
//  JFSpringPresentationOneViewController.m
//  TransitionDemo
//
//  Created by sheldon on 19/04/2018.
//  Copyright © 2018 MZD. All rights reserved.
//

#import "JFSpringPresentationOneViewController.h"
#import "JFSpringPresentationTwoViewController.h"
#import "JFInteractiveTransition.h"

@interface JFSpringPresentationOneViewController () <JFInteractiveTransitionDelegate>
@property (nonatomic, strong) JFInteractiveTransition *interactivePush;
@end

@implementation JFSpringPresentationOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"Spring Presentation One";

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 100, 300, 50);
    [button setTitle:@"点我或者向上滑动present" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];

    // 交互式转场
    self.interactivePush = [JFInteractiveTransition interactiveTransitionWithTransitionType:JFInteractiveTransitionTypePresent gestureDirection:JFInteractiveTransitionGestureDirectionUp];
    __weak typeof(self) weakSelf = self;
    self.interactivePush.presentBlock = ^{
        [weakSelf present:nil];
    };
    [self.interactivePush addPanGestureForViewController:self];
}

- (void)dealloc {
    NSLog(@"%@ -- dealloc", [self class]);
}

- (void)present:(UIButton *)button {
    JFSpringPresentationTwoViewController *vc = [[JFSpringPresentationTwoViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (JFInteractiveTransition *)interactiveTransitionForPresent {
    return self.interactivePush;
}

@end
