//
//  cryptoTool.h
//
//  Created by jianchengpan on 16/9/1.
//
//

#import <Foundation/Foundation.h>

@interface cryptoTool : NSObject
/**
 *  md5加密
 *
 *  @param bytes   加密字节指针
 *  @param length 字节长度
 *
 *  @return md5值
 */
+(NSString *)md5WithByte:(const char *)bytes andLength:(NSInteger)length;

/**
 *  sha1加密
 *
 *  @param bytes   加密字节指针
 *  @param length 字节长度
 *
 *  @return sha1值
 */
+(NSString *)sha1WithByte:(const void *)bytes andLength:(NSInteger)length;

/**
 *  base64加密
 *
 *  @param bytes  待加密字节指针
 *  @param length 字节长度
 *
 *  @return 加密结果，失败返回nil；
 */
+(NSString *)base64EncodeWithByte:(const void *)bytes andLength:(NSInteger)length;

/**
 *  base64解密
 *
 *  @param bytes  待解密字节指针
 *  @param length 字节长度
 *
 *  @return 解密结果，失败返回nil
 */
+(NSString *)base64DecodeWithByte:(const void *)bytes andLength:(NSInteger)length;

@end
