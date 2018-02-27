//
//  YJNMultiTabButton.m
//  FunctionTestOC
//
//  Created by YangJing on 2018/2/27.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import "YJNMultiTabButton.h"
@interface YJNMultiTabButton ()
@property (nonatomic, strong) UIView *badgeView;
@end
@implementation YJNMultiTabButton

-(void)setShowBadge:(BOOL)showBadge {
    _showBadge = showBadge;
    self.badgeView.hidden = !_showBadge;
}

-(void)setBadgeColor:(UIColor *)badgeColor {
    _badgeColor = badgeColor;
    self.badgeView.backgroundColor = _badgeColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIColor *tempBadgeColor = self.badgeColor?self.badgeColor:[UIColor redColor];
    self.badgeView.backgroundColor = tempBadgeColor;
    
    CGRect badgeFrame = CGRectZero;
    badgeFrame.size = CGSizeMake(8, 8);
    
    badgeFrame.origin = CGPointMake((self.titleLabel.frame.size.width+self.titleLabel.frame.origin.x) - badgeFrame.size.height / 2, self.titleLabel.frame.origin.y - badgeFrame.size.height / 2);
    self.badgeView.frame = badgeFrame;
}

- (UIView *)badgeView {
    if(!_badgeView) {
        UIView *badgeView = [UIView new];
        badgeView.layer.cornerRadius = 4;
        badgeView.hidden = YES;
        badgeView.clipsToBounds = YES;
        [self addSubview:_badgeView = badgeView];
    }
    return _badgeView;
}
@end
