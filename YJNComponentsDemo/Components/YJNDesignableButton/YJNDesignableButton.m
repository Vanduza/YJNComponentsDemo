//
//  YJNDesignableButton.m
//  FunctionTestOC
//
//  Created by YangJing on 2018/5/16.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import "YJNDesignableButton.h"

@implementation YJNDesignableButton {
    CGRect _titleRect;
    CGRect _imageRect;
}

-(void)setType:(NSInteger)type {
    _type = type;
    [self p_layoutButton];
}

-(void)setPadding:(CGFloat)padding {
    _padding = padding;
    [self p_layoutButton];
}

-(void)p_layoutButton {
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;

    labelWidth = self.titleLabel.intrinsicContentSize.width;
    labelHeight = self.titleLabel.intrinsicContentSize.height;
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    CGFloat space = self.padding;
    
    switch (_type) {
        case YJNDesignableButtonTypeTextBottom: {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }break;
        case YJNDesignableButtonTypeTextRight: {
        imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
        labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case YJNDesignableButtonTypeTextTop: {
        imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
        labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case YJNDesignableButtonTypeTextLeft: {
        imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
        labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}
@end
