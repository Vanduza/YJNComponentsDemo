//
//  cryptoTool.m
//  yiyideyi
//
//  Created by jianchengpan on 16/9/1.
//
//

#import "cryptoTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation cryptoTool

+(NSString *)md5WithByte:(const char *)byte andLength:(NSInteger)length{
    NSMutableString *md5String = [NSMutableString string];

    unsigned char md5Result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(byte,(CC_LONG)strlen(byte),md5Result);
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [md5String appendFormat:@"%02x",md5Result[i]];
    }
    return md5String;
}

+(NSString *)sha1WithByte:(const void *)byte andLength:(NSInteger)length{
    NSMutableString *sha1String = [NSMutableString string];
    
    unsigned char sha1Result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(byte,(CC_LONG)length,sha1Result);
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i ++) {
        [sha1String appendFormat:@"%02x",sha1Result[i]];
    }
    return sha1String;
}

+(NSString *)base64EncodeWithByte:(const void *)bytes andLength:(NSInteger)length{
    return base64Encode(bytes, length);
}

+(NSString *)base64DecodeWithByte:(const void *)bytes andLength:(NSInteger)length{
    return base64Decode(bytes, length);
}

#pragma mark - suporte method

NSString *base64Encode(const void *bytes,NSInteger len){
    NSString *base64String = nil;
    char *base64Result = malloc( (len + 2) /3 * 4);
    if (base64Result == NULL)
        return base64String;
    
    const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    NSInteger resultIndex = 0;
    for (int i = 0; i < len; ) {
        char encodeStep[3] = {0,0,0};
        int stepLength = 0;
        while (stepLength < 3 && i < len) {
            encodeStep[stepLength ++] = ((char *)bytes)[i++];
        }
        base64Result[resultIndex ++] = encodingTable[(encodeStep[0] & 0xfc) >> 2];
        base64Result[resultIndex ++] = encodingTable[((encodeStep[0] & 0x3) << 4) | ((encodeStep[1] & 0xf0) >> 4)];
        if(stepLength > 1)
            base64Result[resultIndex ++] = encodingTable[((encodeStep[1] & 0x0f) << 2) | ((encodeStep[2] & 0xc0) >> 6)];
        else
            base64Result[resultIndex ++] = '=';
        if(stepLength > 2)
            base64Result[resultIndex ++] = encodingTable[encodeStep[2] & 0x3f];
        else
            base64Result[resultIndex ++] = '=';
        
    }
    base64String = [NSString stringWithUTF8String:base64Result];
    free(base64Result);
    
    return base64String;
}

char getdecodeCharWithEncodeChar(char c){
    char a = 0;
    if(c >= 'A' && c <= 'Z')
        a = c - 65;
    else if (c >= 'a' && c <= 'z')
        a = c - 71;
    else if (c >= '0' && c <= '9')
        a = c + 4;
    else if (c == '+')
        a = 62;
    else if (c == '/')
        a = 63;
    else
        a = '\0';
    return a;
    
}

NSString *base64Decode(const void *bytes,NSInteger len){
    NSString *decodeString = nil;
    
    char *decodeResult = malloc((len + 3) / 4 * 3);
    if(decodeResult == NULL)
        return decodeString;
    
    int decodeIndex = 0;
    for(int i = 0 ; i <  len;){
        char decodeStep[4] = {0,0,0,0};
        for(int j = 0; j < 4 ; j++){
            decodeStep[j] = ((const char *)bytes)[i++];
        }
        
        char temp1 = getdecodeCharWithEncodeChar(decodeStep[0]);
        char temp2 = getdecodeCharWithEncodeChar(decodeStep[1]);
        decodeResult[decodeIndex ++] = ((temp1 & 0x3f) << 2) | ((temp2 & 0x30) >> 4);
        
        char temp3 = getdecodeCharWithEncodeChar(decodeStep[2]);
        if(temp3 == '\0'){
            decodeResult[decodeIndex ++] = temp3;
            break;
        }else{
            decodeResult[decodeIndex ++] = ((temp2 & 0x0f) << 4) | ((temp3 & 0x3c) >> 2);
        }
        
        char temp4 = getdecodeCharWithEncodeChar(decodeStep[3]);
        if(temp4 == '\0'){
            decodeResult[decodeIndex ++] = temp4;
            break;
        }else{
            decodeResult[decodeIndex ++] = ((temp3 & 0x03) << 6) | (temp4 & 0x3f);
        }
    }
    decodeResult[decodeIndex] = '\0';
    
    decodeString = [NSString stringWithUTF8String:decodeResult];
    free(decodeResult);
    return [decodeString copy];
}

@end
