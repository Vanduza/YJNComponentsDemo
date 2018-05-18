//
//  UINavigationController+Inspectable.m
//  ShanghunbaoSeller
//
//  Created by Vanduza on 2018/5/18.
//  Copyright © 2018年 杨敬. All rights reserved.
//

#import "UINavigationController+Inspectable.h"

@implementation UINavigationController (Inspectable)
-(void)setTabBarImage:(UIImage *)tabBarImage {
    self.tabBarItem.image = [tabBarImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(void)setTabBarSelectedImage:(UIImage *)tabBarSelectedImage {
    self.tabBarItem.selectedImage = [tabBarSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(UIImage *)tabBarImage {
    return self.tabBarItem.image;
}

-(UIImage *)tabBarSelectedImage {
    return self.tabBarItem.selectedImage;
}
@end
