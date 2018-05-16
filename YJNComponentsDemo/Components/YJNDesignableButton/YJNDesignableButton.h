//
//  YJNDesignableButton.h
//  FunctionTestOC
//
//  Created by YangJing on 2018/5/16.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger,YJNDesignableButtonType) {
    YJNDesignableButtonTypeTextTop,
    YJNDesignableButtonTypeTextLeft,
    YJNDesignableButtonTypeTextBottom,
    YJNDesignableButtonTypeTextRight,
};

IB_DESIGNABLE
@interface YJNDesignableButton : UIButton
@property (nonatomic, assign) IBInspectable CGFloat padding;
@property (nonatomic, assign) IBInspectable NSInteger type;
@end
