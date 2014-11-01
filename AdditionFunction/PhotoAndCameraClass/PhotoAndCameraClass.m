//
//  PhotoAndCameraClass.m
//  MyPrivacy
//
//  Created by 枫叶 on 14-5-31.
//  Copyright (c) 2014年 skywang1994_枫叶. All rights reserved.
//

#import "PhotoAndCameraClass.h"

@implementation PhotoAndCameraClass


static PhotoAndCameraClass *instnce;

#pragma mark - 外部文件可以直接访问PhotoAndCameraClass内部函数
+ (id)shareInstance {
    if (instnce == nil) {
        instnce = [[[self class] alloc] init];
    }
    return instnce;
}

#pragma mark - 从相册获取照片
- (UIImagePickerController *)pickImageFromAlbum:(UIImagePickerController *)imagePicker AndController:(id)controllerDelegate
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = controllerDelegate;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    
    return imagePicker;
    
//    [self presentViewController:imagePicker animated:YES completion:^{}];
}

#pragma mark - 从相册获取照片
- (UIImagePickerController *)pickImageFromCamera:(UIImagePickerController *)imagePicker AndController:(id)controllerDelegate
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = controllerDelegate;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])  {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        NSLog(@"你这是模拟器！");
    }
    
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    
    return imagePicker;
}

#pragma mark - UIImagePickerController的使用（只能一次获取一张照片或视频）
static int count = 0;

-(void)getAllPictures:(ALAssetsLibrary *)library AndPhotoOperateBlock:(DealWithPhotoOperateBlock )dealWithPhotoOperateBlock{
    NSMutableArray *imageOfAlAssetArr = [NSMutableArray array];

    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];

    void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result != nil) {
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                //获取了路径
                NSURL *url= (NSURL*) [[result defaultRepresentation] url];
                //根据路径重新获取了每一个照片的 asset
                [library assetForURL:url
                         resultBlock:^(ALAsset *asset) {
                             [imageOfAlAssetArr addObject:asset];
                             if ([imageOfAlAssetArr count] == count)
                             {
                                 //处理照片操作
                                 dealWithPhotoOperateBlock(imageOfAlAssetArr);
                             }
                         }
                        failureBlock:^(NSError *error){
                            NSLog(@"operation was not successfull!");
                        }];
            }
        }
    };
    
    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
    void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            [group enumerateAssetsUsingBlock:assetEnumerator];
            [assetGroups addObject:group];
            count=[group numberOfAssets];
        }
    };
    
    assetGroups = [[NSMutableArray alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:assetGroupEnumerator
                         failureBlock:^(NSError *error) {
                             NSLog(@"There is an error");
                         }];
}


- (void)getAlassetWithImageURL:(ALAssetsLibrary *)library AndURLArr:(NSMutableArray *)urlArr AndPhotoOperateBlock:(DealWithPhotoOperateBlock )dealWithPhotoOperateBlock
{
    NSMutableArray *imageOfAlAssetArr = [NSMutableArray array];
    
    for (NSURL *url in urlArr) {
        [library assetForURL:url
                 resultBlock:^(ALAsset *asset) {
                     [imageOfAlAssetArr addObject:asset];
                     if ([imageOfAlAssetArr count] == [urlArr count])
                     {
                         //处理照片AlAsset操作
                         dealWithPhotoOperateBlock(imageOfAlAssetArr);
                     }
                 }
                failureBlock:^(NSError *error){
                    NSLog(@"operation was not successfull!");
                }];

    }
}

#pragma mark - 保存照片到documents

//保存单张照片到documents,返回文件名
- (NSString *)saveImageToDocuments:(NSData *)imageData AndImageName:(NSString *)imageName
{
    //这里将图片放在沙盒的documents文件夹中
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:[NSString stringWithFormat:@"/%@",imageName]] contents:imageData attributes:nil];
    
//    //得到选择后沙盒中图片的完整路径
//    NSString *imagePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  [NSString stringWithFormat:@"/%@.png",imageName]];
    
    return imageName;
}


- (NSString *)getImageURLString:(NSString *)imageName {
    //这里将图片放在沙盒的documents文件夹中
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //得到选择后沙盒中图片的完整路径
    NSString *imagePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  [NSString stringWithFormat:@"/%@",imageName]];
    
    return imagePath;
}

- (UIImage *)getImageWithImageName:(NSString *)imageName {

    UIImage *image = [UIImage imageWithContentsOfFile:[self getImageURLString:imageName]];
    
    return image;
}

@end
