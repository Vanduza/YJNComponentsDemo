//
//  UINavigationController+Inspectable.h
//  ShanghunbaoSeller
//
//  Created by Vanduza on 2018/5/18.
//  Copyright © 2018年 杨敬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Inspectable)
@property (nonatomic, strong) IBInspectable UIImage *tabBarImage;
@property (nonatomic, strong) IBInspectable UIImage *tabBarSelectedImage;
@end
