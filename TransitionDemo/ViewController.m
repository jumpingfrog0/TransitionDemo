//
//  ViewController.m
//  TransitionDemo
//
//  Created by sheldon on 18/04/2018.
//  Copyright © 2018 MZD. All rights reserved.
//

#import "ViewController.h"
#import "JFSpringPresentationOneViewController.h"
#import "JFCircleSpreadViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)clickSpringPresentationButton:(id)sender {
    JFSpringPresentationOneViewController *vc = [[JFSpringPresentationOneViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickCircleSpreadPresentationButton:(id)sender {
    JFCircleSpreadViewController *vc = [[JFCircleSpreadViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
