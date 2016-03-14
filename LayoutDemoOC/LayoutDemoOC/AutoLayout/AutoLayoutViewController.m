//
//  AutoLayoutViewController.m
//  LayoutDemoOC
//
//  Created by Pluto Y on 16/3/6.
//  Copyright © 2016年 pluto-y. All rights reserved.
//

#import "AutoLayoutViewController.h"

@interface AutoLayoutViewController ()

@end

@implementation AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
}

-(void)initialize {
    // 添加一个居中的视图，并且高度和宽度都为20
    UIView *centerView = [[UIView alloc] init];
    centerView.translatesAutoresizingMaskIntoConstraints = NO;
    centerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:centerView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:20]];
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:centerView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self.view layoutIfNeeded];
    
}

@end
