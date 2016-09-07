//
//  NSObject+PYIsaSwizzling.m
//  CustomIsaSwizzling
//
//  Created by Pluto Y on 9/8/16.
//  Copyright © 2016 pluto-y. All rights reserved.
//

#import "NSObject+PYIsaSwizzling.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (PYIsaSwizzling)

static void DefaultSetterForKVO(id self, SEL _cmd, void *value)   {
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *fristLetter = [[[setterName substringFromIndex:3] substringToIndex:1] lowercaseString];
    NSString *otherLetters = [[setterName substringFromIndex:4] substringToIndex:[setterName substringFromIndex:4].length - 1];
    NSString *key = [NSString stringWithFormat:@"%@%@", fristLetter, otherLetters];
    [self willChangeValueForKey:key];
    Class subCls = object_getClass(self);
    Class supCls = class_getSuperclass(subCls);
    struct objc_super superInfo = {
        self,
        supCls
    };
    ((void (*) (void * , SEL, ...))objc_msgSendSuper)(&superInfo, _cmd, value);
    [self didChangeValueForKey:key];
}

- (void)py_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(void *)context {
    // isa-swizzling implement
    NSString *newName = [@"PYKVONotifying_" stringByAppendingString:NSStringFromClass(object_getClass(self))];
    NSString *setterName = [[@"set" stringByAppendingString:[[[keyPath uppercaseString] substringToIndex:1] stringByAppendingString:[keyPath substringFromIndex:1]]] stringByAppendingString:@":"];
    Class subCls = objc_allocateClassPair(object_getClass(self), [newName UTF8String], 0);
    class_addMethod(subCls, NSSelectorFromString(setterName), (IMP)DefaultSetterForKVO, "v@:@");
    objc_registerClassPair(subCls);
    object_setClass(self, subCls);
}

- (void)py_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    Class originCls = class_getSuperclass(object_getClass(self));
    object_setClass(self, originCls);
}

@end
