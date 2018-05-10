//
//  JFCircleSpreadViewController.m
//  TransitionDemo
//
//  Created by sheldon on 28/04/2018.
//  Copyright © 2018 MZD. All rights reserved.
//

#import "JFCircleSpreadViewController.h"
#import "JFCircleSpreadPresentViewController.h"

@interface JFCircleSpreadViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation JFCircleSpreadViewController

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Circle Spread Page";
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点击或\n拖动我" forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor grayColor];
    button.layer.cornerRadius = 20;
    button.layer.masksToBounds = YES;
    [self.view addSubview:button];
    button.frame = CGRectMake(0, 0, 40, 40);
    button.center = self.view.center;
    self.button = button;

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [button addGestureRecognizer:pan];
}

- (void)present{
    JFCircleSpreadPresentViewController *presentVC = [[JFCircleSpreadPresentViewController alloc] init];
    presentVC.circlePointArea = self.button.frame;
    [self presentViewController:presentVC animated:YES completion:nil];
}

- (void)pan:(UIPanGestureRecognizer *)panGesture{
    UIView *button = panGesture.view;
    CGPoint newCenter = CGPointMake([panGesture translationInView:panGesture.view].x + button.center.x, [panGesture translationInView:panGesture.view].y + button.center.y);
    button.center = newCenter;
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
}

@end
