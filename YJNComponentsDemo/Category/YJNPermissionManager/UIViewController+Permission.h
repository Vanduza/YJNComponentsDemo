//
//  UIViewController+Permission.h
//  FunctionTestProduct
//
//  Created by YangJing on 2017/10/12.
//  Copyright © 2017年 YangJing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,YJNPermissionCategory) {
    YJNPermissionCategoryCamera     = 0,
    YJNPermissionCategoryAlbum      = 1,
    YJNPermissionCategoryMicrophone = 2,
};
@interface UIViewController (Permission)

/**
 检测指定类别的权限状态

 @param category 权限类别
 @return 是否有此权限(简单检测)
 */
-(BOOL)yjn_checkPermissionWithCategory:(YJNPermissionCategory)category;

/**
 检测指定类别的权限状态，并直接导航至设置页面

 @param category 权限类别
 @param tips 提示语
 @return 是否有此权限
 */
-(BOOL)yjn_checkPermissionWithCategory:(YJNPermissionCategory)category withTips:(NSString *)tips;
@end
