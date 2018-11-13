//
//  UploadImageToQianNiu.h
//  DemoApp
//
//  Created by Jerry on 2017/5/8.
//  Copyright © 2017 www.coolketang.com. All rights reserved.
//

#import "Qiniu/QiniuSDK.h"
#import <UIKit/UIKit.h>

@interface UploadImageToQianNiu : NSObject

- (void)uploadImageDataToQiNiu:(UIImage *)Image token:(NSString *)token;
- (void)uploadImageToQiNiu:(UIImage *)Image token:(NSString *)token;
- (void)uploadImageToQNFilePath:(NSString *)filePath
                          token:(NSString *)token;
- (NSString *)getImagePath:(UIImage *)Image;

@end
