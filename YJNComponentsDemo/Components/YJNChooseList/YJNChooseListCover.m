//
//  YJNChooseListCover.m
//  YJNComponentsDemo
//
//  Created by YangJing on 2018/1/12.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import "YJNChooseListCover.h"

@implementation YJNChooseListCover

-(instancetype)init {
    if (self = [super init]) {
        [self p_initView];
    }
    return self;
}

-(void)p_initView {
//    self.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    self.backgroundColor = [UIColor redColor];
    
    [self addSubview:self.infoLabel];
    self.infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *label_centerX = [NSLayoutConstraint constraintWithItem:self.infoLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *label_centerY = [NSLayoutConstraint constraintWithItem:self.infoLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:20];
    [self addConstraints:@[label_centerX,label_centerY]];
    
    [self addSubview:self.indicator];
    self.indicator.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *ind_centerX = [NSLayoutConstraint constraintWithItem:self.indicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *ind_centerY = [NSLayoutConstraint constraintWithItem:self.indicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-10];
    NSLayoutConstraint *ind_heihgt = [NSLayoutConstraint constraintWithItem:self.indicator attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:20];
    NSLayoutConstraint *ind_width = [NSLayoutConstraint constraintWithItem:self.indicator attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:20];
    [self addConstraints:@[ind_centerX,ind_centerY]];
    [self.indicator addConstraints:@[ind_width,ind_heihgt]];
}

-(UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.text = @"TestErrorTips";
        _infoLabel.font = [UIFont systemFontOfSize:13.0f];
        _infoLabel.textColor = [UIColor colorWithRed:0.71 green:0.71 blue:0.71 alpha:1.0];
    }
    return _infoLabel;
}

-(UIActivityIndicatorView *)indicator {
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _indicator;
}

@end
