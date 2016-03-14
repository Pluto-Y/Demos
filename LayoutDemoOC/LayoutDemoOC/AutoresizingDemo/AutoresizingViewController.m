//
//  AutoresizingViewController.m
//  LayoutDemoOC
//
//  Created by Pluto Y on 16/3/1.
//  Copyright © 2016年 pluto-y. All rights reserved.
//

#import "AutoresizingViewController.h"
#import "AutoresizingView.h"

@interface AutoresizingViewController ()


@property (weak, nonatomic) IBOutlet AutoresizingView *kContentView;
@property (weak, nonatomic) IBOutlet UILabel *autoresizingString;

@end

@implementation AutoresizingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)realodAutoresizingString {
    _autoresizingString.text = @"";
    if (_kContentView.contentView.autoresizingMask == UIViewAutoresizingNone) {
        _autoresizingString.text = @"无";
        return;
    }
    if ((_kContentView.contentView.autoresizingMask & UIViewAutoresizingFlexibleLeftMargin) != 0) {
        _autoresizingString.text = @"左";
    }
    if ((_kContentView.contentView.autoresizingMask  & UIViewAutoresizingFlexibleRightMargin) != 0) {
        _autoresizingString.text = [NSString stringWithFormat:@"%@右", _autoresizingString.text];
    }
    if ((_kContentView.contentView.autoresizingMask & UIViewAutoresizingFlexibleTopMargin) != 0) {
        _autoresizingString.text = [NSString stringWithFormat:@"%@上", _autoresizingString.text];
    }
    if ((_kContentView.contentView.autoresizingMask & UIViewAutoresizingFlexibleBottomMargin) != 0) {
        _autoresizingString.text = [NSString stringWithFormat:@"%@下", _autoresizingString.text];
    }
    if ((_kContentView.contentView.autoresizingMask & UIViewAutoresizingFlexibleHeight) != 0) {
        _autoresizingString.text = [NSString stringWithFormat:@"%@高", _autoresizingString.text];
    }
    if ((_kContentView.contentView.autoresizingMask & UIViewAutoresizingFlexibleWidth) != 0) {
        _autoresizingString.text = [NSString stringWithFormat:@"%@宽", _autoresizingString.text];
    }
}

// 子视图的Autoresizing设置
- (IBAction)left:(id)sender {
    _kContentView.contentView.autoresizingMask = _kContentView.contentView.autoresizingMask |UIViewAutoresizingFlexibleLeftMargin;
    [self realodAutoresizingString];
}

- (IBAction)right:(id)sender {
    _kContentView.contentView.autoresizingMask = _kContentView.contentView.autoresizingMask |UIViewAutoresizingFlexibleRightMargin;
    [self realodAutoresizingString];
}

- (IBAction)up:(id)sender {
    _kContentView.contentView.autoresizingMask = _kContentView.contentView.autoresizingMask |UIViewAutoresizingFlexibleTopMargin;
    [self realodAutoresizingString];
}

- (IBAction)down:(id)sender {
    _kContentView.contentView.autoresizingMask = _kContentView.contentView.autoresizingMask |UIViewAutoresizingFlexibleBottomMargin;
    [self realodAutoresizingString];
}

- (IBAction)height:(id)sender {
    
    _kContentView.contentView.autoresizingMask = _kContentView.contentView.autoresizingMask |UIViewAutoresizingFlexibleHeight;
    [self realodAutoresizingString];
}

- (IBAction)width:(id)sender {
    _kContentView.contentView.autoresizingMask = _kContentView.contentView.autoresizingMask |UIViewAutoresizingFlexibleWidth;
    [self realodAutoresizingString];
}


- (IBAction)reset:(id)sender {
    _kContentView.contentView.autoresizingMask =UIViewAutoresizingNone;
    [self realodAutoresizingString];
}


// 父视图的frame变化
- (IBAction)widthMul2:(id)sender {
    CGRect frame = _kContentView.frame;
    frame.size.width *= 2;
    _kContentView.frame = frame;
}

- (IBAction)widthDiv2:(id)sender {
    CGRect frame = _kContentView.frame;
    frame.size.width /= 2;
    _kContentView.frame = frame;
}

- (IBAction)heightMul2:(id)sender {
    CGRect frame = _kContentView.frame;
    frame.size.height *= 2;
    _kContentView.frame = frame;
}

- (IBAction)heightDiv2:(id)sender {
    CGRect frame = _kContentView.frame;
    frame.size.height /= 2;
    _kContentView.frame = frame;
}


@end
