//
//  AutoresizingView.m
//  LayoutDemoOC
//
//  Created by Pluto Y on 16/3/1.
//  Copyright © 2016年 pluto-y. All rights reserved.
//

#import "AutoresizingView.h"

@interface AutoresizingView(){
    CGSize orignalSize;
    CGRect subOrignalFrame;
}

@end

@implementation AutoresizingView

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        subOrignalFrame = CGRectMake(self.frame.size.width / 2.0 - 20, self.frame.size.height / 2.0 - 20, 40, 40);
        _contentView.autoresizingMask = UIViewAutoresizingNone;
        _contentView = [[UIView alloc] initWithFrame:subOrignalFrame];
        _contentView.backgroundColor = [UIColor blueColor];
        [self addSubview:_contentView];
        
        UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [self addGestureRecognizer:pinGesture];
        orignalSize = self.frame.size;
        
    }
    return self;
}

-(void)handleGesture:(UIPinchGestureRecognizer *) gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        self.frame = (CGRect){self.frame.origin, orignalSize};
    }
    
    NSLog(@"handleGesture, scale");
    CGFloat width = self.frame.size.width * gesture.scale;
    CGFloat height = self.frame.size.height * gesture.scale;
    self.frame = (CGRect){self.frame.origin, CGSizeMake(width, height)};
}


-(void)layoutSubviews {
    NSLog(@"contentView.frame:%@", NSStringFromCGRect(_contentView.frame));
}

@end
