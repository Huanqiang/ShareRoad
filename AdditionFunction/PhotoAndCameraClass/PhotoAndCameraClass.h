//
//  PhotoAndCameraClass.h
//  MyPrivacy
//
//  Created by 枫叶 on 14-5-31.
//  Copyright (c) 2014年 skywang1994_枫叶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoAndCameraClass : NSObject

+ (id)shareInstance;
- (UIImagePickerController *)pickImageFromCamera:(UIImagePickerController *)imagePicker AndController:(id)controllerDelegate;
#pragma mark - 保存照片
/*
 方法：保存照片至Documents
 参数介绍：
 imageData：照片信息；
 （把图片转成NSData： UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];）
 */
- (NSString *)saveImageToDocuments:(NSData *)imageData AndImageName:(NSString *)imageName;

/*
 方法：用imageName获取image
 参数介绍：
 imageName：照片名字；
 返回值介绍：返回UIImage；
 */
- (NSDictionary *)getImageWithImageName:(NSString *)imageName;

/*
 方法：用imageName获取imageURL
 参数介绍：
 imageName：照片名字；
 返回值介绍：返回URLString；
 */
- (NSString *)getImageURLString:(NSString *)imageName;

@end
