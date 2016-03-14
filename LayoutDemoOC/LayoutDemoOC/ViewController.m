//
//  ViewController.m
//  LayoutDemoOC
//
//  Created by Pluto Y on 16/2/29.
//  Copyright © 2016年 pluto-y. All rights reserved.
//

#import "ViewController.h"
#import "AutoresizingViewController.h"
#import "AutoLayoutViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  Autoresizing的demo
 */
- (IBAction)gotoAutoresizing:(id)sender {
    AutoresizingViewController *controller = [[AutoresizingViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

/**
 *  AutoLayout的Demo1
 *
 */
- (IBAction)gotoAutoLayout:(id)sender {
    AutoLayoutViewController *controller = [[AutoLayoutViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
