//
//  Person.h
//  CustomIsaSwizzling
//
//  Created by Pluto Y on 9/8/16.
//  Copyright © 2016 pluto-y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger age;

@end
