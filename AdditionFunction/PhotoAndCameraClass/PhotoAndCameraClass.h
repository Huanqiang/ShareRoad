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

#pragma mark - UIImagePickerController的使用（只能一次获取一张照片或视频）

/*
 方法：从相册选择照片
 参数介绍：
 imagePicker：照片选择控件：UIImagePickerController；
 controllerDelegate：你调用本函数时所在的ViewController
 */
- (UIImagePickerController *)pickImageFromAlbum:(UIImagePickerController *)imagePicker AndController:(id)controllerDelegate;

/*
 方法：相机拍照获取照片
 参数介绍：
 imagePicker：照片选择控件：UIImagePickerController；
 controllerDelegate：你调用本函数时所在的ViewController
 */
- (UIImagePickerController *)pickImageFromCamera:(UIImagePickerController *)imagePicker AndController:(id)controllerDelegate;

#pragma mark - ALAsset的使用（一次获取所有照片或视频）
typedef void (^ DealWithPhotoOperateBlock) (NSMutableArray *);

/*
 方法：一次性获取所有照片
 参数介绍：
 library：自定义的 ALAssetsLibrary
 dealWithPhotoOperateBlock：处理获取图片后的图片处理照片
 */
-(void)getAllPictures:(ALAssetsLibrary *)library AndPhotoOperateBlock:(DealWithPhotoOperateBlock )dealWithPhotoOperateBlock;

/*
 方法：根据路径获取照片的ALAsset
 参数介绍：
 library：自定义的 ALAssetsLibrary
 urlArr：路径数组
 dealWithPhotoOperateBlock：处理获取图片后的图片处理照片
 */
- (void)getAlassetWithImageURL:(ALAssetsLibrary *)library AndURLArr:(NSMutableArray *)urlArr AndPhotoOperateBlock:(DealWithPhotoOperateBlock )dealWithPhotoOperateBlock;

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
