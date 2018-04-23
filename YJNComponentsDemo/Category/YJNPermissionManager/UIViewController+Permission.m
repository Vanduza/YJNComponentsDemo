//
//  UIViewController+Permission.m
//  FunctionTestProduct
//
//  Created by YangJing on 2017/10/12.
//  Copyright © 2017年 YangJing. All rights reserved.
//

#import "UIViewController+Permission.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation UIViewController (Permission)
-(BOOL)yjn_checkPermissionWithCategory:(YJNPermissionCategory)category {
    __block BOOL permission = NO;
    switch (category) {
        case YJNPermissionCategoryCamera: {
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusNotDetermined){
                permission = NO;
            }
            else {
                permission = YES;
            }
            
        }break;
            
        case YJNPermissionCategoryAlbum: {
            ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
            if (status == ALAuthorizationStatusDenied || status == ALAuthorizationStatusRestricted) {
                permission = NO;
            }else {
                permission = YES;
            }
        }break;
            
        case YJNPermissionCategoryMicrophone: {
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                if(granted){
                    permission = YES;
                }else{
                    permission = NO;
                }
            }];
        }break;
            
        default:
            break;
    }
    
    return permission;
}

-(BOOL)yjn_checkPermissionWithCategory:(YJNPermissionCategory)category withTips:(NSString *)tips {
    __block BOOL permisson = YES;
    BOOL hasTips = NO;
    if (!tips) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // 当前应用名称
        NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        if (appCurName) {
            tips = appCurName;
        }else {
            tips = @"";
        }
    }else {
        hasTips = YES;
    }
    switch (category) {
        case YJNPermissionCategoryCamera: {
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                permisson = NO;
                tips = hasTips?tips:[NSString stringWithFormat:@"请在iPhone的“设置-隐私-相机”选项中，允许%@访问您的相机",tips];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法访问相机" message:tips preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancleAction];
                UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }];
                [alert addAction:settingAction];
                [self presentViewController:alert animated:YES completion:nil];
            }

        }break;
            
        case YJNPermissionCategoryAlbum: {
            ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
            if (status == ALAuthorizationStatusDenied || status == ALAuthorizationStatusRestricted) {
                permisson = NO;
                tips = hasTips?tips:[NSString stringWithFormat:@"请在iPhone的“设置-隐私-相册”选项中，允许%@访问您的手机相册",tips];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:tips preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancleAction];
                UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }];
                [alert addAction:settingAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }break;
            
        case YJNPermissionCategoryMicrophone: {
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                if(!granted){
                    permisson = NO;
                    NSString *hint = hasTips?tips:[NSString stringWithFormat:@"请在iPhone的“设置-隐私-麦克风”选项中，允许%@访问您的麦克风",tips];
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:hint preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil];
                    [alert addAction:cancleAction];
                    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if ([[UIApplication sharedApplication] canOpenURL:url]) {
                            [[UIApplication sharedApplication] openURL:url];
                        }
                    }];
                    [alert addAction:settingAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }];
        }
            
        default:
            break;
    
    }
    return permisson;
}
@end
