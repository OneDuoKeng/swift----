//
//  UploadImageToQianNiu.m
//  DemoApp
//
//  Created by Jerry on 2017/5/8.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

#import "UploadImageToQianNiu.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@implementation UploadImageToQianNiu

- (void)uploadImageToQiNiu:(UIImage *)Image token:(NSString *)token
{
    [self uploadImageToQNFilePath:[self getImagePath:Image] token:token];
}

- (void)uploadImageDataToQiNiu:(UIImage *)Image token:(NSString *)token
{
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSData *data = UIImagePNGRepresentation(Image);
    [upManager putData:data key:nil token:token complete:
     ^(QNResponseInfo *info, NSString *key, NSDictionary *resp)
    {
        NSLog(@"%@", info);
        NSLog(@"%@", resp);
    } option:nil];
}

- (void)uploadImageToQNFilePath:(NSString *)filePath
                          token:(NSString *)token{
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
    }
                                 params:nil
                               checkCrc:NO
                     cancellationSignal:nil];
    
    [upManager putFile:filePath key:nil token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"info ===== %@", info);
        NSLog(@"resp ===== %@", resp);
    }
                option:uploadOption];
}

- (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 1.0);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}

@end
