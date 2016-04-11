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
    
    // iOS 6提供的创建方法以及添加方法
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:20]];
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:centerView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
    
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    bottomView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:bottomView];
    
    // iOS 9提供的创建方法以及 iOS 8提供的激活方法
    [NSLayoutConstraint activateConstraints:@[[bottomView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                              [bottomView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [bottomView.widthAnchor constraintEqualToConstant:40],
                                              [bottomView.heightAnchor constraintEqualToConstant:40]]];
    
    UILabel *longLbl = [[UILabel alloc] init];
    longLbl.translatesAutoresizingMaskIntoConstraints = NO;
    longLbl.text = @"我是一个很长很长很长很长的Lbl";
    [longLbl setContentCompressionResistancePriority:750 forAxis:UILayoutConstraintAxisHorizontal];
    [self.view addSubview:longLbl];
    
    NSLayoutConstraint *widthConstraint = [longLbl.widthAnchor constraintEqualToConstant:10];
    widthConstraint.priority = 249;
    [NSLayoutConstraint activateConstraints:@[[longLbl.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor], [longLbl.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor], widthConstraint]];
    
    
    [self.view layoutIfNeeded];
}

@end
