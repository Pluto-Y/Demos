//
//  NSObject+PYIsaSwizzling.h
//  CustomIsaSwizzling
//
//  Created by Pluto Y on 9/8/16.
//  Copyright © 2016 pluto-y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PYIsaSwizzling)

- (void)py_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(void *)context;

- (void)py_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end
