//
//  ViewController.m
//  CustomIsaSwizzling
//
//  Created by Pluto Y on 9/8/16.
//  Copyright © 2016 pluto-y. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+PYIsaSwizzling.h"
#import <objc/runtime.h>
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *person = [[Person alloc] init];
    NSLog(@"before custom isa-swizzling----------------------------");
    NSLog(@"[person class]:%@", [person class]);
    NSLog(@"person super class:%@", [person superclass]);
    NSLog(@"object_getClass:%@", object_getClass(person));
    [person py_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    NSLog(@"after custom isa-swizzling----------------------------");
    NSLog(@"[person class]:%@", [person class]);
    NSLog(@"person super class:%@", [person superclass]);
    NSLog(@"object_getClass:%@", object_getClass(person));
}

@end
